class PurchaseRequestsController < ApplicationController
  before_action :set_purchase_request, only: [:show, :edit, :update, :destroy, ]
  layout "print", except: [:index,:create, :update, :new, :edit]
  load_and_authorize_resource
  
  @@laststatus=''
  @@newstatus=''
  @@apv1=''
  @@apv2=''
  @@apv3=''
  @@apv4=''
 




  # GET /purchase_requests
  # GET /purchase_requests.json
  def index
    #Filter data yang akan tampil
    #@purchase_requests = PurchaseRequest.all.order("id desc")
    @purchase_requests = PurchaseRequest.all
    if current_user.role == 'User'
       #@purchase_requests = PurchaseRequest.where(user_id: current_user.id).order("id desc")
       @purchase_requests = PurchaseRequest.find_by_sql("SELECT * FROM purchase_requests WHERE req_email = '" + current_user.email + "' or pic ='" + current_user.name + "'")

    else
      @purchase_requests = PurchaseRequest.all.order("id desc")
    end
    
    
  end

  # GET /purchase_requests/1
  # GET /purchase_requests/1.json
  def show
    @purchase_requests = PurchaseRequest.find(params[:id])
    @pr_item = PurchaseRequestItem.where(:purchase_request_id => params[:id])


  end

  # GET /purchase_requests/new
  def new

    #Set Initial value
    @purchase_request = PurchaseRequest.new
    @pr_item = PurchaseRequestItem.new
    @supplier = Supplier.all
    @costcenter = Costcenter.all
    @dept = Dept.all
    @product = Product.all
    @pr_item.quantity = 1
    @approval = PrApproval.all




    #@purchase_request.status = 'Draft'
    @purchase_request.user_id = current_user.id
    @purchase_request.account = current_user.emp_id
    @purchase_request.req_email = current_user.email
    @purchase_request.department = Department.find_by(id: current_user.department_id).name
    @purchase_request.request_date =  DateTime.parse(Date.today.to_s).strftime("%d/%m/%Y")
    @purchase_request.required_date =  DateTime.parse((Date.today+30).to_s).strftime("%d/%m/%Y") 
    
    @purchase_request.quantity = 1
    @purchase_request.requester = current_user.name
    

    #Load tabel Approval 
    if PrApproval.find_by(requester: current_user.email).nil? == false
       @purchase_request.approval1 = PrApproval.find_by(requester: current_user.email).apv1
       @purchase_request.approval2 = PrApproval.find_by(requester: current_user.email).apv2
       @purchase_request.approval3 = PrApproval.find_by(requester: current_user.email).apv3
       @purchase_request.approval4 = PrApproval.find_by(requester: current_user.email).apv4
       @purchase_request.pic = PrApproval.find_by(requester: current_user.email).pic
       @purchase_request.approval_group =  PrApproval.find_by(requester: current_user.email).approval_group
       
    end
    

  end

  # GET /purchase_requests/1/edit
  def edit

      @purchase_request = PurchaseRequest.find(params[:id])
      @pr_item = PurchaseRequestItem.where(:purchase_request_id => params[:id])

      @@laststatus = @purchase_request.status
      @supplier = Supplier.all
      @costcenter = Costcenter.all
      @dept = Dept.all
      @product = Product.all



      #if params[:status] == 'Released' && @purchase_request.status == 'Draft'
      #    @@laststatus = @purchase_request.status
      #    @purchase_request.status = 'Released'
      #    @@newstatus = 'Released'

      # end

    
      #Refresh Approval by Amount
#      if PrApproval.find_by(requester: @purchase_request.req_email).nil? == false
#           @purchase_request.approval1 = PrApproval.find_by(requester: @purchase_request.req_email).apv1
#           @@apv1 = PrApproval.find_by(requester: @purchase_request.req_email).apv1
#           @purchase_request.pic = PrApproval.find_by(requester: @purchase_request.req_email).pic
    
           #Check Plafond
#           if @purchase_request.price  < PrApproval.find_by(requester: @purchase_request.req_email).apv2_amount
              #@purchase_request.approval2 = PrApproval.find_by(requester: current_user.email).apv2
#              @@apv2 = PrApproval.find_by(requester: @purchase_request.req_email).apv2
              
              #@purchase_request.approval3 = ''
 #             @@apv3 = ''
              #@purchase_request.approval4 = ''
  #            @@apv4 = ''
   #        else
    #          if @purchase_request.price  < PrApproval.find_by(requester: @purchase_request.req_email).apv3_amount
                 #@purchase_request.approval2 = PrApproval.find_by(requester: @purchase_request.req_email).apv2
                 #@purchase_request.approval3 = PrApproval.find_by(requester: @purchase_request.req_email).apv3
                 #@purchase_request.approval4 = ''
     #            @@apv2 = PrApproval.find_by(requester: @purchase_request.req_email).apv2
      #           @@apv3 = PrApproval.find_by(requester: @purchase_request.req_email).apv3
       #          @@apv4 = ''
        #      else
         #        @@apv2 = PrApproval.find_by(requester: @purchase_request.req_email).apv2
          #       @@apv3 = PrApproval.find_by(requester: @purchase_request.req_email).apv3
           #      @@apv4 = PrApproval.find_by(requester: @purchase_request.req_email).apv4
           #   end   
          # end 
     # end

      #Jika Terjadi Perubahan Status dan Di Approve
      if params[:status] == 'Approved' && @purchase_request.status != 'Draft'
          @@laststatus = @purchase_request.status
          @@newstatus = 'Approval - 1'
          
          #check approval 1

          if @purchase_request.approval1 != "" && @purchase_request.apv_date1.nil? && current_user.email == @purchase_request.approval1
             @purchase_request.status = 'Approval - 1'
             @purchase_request.apv_date1 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
             @@newstatus = 'Approval - 1'
             
          else
            #Approval 2 
          
            if @purchase_request.approval2 != "" && @purchase_request.apv_date2.nil? && current_user.email == @purchase_request.approval2
               @purchase_request.status = 'Approval - 2'
               @purchase_request.apv_date2 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
               @@newstatus = 'Approval - 2'
            else
               #Approval 3 
               if @purchase_request.approval3 != "" && @purchase_request.apv_date3.nil? && current_user.email == @purchase_request.approval3
                 @purchase_request.status = 'Approval - 3'
                 @purchase_request.apv_date3 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                 @@newstatus = 'Approval - 3'

               else
                  if @purchase_request.approval4 != "" && @purchase_request.apv_date4.nil? && current_user.email == @purchase_request.approval4
                     @purchase_request.status = 'Approved'
                     @purchase_request.apv_date4 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                     @@newstatus = 'Approved'
                  else
                    #raise "You're not authorized to perform approval"
                    #byebug
                    respond_to do |format|
                      flash[:alert] = "You're not authorized to perform approval in this document"
                      format.html { redirect_to purchase_requests_url,:action => 'index', alert: "You're not authorized to perform approval in this document." }
                    end
                  end
                end
            end  
          end  
        end
     


      #Jika Di Reject
      if params[:status] == 'Rejected' && @purchase_request.status != 'Draft'
         @@laststatus = @purchase_request.status
         @@newstatus = 'Rejected'
         @purchase_request.status = 'Rejected'
      end


  end

  # POST /purchase_requests
  # POST /purchase_requests.json
  def create


    @purchase_request = PurchaseRequest.new(purchase_request_params)
   
    #@pr_item = PurchaseRequestItem.new
    @supplier = Supplier.all
    @costcenter = Costcenter.all
    @dept = Dept.all
    @product = Product.all




    #@purchase_request.status = 'Draft'
    @purchase_request.user_id = current_user.id
    @purchase_request.req_email = current_user.email
    @purchase_request.account = current_user.emp_id
    @purchase_request.department = Department.find_by(id: current_user.department_id).name
    @purchase_request.requester = current_user.name

  
    unless @purchase_request.required_date.nil? || @purchase_request.request_date.nil?  
    if ( @purchase_request.required_date -  @purchase_request.request_date).to_i <30 
        flash[:alert] = ' Delivery Date should me minimum 30days from Request Date'
        render 'new'
    else  

        #Load tabel Approval 
      if PrApproval.find_by(requester: current_user.email).nil? == false
         #@purchase_request.approval1 = PrApproval.find_by(requester: current_user.email).apv1
         #@purchase_request.approval2 = PrApproval.find_by(requester: current_user.email).apv2
         #@purchase_request.approval3 = PrApproval.find_by(requester: current_user.email).apv3
         #@purchase_request.approval4 = PrApproval.find_by(requester: current_user.email).apv4
         @purchase_request.pic = PrApproval.find_by(requester: current_user.email).pic
      
      end
        


          respond_to do |format|
          
            if @purchase_request.save
              format.html { redirect_to @purchase_request, notice: 'Purchase request was successfully created.' }
              format.json { render :edit, status: :created, location: @purchase_request }
            else
              format.html { render :new }
              format.json { render json: @purchase_request.errors, status: :unprocessable_entity }
            end
          end
        end
    else
      flash[:alert] = 'Request Date / Required Date is missing'
      render 'new'
    end
    
  end




  # PATCH/PUT /purchase_requests/1
  # PATCH/PUT /purchase_requests/1.json
  def update

     respond_to do |format|

        @purchase_request = PurchaseRequest.find(params[:id])
        @@newstatus = params[:status] 
        @@laststatus = @purchase_request.status

        ##Check Status Release atau Draft
        #if @@newstatus == 'Released' && @purchase_request.status == 'Draft'
        #   @@laststatus = @purchase_request.status
        #   @purchase_request.status = 'Released'
        #end
          
        #Refresh Approval by Amount
#        if PrApproval.find_by(requester: @purchase_request.req_email).nil? == false
#           @purchase_request.approval1 = PrApproval.find_by(requester: @purchase_request.req_email).apv1
#           @purchase_request.pic = PrApproval.find_by(requester: @purchase_request.req_email).pic
           
           #Check Plafond
 #          if @purchase_request.price  < PrApproval.find_by(requester: @purchase_request.req_email).apv2_amount
 #             @purchase_request.approval2 = PrApproval.find_by(requester:  @purchase_request.req_email).apv2
 #             @purchase_request.approval3 = ''
 #             @purchase_request.approval4 = ''
 #          else
 #             if @purchase_request.price  < PrApproval.find_by(requester: @purchase_request.req_email).apv3_amount
 #                @purchase_request.approval2 = PrApproval.find_by(requester: @purchase_request.req_email).apv2
 #                @purchase_request.approval3 = PrApproval.find_by(requester: @purchase_request.req_email).apv3
 #                @purchase_request.approval4 = ''
  #            else
  #               @purchase_request.approval2 = PrApproval.find_by(requester: @purchase_request.req_email).apv2
  #               @purchase_request.approval3 = PrApproval.find_by(requester: @purchase_request.req_email).apv3
  #               @purchase_request.approval4 = PrApproval.find_by(requester: @purchase_request.req_email).apv4
  #            end   
  #         end 
  #      end


        #Jika Terjadi Perubahan Status
        if @@laststatus != @@newstatus && @@laststatus != "" && @@newstatus != 'Rejected'
            # Released => Approval 1
            if current_user.email == @purchase_request.req_email && @purchase_request.status == "Released"
              # Released => Approval 1
           
              if @purchase_request.approval1.nil? || @purchase_request.approval1 == ""
                  if @purchase_request.approval2.nil? || @purchase_request.approval2 == ""
                    if @purchase_request.approval3.nil? || @purchase_request.approval3 == ""

                       UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval4).deliver_later
                    else
                       UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval3).deliver_later
                    end
                  else
                    UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval2).deliver_later
                  end   
              else
                 UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval1).deliver_later
              end  
            else
              # Approval 1 => Approval 2
              
              if @purchase_request.approval1 != "" && @purchase_request.apv_date1.nil? && current_user.email == @purchase_request.approval1
                 
                 @purchase_request.status = 'Approval - 1'
                 @purchase_request.apv_date1 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                 @@newstatus = 'Approval - 1'
               
              
                 if @purchase_request.approval2.nil? || @purchase_request.approval2 == ""
                    if @purchase_request.approval3.nil? || @purchase_request.approval3 == ""
                        
                       UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval4).deliver_later
                    else
                        
                       UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval3).deliver_later
                    end
                 else
                    
                    UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval2).deliver_later
                 end   
             

              else
                # Approval 2 => Approval 3
                if @purchase_request.approval2 != "" && @purchase_request.apv_date2.nil? && current_user.email == @purchase_request.approval2
                    
                   @purchase_request.status = 'Approval - 2'
                   @purchase_request.apv_date2 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                   @@newstatus = 'Approval - 2'
                   #UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval3).deliver_later
                   if @purchase_request.approval3.nil? || @purchase_request.approval3 == ""
                       if @purchase_request.approval4.nil? || @purchase_request.approval4 == ""
                          #Approval Terakhir Level 2
                          @purchase_request.status = 'Approved'
                          @purchase_request.apv_date2 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                          @@newstatus = 'Approved'
                          UserMailer.reqapv_purchase_request2(@purchase_request,@purchase_request.req_email,User.find_by(name: @purchase_request.pic).email).deliver_later
                       
                       else  
                          UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval4).deliver_later
                       end
                   else
                       UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval3).deliver_later
                   end
                else
                   # Approval 3 => Approval 4
                   if @purchase_request.approval3 != "" && @purchase_request.apv_date3.nil? && current_user.email == @purchase_request.approval3
                      
                      @purchase_request.status = 'Approval - 3'
                      @purchase_request.apv_date3 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                      @@newstatus = 'Approval - 3'
                      #check apakah approval terahir di level 3
                      if @purchase_request.approval4.nil? || @purchase_request.approval4 == ""
                        #Approval Terakhir Level 2

                        @purchase_request.status = 'Approved'
                        @purchase_request.apv_date3 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                        @@newstatus = 'Approved'
                        UserMailer.reqapv_purchase_request2(@purchase_request,@purchase_request.req_email,User.find_by(name: @purchase_request.pic).email).deliver_later
                      else  
                        UserMailer.reqapv_purchase_request1(@purchase_request,@purchase_request.approval4).deliver_later
                      end
                    else
                      if @purchase_request.approval4 != "" && @purchase_request.apv_date4.nil? && current_user.email == @purchase_request.approval4
                           @purchase_request.status = 'Approved'
                           @purchase_request.apv_date4 = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                           @@newstatus = 'Approved'
                           UserMailer.reqapv_purchase_request2(@purchase_request,@purchase_request.req_email,User.find_by(name: @purchase_request.pic).email).deliver_later
               
                      else
                           
                           format.html { redirect_to purchase_requests_url,:action => 'index', alert: "You're not authorized to perform approval in this document / You're not part of DOA." }
                      end
                    end
                
                end  
              end
            end
        end


        #Jika Di Reject
        if @@laststatus != @@newstatus && params[:status] == 'Rejected' ##&& @purchase_request.status != 'Approved'
           @purchase_request.status = 'Rejected'
           @@newstatus = 'Rejected'
           #kirim email ke requester
           UserMailer.reqapv_purchase_request3(@purchase_request,@purchase_request.req_email,User.find_by(name: @purchase_request.pic).email).deliver_later
        end
       
  
        if @purchase_request.update(purchase_request_params)
          format.html { redirect_to @purchase_request, notice: 'Purchase request is successfully updated' }
          format.json { render :edit, status: :ok, location: @purchase_request }
        else
          format.html { render :edit }
          format.json { render json: @purchase_request.errors, status: :unprocessable_entity }
        end
    end     
  end

  # DELETE /purchase_requests/1
  # DELETE /purchase_requests/1.json
  def destroy
    @purchase_request.destroy
    respond_to do |format|
      format.html { redirect_to purchase_requests_url, notice: 'Purchase request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_request
      @purchase_request = PurchaseRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_request_params
      
       if params[:action] == "update"
          params.permit(:purchase_request)# (:_method, :authenticity_token, :purchase_request, :commit, :id)  
       else 

      params.require(:purchase_request).permit(
        :id,
        :no, 
        :user_id, 
        :requester, 
        :status,  
        :request_date, 
        :required_date, 
        :req_email, 
        :approval1, 
        :approval2, 
        :approval3, 
        :approval4, 
        :apv_date1, 
        :apv_date2, 
        :apv_date3, 
        :apv_date4, 
        :apv_remarks,
	:approval_group, 
        :notes, 
        :price, 
        :purpose,
        :pic, 
        #:detail, 
        :allocation, 
        :account, 
        :item, 
        :supplier, 
        :department, 
        :is_newgoods, 
        :is_reorder,
        :costcenter, 
        :supplier_reason,
        attachment1:[],
        :purchase_request_items_attributes => 
          [ :purchase_request_id, 
            :product,
            :costcenter,
            :description, 
            :no, 
            :quantity,
            :dept,
            :spesification,
            :_destroy,
            :id
          ]
        

        )     
     
       end 
   
    end

   
  
end

