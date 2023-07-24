class Vipr < ApplicationRecord
 
  validates :invoice_no,:invoice_date, presence: true
  validates :po_no, presence: true,  if: -> {source == "PO"}
  
  has_many :vipr_items, dependent: :destroy
  accepts_nested_attributes_for :vipr_items, allow_destroy: true #reject_if: proc { |att| att['no'].blank? }
  
  before_validation :calculate_totals, on: :create


  validate :check_approval
  #validates :total, numericality: { other_than: 0 }
  #before_save :calculate_totals
  has_many_attached :attachment1



  
  after_create :SaveBaris, if: -> {source == "Non PO"}
  after_create :CopyFromPO, if: -> {source == "PO"}
  
  after_create :send_mail



  validate :refresh_status_po, on: :update



  #validates :subtotal,:vat,:total, numericality: { other_than: 0 }

  before_save :default_values
  #validate :check_baris


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



def check_approval
  #byebug
  if approval1.nil? && approval2.nil? && approval3.nil?
      errors.add(:vipr, " : You're not listed in VIPR User Matrix. Please contact your system administrator")
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
   po = PurchaseOrder.where(:sapno => self.po_no).first

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
  self.update(no: id)
    #Kirim Email Tergantung Otorisasi
  #UserMailer.new_pr_email(self).deliver_later

  if self.approval1.nil? || self.approval1 == ""
      if self.approval2.nil? || self.approval2 == ""
        if self.approval3.nil? || self.approval3 == ""
           UserMailer.reqapv_vipr1(self,self.approval4).deliver_later
        else
           UserMailer.reqapv_vipr1(self,self.approval3).deliver_later
        end
      else
           UserMailer.reqapv_vipr1(self,self.approval2).deliver_later
      end   
  else
      UserMailer.reqapv_vipr1(self,self.approval1).deliver_later
  end  
end

def CopyFromPO

    popo = PurchaseOrder.where(:sapno => self.po_no).first

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
      

      po_header = PurchaseOrder.where(:sapno => self.po_no).first      
    
    
      vipr = Vipr.where(:id => self.id).first 
      vipr.totbefdisc = po_header.totbefdisc
      vipr.subtotal = po_header.subtotal


        
      
      vipr.vat = po_header.vat 
      vipr.total = po_header.total
      vipr.grand_total = po_header.grand_total
      vipr.dp_amount = (self.dp/100)*po_header.grand_total
       
      vipr.net_payment  = (self.dp/100)*po_header.grand_total
       
           
    
       vipr.save

       po = PurchaseOrder.where(:sapno => self.po_no).first 
       po.net_payment = po.net_payment +  (self.dp/100)*po_header.grand_total

       po.save
    
      
    
      
     
     
  

     

end

def SaveBaris


  linetotal = 0
  grand_total = 0
  unless @vipr_item_temp.nil?


    if @vipr_item_temp.kind_of?(Array)
          
          @vipr_item_temp.each_with_index do |vipr_item,i|
       
            if vipr_item.kind_of?(Array)

               vipr_item.each  do |vipr_item1|

                if vipr_item1.kind_of?(Array)

                   vipr_item1.each  do |vipr_item2|

                      if vipr_item2.kind_of?(Array)

                         vipr_item2.each  do |vipr_item3|

                          if vipr_item3.kind_of?(Array)

                            ViprItem.create(no: self.id ,
                                    vipr_id: self.id,
                                   

                                    costcenter: vipr_item3[0].costcenter ,
                                    
                                    product: vipr_item3[0].product ,
                                    description: vipr_item3[0].description ,
                                    spesification: vipr_item3[0].spesification ,
                                     
                                    dept: vipr_item3[0].dept,

                                    price: vipr_item3[0].price,
                                    quantity: vipr_item3[0].quantity,
                                    amount:  vipr_item3[0].amount
                                    

                                  )
                            


                             linetotal = linetotal + (vipr_item3[0].price * vipr_item3[0].quantity ) 
                          else

                            ViprItem.create(no: self.id ,
                                vipr_id: self.id,
                               

                                costcenter: vipr_item3.costcenter ,
                                
                                product: vipr_item3.product ,
                                description: vipr_item3.description ,
                                spesification: vipr_item3.spesification ,
                                 
                                dept: vipr_item3.dept,

                                price: vipr_item3.price,
                                quantity: vipr_item3.quantity,
                                amount:  vipr_item3.amount
                               

                              )
                      


                         linetotal = linetotal + (vipr_item3.price * vipr_item3.quantity ) 
                          


                          end

                        end 


                      else

                         ViprItem.create(no: self.id ,
                                vipr_id: self.id,
                               

                                costcenter: vipr_item2.costcenter ,
                                
                                product: vipr_item2.product ,
                                description: vipr_item2.description ,
                                spesification: vipr_item2.spesification ,
                                 
                                dept: vipr_item2.dept,

                                price: vipr_item2.price,
                                quantity: vipr_item2.quantity,
                                amount:  vipr_item2.amount
                               

                              )
                    


                         linetotal = linetotal + (vipr_item2.price * vipr_item2.quantity ) 



                      end


                   end 
 
                else   
                

                   ViprItem.create(no: self.id ,
                          vipr_id: self.id,
                         

                          costcenter: vipr_item1.costcenter ,
                          
                          product: vipr_item1.product ,
                          description: vipr_item1.description ,
                          spesification: vipr_item1.spesification ,
                           
                          dept: vipr_item1.dept,

                          price: vipr_item1.price,
                          quantity: vipr_item1.quantity,
                          amount:  vipr_item1.amount
                         

                        )
               


                   linetotal = linetotal + (vipr_item1.price * vipr_item1.quantity ) 
                end  
                

               end

            

            else

               ViprItem.create(no: self.id ,
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

          end


    else


      ViprItem.create(no: self.id ,
                    vipr_id: self.id,
                   

                    costcenter: @vipr_item_temp.costcenter ,
                    
                    product: @vipr_item_temp.product ,
                    description: @vipr_item_temp.description ,
                    spesification: @vipr_item_temp.spesification ,
                     
                    dept: @vipr_item_temp.dept,

                    price: @vipr_item_temp.price,
                    quantity: @vipr_item_temp.quantity,
                    amount:  @vipr_item_temp.amount
                   

      )
      linetotal = linetotal + (@vipr_item_temp.price * @vipr_item_temp.quantity ) 

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
    if self.source == 'Non PO'

       vipr.dp_amount = grand_total
       vipr.dp = 100
       vipr.net_payment  = grand_total

    else
       vipr.dp_amount = (self.dp/100)*grand_total
       po = PurchaseOrder.where(:sapno => self.po_no).first 
       po.net_payment = po.net_payment +  (self.dp/100)*grand_total

       po.save
    
       vipr.net_payment  = (self.dp/100)*grand_total

    end 
    
    vipr.save
    vipr_item_temp = nil
    @vipr_item_temp = nil

     
     


    
        
end




  




 
end



