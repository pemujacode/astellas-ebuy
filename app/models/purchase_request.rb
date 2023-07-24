class PurchaseRequest < ApplicationRecord
  
  before_save :default_values
  #validate :check_approval
  validates :requester,:purpose, :request_date, :required_date,  presence: true
  validates :price, numericality: { other_than: 0, message: '/ Estimated Amount cannot be Zero!' }
  validates :price, numericality: { greater_than: 2999999, message: '/ PR dibawah 3jt tidak perlu lewat Web Aplikasi' }
  
  has_many :purchase_request_items, dependent: :destroy
  accepts_nested_attributes_for :purchase_request_items, allow_destroy: true # ,reject_if: :all_blank



  has_many_attached :attachment1
  after_create :set_approval
  after_create :send_mail
  
 

  validate :check_baris

  private





  def default_values
    self.status ||='Draft'
    self.purchase_request_items.each do |item|

    if item.quantity == '' || item.quantity.nil? || item.quantity == 0

       item.quantity = 1

    end
  end 

  end


private 



  def check_baris
    # when creating a new contact: making sure at least one team exists
    return errors.add :base, "PR Items is missing!" unless purchase_request_items.length > 0

    # when updating an existing contact: Making sure that at least one team would exist
    return errors.add :base, "PR Items is missing!" if purchase_request_items.reject{|purchase_request_items| purchase_request_items._destroy == true}.empty?
  end 

  def check_approval
  	#byebug
  	if approval1.nil? && approval2.nil? && approval3.nil?
        errors.add(:purchase_request, " : You're not listed in Purchase Request User Matrix. Please contact your system administrator")
      end
  end

   def set_approval
    # set approval
    purchase_request = PurchaseRequest.where(:id => self.id).first 
    p_currency = 1


   

if PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY').nil? == false
         purchase_request.approval1 = PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY' ).apv1
         
         if (purchase_request.price*p_currency) <= PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY').apv2_amount
            purchase_request.approval2 = PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY').apv2
            purchase_request.approval3 = ''
            purchase_request.approval4 = ''
            
         else
            if (purchase_request.price*p_currency) <= PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY').apv3_amount
               purchase_request.approval2 = PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY').apv2
               purchase_request.approval3 = PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY').apv3
               purchase_request.approval4 = ''
               
            else
               purchase_request.approval2 = PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY').apv2
               purchase_request.approval3 = PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY').apv3
               purchase_request.approval4 = PrApproval.find_by(requester: purchase_request.req_email ,approval_group: purchase_request.approval_group, trans: 'PRPAY').apv4

            end   
         end 
      end
      
      

      purchase_request.save
      
  end 


    



	def send_mail
    #Kirim Email Tergantung Otorisasi
  	#UserMailer.new_pr_email(self).deliver_later
    purchase_request = PurchaseRequest.where(:id => self.id).first 
    if purchase_request.approval1.nil? ||purchase_request.approval1 == ""
      if purchase_request.approval2.nil? || purchase_request.approval2 == ""
        if purchase_request.approval3.nil? || purchase_request.approval3 == ""
           
           UserMailer.reqapv_purchase_request1(purchase_request,purchase_request.approval4).deliver_later
        else
           UserMailer.reqapv_purchase_request1(purchase_request,purchase_request.approval3).deliver_later
        end
      else
           UserMailer.reqapv_purchase_request1(purchase_request,purchase_request.approval2).deliver_later
      end   
    else
      UserMailer.reqapv_purchase_request1(purchase_request,purchase_request.approval1).deliver_later
    end  

	end

end

