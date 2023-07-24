class UserMailer < ApplicationMailer

  default from: 'ebuy@astellas.com'
  layout 'mailer'

  @@host = default_url_options[:host] + ":" + default_url_options[:port].to_s


  #@@bcc = ['hamdi.syukriwan@ids.co.id'] 
  @@bcc = ['anggraeni.atmaja@astellas.com','budi.setiawan@astellas.com','ade.restu@astellas.com']
  @cc = 'ade.restu@astellas.com'
  #@cc = 'hamdi.syukriwan@gmail.com'


   

  def notif_vipr(docnum,email)
 

    @no  = docnum
    @email = email
  
    @requester = Vipr.find_by(:id => @no).requester
    @url = @@host + "/viprs/" + @no.to_s + "/edit"

  
 
    unless @requester.nil?

      mail(:to => @email,:cc => @cc,:bcc => @@bcc,:subject => "New Payment Request No " + @no  + " is Required Your Approval")
    end

   end

   def notif_po(docnum,email)
 

    @no  = docnum
    @email = email
    @requester = PurchaseOrder.find_by(:id => @no).prepared_by
    @url = @@host + "/purchase_orders/" + @no.to_s + "/edit"

 
     unless @requester.nil?

    mail(:to => @email,:bcc => @@bcc,:subject => "New Purchase Order No " + @no  + " is Required Your Approval")
  end

   end

   def notif_pr(docnum,email)
 

    @no  = docnum
    @email = email
  
    
    @requester = PurchaseRequest.find_by(:id => @no).requester
    @url = @@host + "/purchase_requests/" + @no.to_s + "/edit"



    unless @requester.nil?
    	mail(:to => @email,:cc => @cc,:bcc => @@bcc,:subject => "New Purchase Request No " + @no  + " is Required Your Approval")

   end
 end



#ketinggalan
   def ketinggalan(email)
 
 
    @no  = '25'
    @email = email
    
   
    mail(:to => @email,:cc => 'ade.restu@astellas.com',:bcc => @@bcc,:subject => "New Payment Request No 25 is Required Your Approval")

   end

    def ketinggalan1(email)
 
 
       @no  = '1'
    @email = email
    
   
    mail(:to => @email, :bcc => @@bcc,:subject => "New Payment Request No 15 is Required Your Approval")


   end
   def ketinggalan53(email)
 
 
    @no  = '53'
    @email = email
    
   
    mail(:to => @email, :bcc => @@bcc,:subject => "New Purchase Order 53 is Required Your Approval")

   end



  
  #email selamat datang ketika user baru
  def welcome_email(user)
    @user = user
    @url = @@host  
    mail(:to => @user.email, :subject => "Welcome to Astellas E-Proc Web Apps!")
  end



   def new_pr_email(purchase_request)
    
    @purchase_request = purchase_request
    @no  = @purchase_request.id
    @url = @@host + "/purchase_requests/" + @no.to_s + "/edit"

    mail(:to => @purchase_request.req_email, :subject => "New Purchase Request " + @no.to_s + " is just created by You!")
   end




   def reqapv_purchase_request1(purchase_request,email)
 
    @purchase_request = purchase_request
    @email = email
    @requester = @purchase_request.requester
    @no  = @purchase_request.id
    @url = @@host + "/purchase_requests/" + @no.to_s + "/edit"
    mail(:to => @email,:bcc => @@bcc , :subject => "New Purchase Request " + @purchase_request.id.to_s + " is Required Your Approval")

   end



   def reqapv_purchase_request2(purchase_request,email,pic)
 
    @purchase_request = purchase_request
    @email = email
    @cc = pic
    
    @requester = @purchase_request.requester
    @no  = @purchase_request.id
    @url = @@host + "/purchase_requests/" + @no.to_s + "/edit"
    mail(:to => @email,:bcc => @@bcc ,:cc => @cc, :subject => "Your Purchase Request No : " + @purchase_request.id.to_s + " already Approved!")

   end


  def reqapv_purchase_request3(purchase_request,email,pic)
 
    @purchase_request = purchase_request
    @email = email
    @cc = pic
    
    @requester = @purchase_request.requester
    @no  = @purchase_request.id
    @url = @@host + "/purchase_requests/" + @no.to_s + "/edit"
    mail(:to => @email,:bcc => @@bcc ,:cc => @cc, :subject => "Your Purchase Request No : " + @purchase_request.id.to_s + " is Rejected!")

  end


   


  def new_po_email(purchase_order)
    
    @purchase_order = purchase_order
    @no  = @purchase_order.id
    @url = @@host + "/purchase_orders/" + @no.to_s + "/edit"
    mail(:to => @purchase_order.req_email, :subject => "New Purchase Order " + @no.to_s + " is just created by You!")
   
  end

  

   def reqapv_purchase_order1(purchase_order,email)
 
    @purchase_order = purchase_order
    @email = email
    @requester = @purchase_order.prepared_by
    @no  = @purchase_order.id
    @url = @@host + "/purchase_orders/" + @no.to_s + "/edit"
   
    mail(:to => @email,:bcc => @@bcc, :subject => "New Purchase Order " + @purchase_order.id.to_s + " is Required Your Approval")

   end



   def reqapv_purchase_order2(purchase_order,email)
 
    @purchase_order = purchase_order
    @email = email
    @requester = @purchase_order.prepared_by
    @no  = @purchase_order.id
    @url = @@host + "/purchase_orders/" + @no.to_s + "/edit"
    mail(:to => @email,:bcc => @@bcc , :subject => "Your Purchase Order No : " + @purchase_order.id.to_s + " already Approved!")

   end



  def reqapv_purchase_order3(purchase_order,email)
 
    @purchase_order = purchase_order
    @email = email
    
    @requester = @purchase_order.prepared_by
    @no  = @purchase_order.id
    @url = @@host + "/purchase_orders/" + @no.to_s + "/edit"
    mail(:to => @email, :bcc => @@bcc ,:subject => "Your Purchase Order No : " + @purchase_order.id.to_s + " is Rejected!")

  end


   

   

   def new_vipr_email(vipr)
    
    @vipr = vipr
    @no  = @vipr.id
    @url = @@host + "/viprs/" + @no.to_s + "/edit"

    mail(:to => @vipr.req_email,:bcc => @@bcc, :subject => "New Payment Document No : " + @no.to_s + " is just created by You!")
   end




   def reqapv_vipr1(vipr,email)
 
    @vipr = vipr
    @email = email
    @requester = @vipr.req_email
    @no  = @vipr.id
    @url = @url = @@host + "/viprs/" + @no.to_s + "/edit"
    mail(:to => @email,:bcc => @@bcc ,:cc => 'ade.restu@astellas.com', :subject => "New VIPR " + @vipr.id.to_s + " is Required Your Approval")
  
   end



   def reqapv_vipr2(vipr,email,pic)
 
    @vipr = vipr
    @email = email
    @requester = @vipr.req_email
    @no  = @vipr.id
    @cc = ''
    @url = @@host + "/viprs/" + @no.to_s + "/edit"
    mail(:to => @email,:bcc => @@bcc ,:cc => 'ade.restu@astellas.com', :subject => "Your Payment No : " + @vipr.id.to_s + " already Approved!")

   end

   
  def reqapv_vipr3(vipr,email,pic)
 
    @vipr = vipr
    @email = email
    @cc = pic
    
    @requester = @vipr.req_email
    @no  = @vipr.id
    @url = @@host + "/viprs/" + @no.to_s + "/edit"
    mail(:to => @email,:bcc => @@bcc ,:cc => 'ade.restu@astellas.com', :subject => "Your Payment Request No : " + @vipr.id.to_s + " is Rejected!")

  end


   
  


end
