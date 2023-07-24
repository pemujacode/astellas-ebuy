class PurchaseOrder < ApplicationRecord
  require 'json'
  

  has_many :purchase_order_items, dependent: :destroy
  accepts_nested_attributes_for :purchase_order_items, allow_destroy: true
  before_validation :calculate_totals, on: :create


  before_save :default_values

  #validates :subtotal,:grand_total, numericality: { other_than: 0 }
  #validates :subtotal, numericality: { greater_than: 3000000, message: '/ PO dibawah 3jt tidak perlu lewat Web Aplikasi' }
  
  validates :supplier,:currency,:doctype,:po_date, presence: true
  validate :check_approval
  
  has_many_attached :attachment1
  after_create :SaveBaris,:send_mail
  
 #validate :check_baris
 attr_accessor :po_item_temp




  def subtotal
   
      self.purchase_order_items.map { |item| 
      unless item.quantity.nil? || item.price.nil?
        item.quantity * item.price 
      end
      }.sum
    
  end

    
  def vat_calculated
    (subtotal) * (11.0 / 100.0)
  end


  def default_values
    self.status ||='Draft' 
  end



private 


def check_baris
    # when creating a new contact: making sure at least one team exists
    return errors.add :base, "PO Items is missing!" unless purchase_order_items.length > 0

    # when updating an existing contact: Making sure that at least one team would exist
    return errors.add :base, "PO Items is missing!" if purchase_order_items.reject{|purchase_order_items| purchase_order_items._destroy == true}.empty?
  end 

  
  def check_approval
    #byebug
    if reviewed_by.nil? && approved_by.nil? 
        errors.add(:purchase_order, " : You're not listed in Purchase Order Creator. Please contact your system administrator")
     
      end
  end

  
  def send_mail
    self.status = 'Draft'
    self.update_attributes(no: id)
    
    #Kirim Email Tergantung Otorisasi
    #UserMailer.new_pr_email(self).deliver_later
 
    if self.reviewed_by.nil? || self.reviewed_by == ""
  
          UserMailer.reqapv_purchase_order1(self,self.approved_by).deliver_later
    else
         
        
        UserMailer.reqapv_purchase_order1(self,self.reviewed_by).deliver_later

    end   
  end

  def calculate_totals

      self.total = 0

      self.purchase_order_items.each do |i|

        if i.quantity.nil? || i.price.nil?
         self.total = 0
        else
        
           self.total += (i.quantity * i.price)
        end 

      end
  
        self.totbefdisc = total

        #self.subtotal = total

        if self.is_vat == true
            if self.supplier == '20062-10 VAYATOUR ,PT'
                self.vat = self.total*0.01
                self.grand_total = self.total*1.01
            else
                self.vat = self.total*0.11
                self.grand_total = self.total*1.11
            end
        else
           self.vat = 0
           self.grand_total = self.total
         
        end


    end


def SaveBaris1



    linetotal = 0
    unless @po_item_temp.nil?


      if @po_item_temp.kind_of?(Array)
          
          @po_item_temp.each_with_index do |po_item,i|
       
            if po_item.kind_of?(Array)
              

               po_item.each  do |po_item1|

                if po_item1.kind_of?(Array)

                   po_item1.each  do |po_item2|

                      if po_item2.kind_of?(Array)

                        PurchaseOrderItem.create(no: self.id ,
                                purchase_order_id: self.id,
                               

                                costcenter: po_item2[0].costcenter ,
                                
                                product: po_item2[0].product ,
                                description: po_item2[0].description ,
                                spesification: po_item2[0].spesification ,
                                 
                                dept: po_item2[0].dept,

                                price: po_item2[0].price,
                                quantity: po_item2[0].quantity,
                                amount:  po_item2[0].amount

                              )


                         linetotal = linetotal + (po_item2[0].price * po_item2[0].quantity ) 




                      else

                         PurchaseOrderItem.create(no: self.id ,
                                purchase_order_id: self.id,
                               

                                costcenter: po_item2.costcenter ,
                                
                                product: po_item2.product ,
                                description: po_item2.description ,
                                spesification: po_item2.spesification ,
                                 
                                dept: po_item2.dept,

                                price: po_item2.price,
                                quantity: po_item2.quantity,
                                amount:  po_item2.amount

                              )


                         linetotal = linetotal + (po_item2.price * po_item2.quantity ) 



                      end


                   end 
 
                 else   
                
                   unless po_item1.price.nil?
                     PurchaseOrderItem.create(no: self.id ,
                            purchase_order_id: self.id,
                           

                            costcenter: po_item1.costcenter ,
                            
                            product: po_item1.product ,
                            description: po_item1.description ,
                            spesification: po_item1.spesification ,
                             
                            dept: po_item1.dept,

                            price: po_item1.price,
                            quantity: po_item1.quantity,
                            amount:  po_item1.amount

                          )


                     linetotal = linetotal + (po_item1.price * po_item1.quantity ) 
                    end

                 end  
                

               end


            else

               PurchaseOrderItem.create(no: self.id ,
                      purchase_order_id: self.id,
                     

                      costcenter: po_item.costcenter ,
                      
                      product: po_item.product ,
                      description: po_item.description ,
                      spesification: po_item.spesification ,
                       
                      dept: po_item.dept,

                      price: po_item.price,
                      quantity: po_item.quantity,
                      amount:  po_item.amount

                    )

               linetotal = linetotal + (po_item.price * po_item.quantity ) 

            end

          end


    else


       PurchaseOrderItem.create(no: self.id ,
                    purchase_order_id: self.id,
                   

                    costcenter: @po_item_temp.costcenter ,
                    
                    product: @po_item_temp.product ,
                    description: @po_item_temp.description ,
                    spesification: @po_item_temp.spesification ,
                     
                    dept: @po_item_temp.dept,

                    price: @po_item_temp.price,
                    quantity: @po_item_temp.quantity,
                    amount:  @po_item_temp.amount

                  )

             linetotal = linetotal + (@po_item_temp.price * @po_item_temp.quantity ) 



    end

                         

    end
    po = PurchaseOrder.where(:id => self.id).first 
        
    if self.is_vat == true
      if po.supplier == '20062-10 VAYATOUR ,PT'
           po.totbefdisc = linetotal
           po.vat = linetotal * 0.01
           po.total = linetotal 
           po.grand_total = linetotal * 1.01
      else
         po.totbefdisc = linetotal
           po.vat = linetotal * 0.11
           po.total = linetotal 
           po.grand_total = linetotal * 1.11
      



      end     
            
    else
           po.vat = 0
           po.total = linetotal
           po.totbefdisc = linetotal
           po.grand_total = linetotal

           
    end
    po.net_payment = 0
      po.save
      @po_item_temp = nil
      po_item_temp = nil

end


def SaveBaris


    #LineSection
    linetotal = 0
#unless @po_item_temp.nil?
    @po_item_temp = "[" + @po_item_temp + "]"
    @po_item_temp = JSON.parse(@po_item_temp)
#end

    unless @po_item_temp.nil?


      if @po_item_temp.kind_of?(Array)
         
          
          #if @po_item_temp.to_s.count('[') == 1
          #   @po_item_temp = [ @po_item_temp ]
          #
      
          #end
      
            @po_item_temp.each do |item|
          
            PurchaseOrderItem.create(no: self.id ,
                    purchase_order_id: self.id,
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

    #Header Section
    po = PurchaseOrder.where(:id => self.id).first 
        
    if self.is_vat == true
      if po.supplier == '20062-10 VAYATOUR ,PT'
           po.totbefdisc = linetotal
           po.vat = linetotal * 0.01
           po.total = linetotal 
           po.grand_total = linetotal * 1.01
      else
           po.totbefdisc = linetotal
           po.vat = linetotal * 0.11
           po.total = linetotal 
           po.grand_total = linetotal * 1.11
      end     
            
    else
           po.vat = 0
           po.total = linetotal
           po.totbefdisc = linetotal
           po.grand_total = linetotal

           
    end
    po.net_payment = 0
    po.save
    @po_item_temp = nil
    po_item_temp = nil

end
            


 




end 


