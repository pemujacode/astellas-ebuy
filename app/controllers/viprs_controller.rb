class ViprsController < ApplicationController
  before_action :set_vipr, only: [:show, :edit, :update, :destroy]
  layout "print", except: [:index, :update,:create, :new, :edit, :CopyFromPO]
    
  load_and_authorize_resource
  
  @@laststatus=''
  @@newstatus=''
  @@apv1=''
  @@apv2=''
  @@apv3=''
  @@apv4=''
  @@doctype=''
  @@source=''
  @@vipr_item_temp = ViprItem.new
   
    

  



  # GET /viprs
  # GET /viprs.json
  respond_to :js, :json, :html
  def setType

    params[:doctype] = params[:doctype]


  end


  def setSource

    params[:source] = params[:source]

  end


  def SetLineValueVIPR()



    #@vipr_item1 =  ViprItem.new

    #@vipr_item1.description = params[:description]
    #@vipr_item1.spesification = params[:spesification]
    #@vipr_item1.price = params[:price]
    #@vipr_item1.quantity = params[:quantity]
    
    #@vipr_item1.product = params[:product]
    #@vipr_item1.costcenter = params[:purch]
    #@vipr_item1.dept = params[:dept]
    #@vipr_item1.amount = params[:total]


    #if @@vipr_item_temp.nil?
    #     @@vipr_item_temp = @vipr_item1 
    #else
    #    @@vipr_item_temp =  [@@vipr_item_temp,@vipr_item1] 
    #end


    @vipr_item1 =  '[{"description": "' + params[:description] + '","spesification": "' + params[:spesification] + '","price":"' + params[:price] + '","quantity":"' + params[:quantity] + '","product":"' + params[:product] + '","purch":"' + params[:purch] + '","dept":"' + params[:dept] + '","total": "' + params[:total] + '"}]'
    #@po_item1 =  '[ {"description" : "' + params[:description] + '" , "spesification" : "' + params[:spesification] + '" }]'







    if @@vipr_item_temp.nil?
       @@vipr_item_temp = @vipr_item1 

    else



       @@vipr_item_temp =  @@vipr_item_temp + "," + @vipr_item1
    
          

    end


  

 
  end



  def CopyFromPO
   

    @po = PurchaseOrder.where(:sapno => params[:sapno])
    #@po_item = PurchaseOrderItem.where(:purchase_order_id => @po.id)
    

    params[:id] = params[:sapno]
   
    @vipr_header = Vipr.new
    @po.each do |po|
      params[:supplier] = po.supplier
      @vipr_header.po_no = params[:id]
      @vipr_header.supplier = po.supplier
      @vipr_header.doctype = po.doctype
      @vipr_header.is_vat = po.is_vat
      

       
    end

    respond_with @vipr_header  
  end



 



  def refresh
    @vipr = Vipr.new
    # Check validity of the data if calculate_budget does not
    @vipr.calculate_totals # Assuming this method does not save the budget
    #render :new
    #respond_to do |format|
    #  format.html { render :new }
    #  format.js
     
    #end
    
  end
  helper_method :refresh


  def index
  
    if current_user.role == 'User'
       #@vipr = Vipr.where(user_id: current_user.id)
       #@vipr = PurchaseRequest.find_by_sql("SELECT * FROM viprs WHERE user_id ='" + current_user.email + "' or pic ='" + current_user.name + "'")
       @viprs = Vipr.find_by_sql("SELECT * FROM viprs WHERE req_email = '" + current_user.email + "' or pic ='" + current_user.name + "'")

       
    else
       @viprs = Vipr.all
    end
    
  end

  # GET /viprs/1
  # GET /viprs/1.json
  def show
      @viprs = Vipr.find(params[:id])
      @vipr_item = ViprItem.where(:vipr_id => params[:id])

      

  end

  # GET /viprs/new
  def new

    @vipr = Vipr.new
    @vipr_item = ViprItem.new
    @approval = PrApproval.all
           
    @@vipr_item_temp = nil
    @supplier = Supplier.all
    @costcenter = Costcenter.all
    @dept = Dept.all
    @product = Product.all
    @expense = Expense.all
   

    @vipr_item.price = 0
    @vipr_item.quantity = 0
    @vipr_item.amount = 0

    @vipr.total = 0
    @vipr.vat = 0
    @vipr.grand_total = 0
    @vipr.disc = 0
    @vipr.totbefdisc = 0
    @vipr.dp = 100
    @vipr.net_payment = 0
    
   
   if params[:doctype].nil?
     params[:doctype] != 'Service'

   end
   
    if params[:doctype] == 'Item'
       @vipr.doctype = 'Item'
      
       
       @@doctype = 'Item'
    else
       @vipr.doctype = 'Service'
       @@doctype = 'Service'
      
    end


     if params[:source] == 'PO'
       @vipr.source = params[:source]
       @@source = params[:source]
        
    else
         if @vipr.source.nil?
           @vipr.source = 'Non PO'
           params[:source] = 'Non PO'
           @@source = params[:source]
        
        end  

        @vipr.source = params[:source]
        @@source = params[:source]
        @vipr_item = ViprItem.new

    end


 

    #Load tabel Approval 
    if PrApproval.find_by(requester: current_user.email).nil? == false
       @vipr.approval1 = PrApproval.find_by(requester: current_user.email).apv1
       @vipr.approval2 = PrApproval.find_by(requester: current_user.email).apv2
       @vipr.approval3 = PrApproval.find_by(requester: current_user.email).apv3
       @vipr.approval4 = PrApproval.find_by(requester: current_user.email).apv4
       @vipr.pic = PrApproval.find_by(requester: current_user.email).pic
       @vipr.approval_group = PrApproval.find_by(requester: current_user.email).approval_group
       
       
    end


    #Load From PO
    if params[:source] == 'PO' && params[:no] != "" 
     unless params[:no].nil?
      @po = PurchaseOrder.where(:sapno => params[:no])
       @po.each do |po|
       @po_item = PurchaseOrderItem.where(:purchase_order_id => po.id)
       end

       
       #@vipr_item = ViprItem.new
    
   
        
       #@po_item.each do |vipr_item|
              #@vipr_item1 =  ViprItem.new  

        # @vipr_item.costcenter = vipr_item.costcenter
         #@vipr_item.product = vipr_item.product
         #@vipr_item.description = vipr_item.description
         #@vipr_item.spesification = vipr_item.spesification
         #@vipr_item.dept = vipr_item.dept
         #@vipr_item.price = vipr_item.price
         #@vipr_item.quantity = vipr_item.quantity
         #@vipr_item.amount = vipr_item.amount

  #       @vipr_item2 =  [@vipr_item2,@vipr_item] 



#       end

        
 #     @vipr_item = @vipr_item2
   



       

       @po.each do |po|
        @vipr.po_no = po.sapno
        @vipr.supplier = po.supplier

        params[:supplier] = po.supplier

        @vipr.doctype = po.doctype
        params[:doctype] = po.doctype
    
        
        params[:subtotal] = po.subtotal
        @vipr.subtotal = po.subtotal.to_i

        params[:total] = po.total
        @vipr.total = po.total.to_i
        #@vipr.disc = po.disc
        params[:vat] = po.vat
        @vipr.vat = po.vat.to_i



        params[:is_vat] = po.is_vat
        @vipr.is_vat = po.is_vat


        params[:disc] = po.disc
        @vipr.disc = po.disc.to_i

        params[:grand_total] = po.grand_total
        @vipr.grand_total = po.grand_total.to_i


        params[:totbefdisc] = po.totbefdisc
        @vipr.totbefdisc = po.totbefdisc.to_i


        params[:dp] = 100
        @vipr.dp = 100


        params[:net_payment] = po.grand_total.to_i -  po.net_payment.to_i 
        @vipr.net_payment = po.grand_total.to_i -  po.net_payment.to_i
        


        params[:dp_amount] = po.grand_total.to_i -  po.net_payment.to_i 
        @vipr.dp_amount = po.grand_total.to_i -  po.net_payment.to_i


        





       end
     end

    else
     @vipr.subtotal = 0
     @vipr.vat = 0
     @vipr.total = 0

    end
  



    #Set Initial value
    #@vipr.status = 'Draft'
    @vipr.user_id = current_user.id
    @vipr.req_email = current_user.email
    #@vipr.department = Department.find_by(id: current_user.department_id).name
    @vipr.invoice_date =  DateTime.parse(Date.today.to_s).strftime("%d/%m/%Y")
    
        

   
    
  
  end

  # GET /viprs/1/edit
  def edit
    @vipr= Vipr.find(params[:id])
    @vipr_item = ViprItem.find_by(vipr_id: params[:id])

    @supplier = Supplier.all
    @costcenter = Costcenter.all
    @dept = Dept.all
    @product = Product.all
    @expense = Expense.all



    @@laststatus = @vipr.status

   if params[:status] == 'Released' && @vipr.status == 'Draft'
        @@laststatus = @vipr.status
        @vipr.status = 'Released'
        @@newstatus = 'Released'

     end

    
      #Refresh Approval by Amount
#       if PrApproval.find_by(requester: @vipr.req_email).nil? == false
 #          @vipr.approval1 = PrApproval.find_by(requester: @vipr.req_email).apv1
 #          @@apv1 = PrApproval.find_by(requester: @vipr.req_email).apv1
 #          @vipr.pic = PrApproval.find_by(requester: @vipr.req_email).pic
    
           #Check Plafond
  #         if @vipr.subtotal < PrApproval.find_by(requester: @vipr.req_email).apv2_amount
              #@vipr.approval2 = PrApproval.find_by(requester: current_user.email).apv2
   #           @@apv2 = PrApproval.find_by(requester: @vipr.req_email).apv2
              
              #@vipr.approval3 = ''
    #          @@apv3 = ''
              #@vipr.approval4 = ''
     #         @@apv4 = ''
      #     else
       #       if @vipr.subtotal < PrApproval.find_by(requester: @vipr.req_email).apv3_amount
                 #@vipr.approval2 = PrApproval.find_by(requester: @vipr.req_email).apv2
                 #@vipr.approval3 = PrApproval.find_by(requester: @vipr.req_email).apv3
                 #@vipr.approval4 = ''

        #         @@apv2 = PrApproval.find_by(requester: @vipr.req_email).apv2
         #        @@apv3 = PrApproval.find_by(requester: @vipr.req_email).apv3
          #       @@apv4 = ''
           #   else
            #     @@apv2 = PrApproval.find_by(requester: @vipr.req_email).apv2
             #    @@apv3 = PrApproval.find_by(requester: @vipr.req_email).apv3
              #   @@apv4 = PrApproval.find_by(requester: @vipr.req_email).apv4
             # end   
          # end 
      # end

      #Jika Terjadi Perubahan Status
       if params[:status] == 'Approved' && @vipr.status != 'Draft'
          @@laststatus = @vipr.status
          @@newstatus = 'Approval - 1'
          
          #check approval 1

          if @vipr.approval1 != "" && @vipr.apv_date1.nil? && current_user.email == @vipr.approval1
             @vipr.status = 'Approval - 1'
             @vipr.apv_date1 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
             @@newstatus = 'Approval - 1'
             
          else
            #Approval 2 
          
            if @vipr.approval2 != "" && @vipr.apv_date2.nil? && current_user.email == @vipr.approval2
               @vipr.status = 'Approval - 2'
               @vipr.apv_date2 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
               @@newstatus = 'Approval - 2'
            else
               #Approval 3 
               if @vipr.approval3 != "" && @vipr.apv_date3.nil? && current_user.email == @vipr.approval3
                 @vipr.status = 'Approval - 3'
                 @vipr.apv_date3 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                 @@newstatus = 'Approval - 3'

               else
                  if @vipr.approval4 != "" && @vipr.apv_date4.nil? && current_user.email == @vipr.approval4
                     @vipr.status = 'Approved'
                     @vipr.apv_date4 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                     @@newstatus = 'Approved'
                  else
                    #raise "You're not authorized to perform approval"
                    #byebug
                    respond_to do |format|
                      #flash[:alert] = "You're not authorized to perform approval in this document"
                      
                      format.html { redirect_to viprs_url,:action => 'index', alert: "You're not authorized to perform approval in this document." }
                    end
                  end
                end
            end  
          end  
       end



      #Jika Di Reject
      if params[:status] == 'Rejected' && @vipr.status != 'Draft'
         @@laststatus = @vipr.status
         @@newstatus = 'Rejected'
         @pvipr.status = 'Rejected'
      end
  


  end

  # POST /viprs
  # POST /viprs.json
  def create

    #vipr_params = params
    
    @vipr = Vipr.new(vipr_params)

 

   
    @vipr.user_id = current_user.id
    @vipr.req_email = current_user.email
    #@vipr.account = current_user.emp_id
    #@vipr.department = Department.find_by(id: current_user.department_id).name
    @vipr.requester = current_user.name

    @vipr.vipr_item_temp = @@vipr_item_temp

    @@vipr_item_temp = nil
 
    
  



    if @vipr.subtotal.nil?
       @vipr.subtotal = 0
       @vipr.vat = 0

       @vipr.total = 0
    end

    #Refresh Source & DocType
    if @vipr.doctype == 'Item' || params[:doctype] == 'Item' || @@doctype == 'Item'
   
       @vipr.doctype = 'Item'
    else
  
       @vipr.doctype = 'Service'
    end


     if @vipr.source == 'PO' || params[:source] == 'PO' || @@source == 'PO'
   
       @vipr.source = 'PO'
    else
  
       @vipr.source = 'Non PO'
    end



    


    
    #if PrApproval.find_by(requester: current_user.email).nil? == false
    #   @vipr.approval1 = PrApproval.find_by(requester: current_user.email).apv1
       
    #   #Check Plafond
    #   if @vipr.subtotal < PrApproval.find_by(requester: current_user.email).apv2_amount
    #      @vipr.approval2 = PrApproval.find_by(requester: current_user.email).apv2
    #      @vipr.approval3 = ''
    #      @vipr.approval4 = ''
    #   else
    #      if @vipr.subtotal < PrApproval.find_by(requester: current_user.email).apv3_amount
    #         @vipr.approval2 = PrApproval.find_by(requester: current_user.email).apv2
    #         @vipr.approval3 = PrApproval.find_by(requester: current_user.email).apv3
    #         @vipr.approval4 = ''
    #      else
    #         @vipr.approval2 = PrApproval.find_by(requester: current_user.email).apv2
    #         @vipr.approval3 = PrApproval.find_by(requester: current_user.email).apv3
    #         @vipr.approval4 = PrApproval.find_by(requester: current_user.email).apv4
    #      end   
    #  end 
    #end

    respond_to do |format|
      if @vipr.save
        format.html { redirect_to @vipr, notice: 'Vipr was successfully created.' }
        format.json { render :show, status: :created, location: @vipr }
      else
        @@vipr_item_temp = nil
        format.html { render :new }
        format.json { render json: @vipr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /viprs/1
  # PATCH/PUT /viprs/1.json
  def update
   
      respond_to do |format|

          @vipr = Vipr.find(params[:id])
          @@newstatus = params[:status] 
          @@laststatus = @vipr.status




          ##Check Status Release atau Draft
          #if @@newstatus == 'Released' && @vipr.status == 'Draft'
          #   @@laststatus = @vipr.status
          #   @vipr.status = 'Released'
          #end
          p_currency = 0

          if @vipr.currency =='USD'
            p_currency = 14000
          else
            if @vipr.currency =='SGD'
              p_currency = 10500
            else
               if @vipr.currency =='JPY'
                  p_currency = 135
               else
                  p_currency = 1
               end
            end
          end   
          
          #Refresh Approval by Amount
  #        if PrApproval.find_by(requester: @vipr.req_email).nil? == false
  #           @vipr.approval1 = PrApproval.find_by(requester: @vipr.req_email).apv1
  #           @vipr.pic = PrApproval.find_by(requester: @vipr.req_email).pic
             
             #Check Plafond
  #           if @vipr.subtotal*p_currency < PrApproval.find_by(requester: @vipr.req_email).apv2_amount
  #              @vipr.approval2 = PrApproval.find_by(requester: @vipr.req_email).apv2
  #              @vipr.approval3 = ''
  #              @vipr.approval4 = ''
   #          else
   #             if @vipr.subtotal*p_currency < PrApproval.find_by(requester: @vipr.req_email).apv3_amount
    #               @vipr.approval2 = PrApproval.find_by(requester: @vipr.req_email).apv2
    #               @vipr.approval3 = PrApproval.find_by(requester: @vipr.req_email).apv3
     #              @vipr.approval4 = ''
      #          else
       #            @vipr.approval2 = PrApproval.find_by(requester: @vipr.req_email).apv2
       #            @vipr.approval3 = PrApproval.find_by(requester: @vipr.req_email).apv3
        #           @vipr.approval4 = PrApproval.find_by(requester: @vipr.req_email).apv4
         #       end   
          #   end 
          #end


          #Jika Terjadi Perubahan Status

          if @@laststatus != @@newstatus && @@laststatus != "" && @@newstatus != 'Rejected'

             # Released => Approval 1
             if current_user.email == @vipr.req_email && @vipr.status == "Released"
                # Released => Approval 1
             
                if @vipr.approval1.nil? || @vipr.approval1 == ""
                    if @vipr.approval2.nil? || @vipr.approval2 == ""
                      if @vipr.approval3.nil? || @vipr.approval3 == ""

                         UserMailer.reqapv_vipr1(@vipr,@vipr.approval4).deliver_later
                      else
                         UserMailer.reqapv_vipr1(@vipr,@vipr.approval3).deliver_later
                      end
                    else
                      UserMailer.reqapv_vipr1(@vipr,@vipr.approval2).deliver_later
                    end   
                else
                   UserMailer.reqapv_vipr1(@vipr,@vipr.approval1).deliver_later
                end  
             else
                # Approval 1 => Approval 2
                
                if @vipr.approval1 != "" && @vipr.apv_date1.nil? && current_user.email == @vipr.approval1
                   @vipr.status = 'Approval - 1'
                   @vipr.apv_date1 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                   @@newstatus = 'Approval - 1'
              
                 
                
                   if @vipr.approval2.nil? || @vipr.approval2 == ""
                      if @vipr.approval3.nil? || @vipr.approval3 == ""
                          
                         UserMailer.reqapv_vipr1(@vipr,@vipr.approval4).deliver_later
                      else
                          
                         UserMailer.reqapv_vipr1(@vipr,@vipr.approval3).deliver_later
                      end
                   else
                      
                      UserMailer.reqapv_vipr1(@vipr,@vipr.approval2).deliver_later
                   end   
               

                else
                  # Approval 2 => Approval 3
                  if @vipr.approval2 != "" && @vipr.apv_date2.nil? && current_user.email == @vipr.approval2
                      
                     @vipr.status = 'Approval - 2'
                     @vipr.apv_date2 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                     @@newstatus = 'Approval - 2'
                     #UserMailer.reqapv_vipr1(@vipr,@vipr.approval3).deliver_later
                     if @vipr.approval3.nil? || @vipr.approval3 == ""
                         if @vipr.approval4.nil? || @vipr.approval4 == ""
                            #Approval Terakhir Level 2
                            @vipr.status = 'Approved'
                            @vipr.apv_date2 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                            @@newstatus = 'Approved'
                            UserMailer.reqapv_vipr2(@vipr,@vipr.req_email,User.find_by(name: @vipr.pic).email).deliver_later
                         
                         else  
                            UserMailer.reqapv_vipr1(@vipr,@vipr.approval4).deliver_later
                         end
                     else
                         UserMailer.reqapv_vipr1(@vipr,@vipr.approval3).deliver_later
                     end
                  else
                     # Approval 3 => Approval 4
                     if @vipr.approval3 != "" && @vipr.apv_date3.nil? && current_user.email == @vipr.approval3
                        
                        @vipr.status = 'Approval - 3'
                        @vipr.apv_date3 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                        @@newstatus = 'Approval - 3'
                        #check apakah approval terahir di level 3
                        if @vipr.approval4.nil? || @vipr.approval4 == ""
                            #Approval Terakhir Level 2

                            @vipr.status = 'Approved'
                            @vipr.apv_date3 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                            @@newstatus = 'Approved'
                            UserMailer.reqapv_vipr2(@vipr,@vipr.req_email,User.find_by(name: @vipr.pic).email).deliver_later
                         else  
                            UserMailer.reqapv_vipr1(@vipr,@vipr.approval4).deliver_later
                         end
                     else
                    
                     
                        if @vipr.approval4 != "" && @vipr.apv_date4.nil? && current_user.email == @vipr.approval4
                           @vipr.status = 'Approved'
                           @vipr.apv_date4 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                           @@newstatus = 'Approved'
                           UserMailer.reqapv_vipr2(@vipr,@vipr.req_email,User.find_by(name: @vipr.pic).email).deliver_later

               
                        else
                           
                           format.html { redirect_to viprs_url,:action => 'index', alert: "You're not authorized to perform approval in this document / You're not part of DOA." }
                         
                        end
                  
                     end  
                  end
                end
             end
          end

          #Jika Di Reject
          
          if @@laststatus != @@newstatus && params[:status] == 'Rejected' ##&& @vipr.status != 'Approved'
            @vipr.status = 'Rejected'
            @@newstatus = 'Rejected'
            #kirim email ke requester
            #if current_user.role == 'User'
               UserMailer.reqapv_vipr3(@vipr,@vipr.req_email,User.find_by(name: @vipr.pic).email).deliver_later
            #end
        

          end



      if @vipr.update(vipr_params)
        format.html { redirect_to @vipr, notice: 'Vipr was successfully updated.' }
        format.json { render :show, status: :ok, location: @vipr }
      else
        format.html { render :edit }
        format.json { render json: @vipr.errors, status: :unprocessable_entity }
      end

    end
  end

  # DELETE /viprs/1
  # DELETE /viprs/1.json
  def destroy
    @vipr.destroy
    respond_to do |format|
      format.html { redirect_to viprs_url, notice: 'Vipr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vipr
      @vipr = Vipr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vipr_params

       if params[:action] == "update"
         params.permit(:vipr)
       else
         params.require(:vipr).permit(:id,:disc,:approval_group, :pic,:dp,:net_payment,:dp_amount, :no,:po_no,:is_vat,:status, :supplier,:doctype, :invoice_no, :invoice_date, :due_date, :payment_no, :currency, :requester, :approval1, :apv_date1, :approval2, :apv_date2, :approval3, :apv_date3, :approval4, :apv_date4, :subtotal, :vat, :total , :remarks, attachment1:[], :vipr_items_attributes => [:vipr_id, :product, :no,:dept, :description, :spesification, :req_qty, :costcenter, :price, :quantity,  :amount, :_destroy,:id] )
       end
    end
end


