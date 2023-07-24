
class Vipr < ApplicationRecord
 
  validates :invoice_no,:invoice_date, presence: true
  validates :po_no, presence: true,  if: -> {source == "PO"}
  #validates :net_payment, presence:true ,if: -> {source != "PO"}
 
  has_many :vipr_items, dependent: :destroy
  accepts_nested_attributes_for :vipr_items, allow_destroy: true #reject_if: proc { |att| att['no'].blank? }
  
  before_validation :calculate_totals, on: :create
  before_save :default_values



  validate :check_openamount
  validate :refresh_status_po, on: :update

  ##before_save :calculate_totals
  has_many_attached :attachment1




  after_create :SaveBaris, if: -> {source != "PO"}
  after_create :CopyFromPO, if: -> {source == "PO"}
  after_create :set_approval
  after_create :send_mail
  #validate :check_approval


  




 attr_accessor :vipr_item_temp


  
  def default_values
    self.status ||='Draft' 
     
  end





private 

  def check_baris
    # when creating a new contact: making sure at least one team exists
    return errors.add :base, "VIPR Items is missing!" unless vipr_items.length > 0

    # when updating an existing contact: Making sure that at least one team would exist
    return errors.add :base, "VIPR Items is missing!" if vipr_items.reject{|vipr_items| vipr_items._destroy == true}.empty?
  end


  def set_approval
    # set approval
    vipr = Vipr.where(:id => self.id).first 
    p_currency = 0

    if vipr.currency =='USD'
      p_currency = 14000
    else
      if vipr.currency =='SGD'
        p_currency = 10500
      else
         if vipr.currency =='JPY'
            p_currency = 135
         else
            p_currency = 1
         end
      end
    end     
    


if vipr.source == 'PO' && vipr.source == 'Non PO'
       source = 'PRPAY'
    else
       source = 'SETT'
    end
      
   if vipr.net_payment.nil?
     vipr.net_payment = 0

   end

     

    if PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).nil? == false
         vipr.approval1 = PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).apv1
         
         if (vipr.net_payment*p_currency) < PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).apv2_amount
            vipr.approval2 = PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).apv2
            vipr.approval3 = ''
            vipr.approval4 = ''
            
         else
            if (vipr.net_payment*p_currency) < PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).apv3_amount
               vipr.approval2 = PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).apv2
               vipr.approval3 = PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).apv3
               vipr.approval4 = ''
               
            else
               vipr.approval2 = PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).apv2
               vipr.approval3 = PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).apv3
               vipr.approval4 = PrApproval.find_by(requester: vipr.req_email, approval_group: vipr.approval_group,trans: source).apv4

            end   
         end 
      end


      
      if ViprReview.find_by(order: 0).nil? == false
         vipr.verify1 = ViprReview.find_by(order: 0).name
         vipr.verifyemail1 = ViprReview.find_by(order: 0).email
      end
      if ViprReview.find_by(order: 1).nil? == false
        if (vipr.net_payment*p_currency) < ViprReview.find_by(order: 1).plafond
           vipr.verify2 = ViprReview.find_by(order: 1).name
           vipr.verifyemail2 = ViprReview.find_by(order: 1).email
        else
           
           vipr.verify2 = ViprReview.find_by(order: 1).name
           vipr.verifyemail2 = ViprReview.find_by(order: 1).email
        end  
      end
      if ViprReview.find_by(order: 2).nil? == false
        if (vipr.net_payment*p_currency) < ViprReview.find_by(order: 2).plafond
           vipr.verify3 = ViprReview.find_by(order: 2).name
           vipr.verifyemail3 = ViprReview.find_by(order: 2).email
        else
           vipr.verify3 = ''
           vipr.verifyemail3 = ''
        end  
      end
      




      vipr.save
  end 

  def check_approval
    #byebug
    if approval1.nil? && approval2.nil? && approval3.nil?
        errors.add(:vipr, " : You're not listed in VIPR User Matrix. Please contact your system administrator")
    end
  end


  def check_openamount
    #byebug
    if self.net_payment == 0
        errors.add(:vipr, " : Open Purchase Order Amount is 0")
    end
  end


  def calculate_totals

     
      self.vipr_items.each do |i|
        if i.quantity.nil? || i.price.nil?
           self.total = 0
           self.subtotal = 0

        else
           self.total += (i.quantity * i.price)
           self.subtotal += (i.quantity * i.price)
           
        end 
      end
        
      if self.is_vat == true
           self.vat = self.total*0.1
           self.grand_total = self.total*1.1
      else
           self.vat = 0
           self.grand_total = self.total
      end
  end


  def refresh_status_po
    unless self.po_no.nil? || self.po_no == ""
     po = PurchaseOrder.where(:sapno => self.po_no, :supplier => self.supplier).first

      if self.status =='Approved' 
       
        po.status = "Closed"
        po.save
      end
       if self.status =='Rejected' 
        
        po.status = "Approved"
        po.save
      end

    end    
  end


  def send_mail
    vipr = Vipr.where(:id => self.id).first 
    
    #Kirim Email Tergantung Otorisasi
    
    
    if vipr.approval1.nil? || vipr.approval1 == ""
        if vipr.approval2.nil? || vipr.approval2 == ""
          if vipr.approval3.nil? || vipr.approval3 == ""
             UserMailer.reqapv_vipr1(vipr,vipr.approval4).deliver_later
          else
             UserMailer.reqapv_vipr1(vipr,vipr.approval3).deliver_later
          end
        else
             UserMailer.reqapv_vipr1(vipr,vipr.approval2).deliver_later
        end   
    else
        UserMailer.reqapv_vipr1(vipr,vipr.approval1).deliver_later
    end  
  end

  def CopyFromPO

      popo = PurchaseOrder.where(:sapno => self.po_no, :supplier => self.supplier).first

      po_item = PurchaseOrderItem.where(:purchase_order_id => popo.id)

      linetotal = 0
     
        po_item.each do |vipr_item|
          
          ViprItem.create(no: self.po_no ,
            vipr_id: self.id,
            costcenter: vipr_item.costcenter ,
            
            product: vipr_item.product ,
            description: vipr_item.description ,
            spesification: vipr_item.spesification ,
             
            dept: vipr_item.dept,

            price: vipr_item.price,
            quantity: vipr_item.quantity,
            amount:  vipr_item.amount

            )
            linetotal = linetotal + (vipr_item.price * vipr_item.quantity )   
        
                
        end
        

        po_header = PurchaseOrder.where(:sapno => self.po_no, :supplier => self.supplier).first      
      
      
        vipr = Vipr.where(:id => self.id).first 
        vipr.totbefdisc = po_header.totbefdisc
        vipr.subtotal = po_header.subtotal


          
        
        vipr.vat = po_header.vat 
        vipr.total = po_header.total
        vipr.doctype = po_header.doctype
        vipr.grand_total = po_header.grand_total
        vipr.dp_amount = (self.dp/100)*po_header.grand_total
         
        vipr.net_payment  = (self.dp/100)*po_header.grand_total
         
             
      
         vipr.save

         po = PurchaseOrder.where(:sapno => self.po_no, :supplier => self.supplier).first 
         po.net_payment = po.net_payment +  (self.dp/100)*po_header.grand_total

         po.save
  
  end



  def SaveBaris


    linetotal = 0
    grand_total = 0

                           
    
    unless @vipr_item_temp.nil?
      @vipr_item_temp = "[" + @vipr_item_temp + "]"
      @vipr_item_temp = JSON.parse(@vipr_item_temp)
    end



    unless @vipr_item_temp.nil?


      if @vipr_item_temp.kind_of?(Array)
         
          
          #if @po_item_temp.to_s.count('[') == 1
          #   @po_item_temp = [ @po_item_temp ]
          #
      
          #end
      
            @vipr_item_temp.each do |item|
          
            ViprItem.create(no: self.id ,
                    vipr_id: self.id,
                    costcenter: item[0]["purch"] ,
                    product: item[0]["product"] ,
                    description: item[0]["description"] ,
                    spesification: item[0]["spesification"] ,
                    dept: item[0]["dept"],
                    price: item[0]["price"],
                    quantity: item[0]["quantity"],
                    amount:  (item[0]["price"].to_i * item[0]["quantity"].to_i )

                  )

               
             linetotal = linetotal + (item[0]["price"].to_i * item[0]["quantity"].to_i )
            
           
           
          end
      
      end                              
    end
     vipr = Vipr.where(:id => self.id).first 
     vipr.totbefdisc = linetotal
     vipr.subtotal = linetotal

      
     if self.is_vat == true

         vipr.vat = linetotal * 0.1
         vipr.total = linetotal 
         vipr.grand_total = linetotal * 1.1
         grand_total = linetotal * 1.1
         
          
      else
         vipr.vat = 0
         vipr.total = linetotal
         vipr.grand_total = linetotal
         grand_total = linetotal
         
      end
      if self.source != 'PO' 

         vipr.dp_amount = grand_total
         vipr.dp = 100
         vipr.net_payment  = grand_total

      else
         vipr.dp_amount = (self.dp/100)*grand_total
         po = PurchaseOrder.where(:sapno => self.po_no, :supplier => self.supplier).first 
         po.net_payment = po.net_payment +  ((self.dp/100)*grand_total)

         po.save
      
         vipr.net_payment  = (self.dp/100)*grand_total

      end 
      
      vipr.save
      vipr_item_temp = nil
      @vipr_item_temp = nil       
  end




end




