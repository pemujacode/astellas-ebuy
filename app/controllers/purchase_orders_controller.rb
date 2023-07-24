class PurchaseOrdersController < ApplicationController
 

  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]
  layout "print", except: [:index, :update,:create, :new, :edit]
  load_and_authorize_resource

    @@laststatus=''
    @@newstatus=''
    @@apv1=''
    @@apv2=''
    @@Review=''
    @@Approve=''
    @@doctype=''
    @@po_item_temp = ''
   
    

  respond_to :js, :json, :html
  def getPO()

     #@Expense = Expense.find_by(costcenter: params[:costcenter])
     #@Po = Expense.where(:costcenter => params[:supplier])
     @Po = PurchaseOrder.find_by_sql("SELECT * FROM purchase_orders WHERE supplier like'%%" + params[:supplier] + "%%' and status NOT IN ('Draft','Closed','Rejected') ")

     respond_with @Po


    
  end


  def SetLineValue()



      @po_item1 =  '[{"description": "' + params[:description] + '","spesification": "' + params[:spesification] + '","price":"' + params[:price] + '","quantity":"' + params[:quantity] + '","product":"' + params[:product] + '","purch":"' + params[:purch] + '","dept":"' + params[:dept] + '","total": "' + params[:total] + '"}]'
    #@po_item1 =  '[ {"description" : "' + params[:description] + '" , "spesification" : "' + params[:spesification] + '" }]'







    if @@po_item_temp.nil?
       @@po_item_temp = @po_item1 

    else



       @@po_item_temp =  @@po_item_temp + "," + @po_item1
    
          

    end


      
  end



  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    @purchase_orders = PurchaseOrder.all
    if current_user.role == 'User'
       @purchase_orders = PurchaseOrder.where(user_id: current_user.id)
    else
      @purchase_orders = PurchaseOrder.all
    end
    

  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json


    
  def show
    @purchase_orders = PurchaseOrder.find(params[:id])
    @po_item = PurchaseOrderItem.where(:purchase_order_id => params[:id]).order("id ASC")

    
      respond_to do |format|
            format.html
            format.pdf do
                render pdf: "Purchase Order No. #{@purchase_orders.no}",
                page_size: 'A4',
                template: "purchase_orders/show.html.erb",
                layout: "pdf.html",
                lowquality: true,
                zoom: 1,
                dpi: 75
            end
          end
  

  end

  # GET /purchase_orders/new
  def new
    #Set Initial Value
    @purchase_order = PurchaseOrder.new
    @po_item = PurchaseOrderItem.new
    @@po_item_temp = nil
  
    @supplier = Supplier.all
    @costcenter = Costcenter.all
    @expense = Expense.all
    @dept = Dept.all
    @product = Product.all


    if params[:doctype] == 'Item'
      @purchase_order.doctype = 'Item'
      @@doctype = 'Item'
    else
       @purchase_order.doctype = 'Service'
       @@doctype = 'Service'
    end


    





    @po_item.price = 0
    @po_item.quantity = 0
    @po_item.amount = 0

    @purchase_order.total = 0
    @purchase_order.vat = 0
    @purchase_order.grand_total = 0
    @purchase_order.disc = 0
    @purchase_order.totbefdisc = 0
    
    
      
    
    
    #@purchase_order.status = 'Draft'
    @purchase_order.user_id = current_user.id
    @purchase_order.account = current_user.emp_id
    @purchase_order.prepared_by = current_user.email
    #@purchase_order.remarks = 'PT. Astellas Pharma Indonesia 5th Floor, Plaza Oleos, Jl. TB Simatupang No. 53 A Jakarta Selatan 12520, Indonesia Tel :  +62 21 22780171, Fax : +62 21 22780180 '

    @purchase_order.department = Department.find_by(id: current_user.department_id).name

    
    @purchase_order.po_date =  DateTime.parse(Date.today.to_s).strftime("%d/%m/%Y")
    @purchase_order.delivery_date =  DateTime.parse((Date.today+30).to_s).strftime("%d/%m/%Y") 
    
    

    #Load tabel Approval 
    if PoApproval.find_by(requester: current_user.email).nil? == false
       @purchase_order.reviewed_by = PoApproval.find_by(requester: current_user.email).apv1
       @purchase_order.approved_by = PoApproval.find_by(requester: current_user.email).apv2
     


    end
    
   #@purchase_order.expense_id = Expense.find_by(code: @purchase_order.expense_id).id
    
     #DateTime.strptime(Date.today.to_s,"%d/%m/%y")



  end

  # GET /purchase_orders/1/edit
  def edit
    @purchase_order = PurchaseOrder.find(params[:id])
    @po_item = PurchaseOrderItem.find_by(purchase_order_id: params[:id])
    #@po_item = PurchaseOrderItem.where(:purchase_order_id => params[:id]).order("id ASC")
# @po_item = PurchaseOrderItem.order("id").find_by(purchase_order_id: params[:id])
#   @po_item = PurchaseOrderItem.where(purchase_order_id: params[:id]).order("id ASC")
#  @po_item = PurchaseOrderItem.find_by_sql("SELECT * FROM purchase_order_items WHERE purchase_order_id =" + params[:id] + " order by id")

 

    @supplier = Supplier.all
    @costcenter = Costcenter.all
    @dept = Dept.all
    @product = Product.all
    @expense = Expense.all





     #if params[:status] == 'Released' && @purchase_order.status == 'Draft'
     #   @@laststatus = @purchase_order.status
     #   @purchase_order.status = 'Released'
     #   @@newstatus = 'Released'

     #end

     #refresh matrix
     if PoApproval.find_by(requester: @purchase_order.prepared_by).nil? == false
           @@Review = PoApproval.find_by(requester: @purchase_order.prepared_by).apv1
           @@Approve = PoApproval.find_by(requester: @purchase_order.prepared_by).apv2
          
           if @purchase_order.status == 'Draft'
           #Check Plafond
           unless @purchase_order.total < PoApproval.find_by(requester: @purchase_order.prepared_by).apv1_amount  
              @purchase_order.approved_by = PoApproval.find_by(requester: @purchase_order.prepared_by).apv2             
           else
              @purchase_order.approved_by = ""
           end
            end 
     end


     #perubahan status   
     if params[:status] == 'Approved' && @purchase_order.status != 'Draft'


        @@laststatus = @purchase_order.status
        @@newstatus = 'Approval - 1'
        
        #check approval 1

        if @purchase_order.reviewed_by != "" && @purchase_order.review_date.nil? && current_user.email == @purchase_order.reviewed_by
           @purchase_order.status = 'Approval - 1'
           @purchase_order.review_date = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
           @@newstatus = 'Approval - 1'
           
        else
          #Approval 2 
          if @purchase_order.approved_by != "" && @purchase_order.apv_date.nil? && current_user.email == @purchase_order.approved_by
             @purchase_order.status = 'Approved'
             @purchase_order.apv_date = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
             @@newstatus = 'Approved'
          else
            #raise "You're not authorized to perform approval"
            respond_to do |format|
              #flash[:alert] = "You're not authorized to perform approval in this document"
              format.html { redirect_to purchase_orders_url,:action => 'index', alert: "You're not authorized to perform approval in this document." }
            end
          end  
        end  
       end

     



      #Jika Di Reject
      if params[:status] == 'Rejected' && @purchase_order.status != 'Approved'
    
         @@laststatus = @purchase_order.status
         @@newstatus = 'Rejected'
         @purchase_order.status = 'Rejected'
      end
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create

    @purchase_order = PurchaseOrder.new(purchase_order_params)
    @supplier = Supplier.all
    @costcenter = Costcenter.all
    @dept = Dept.all
    @product = Product.all
    @expense = Expense.all
    @purchase_order.po_item_temp = @@po_item_temp
    @@po_item_temp = nil







    #@purchase_order.status = 'Draft'
    if @purchase_order.doctype == 'Item' || params[:doctype] == 'Item' || @@doctype == 'Item'
   
       @purchase_order.doctype = 'Item'
    else
  
       @purchase_order.doctype = 'Service'
    end


    
    @purchase_order.user_id = current_user.id
    @purchase_order.account = current_user.emp_id
    @purchase_order.prepared_by = current_user.email
    #@purchase_order.remarks = 'PT. Astellas Pharma Indonesia 5th Floor, Plaza Oleos, Jl. TB Simatupang No. 53 A Jakarta Selatan 12520, Indonesia Tel :  +62 21 22780171, Fax : +62 21 22780180 '
    #@purchase_order.no = @purchase_order.id
    @purchase_order.department = Department.find_by(id: current_user.department_id).name
    @purchase_order.address = Supplier.find_by(name: @purchase_order.supplier).address
    

    
    if PoApproval.find_by(requester: current_user.email).nil? == false

       @purchase_order.reviewed_by = PoApproval.find_by(requester: current_user.email).apv1
       @purchase_order.approved_by = PoApproval.find_by(requester: current_user.email).apv2
     
    end
  
  
    respond_to do |format|
      if @purchase_order.save
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_order }
      else
        @@po_item_temp = nil
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    respond_to do |format|

   

        @purchase_order = PurchaseOrder.find(params[:id])
        @@newstatus = params[:status] 
        @@laststatus = @purchase_order.status

        #if @@newstatus == 'Released' && @purchase_order.status == 'Draft'
        #   @@laststatus = @purchase_order.status
        #   @purchase_order.status = 'Released'
        #end


        #Refresh Approval by Amount
   

        if PoApproval.find_by(requester: @purchase_order.prepared_by).nil? == false && @@newstatus != 'Rejected'
           @purchase_order.reviewed_by = PoApproval.find_by(requester: @purchase_order.prepared_by).apv1
           @purchase_order.approved_by = PoApproval.find_by(requester: @purchase_order.prepared_by).apv2
          
           #Check Plafond
           unless @purchase_order.total < PoApproval.find_by(requester: @purchase_order.prepared_by).apv1_amount  
              @purchase_order.approved_by = PoApproval.find_by(requester: @purchase_order.prepared_by).apv2             
           else
               
              @purchase_order.approved_by = ""
           end 
        end


        #Jika Terjadi Perubahan Status

        if @@laststatus != @@newstatus && @@laststatus != "" && @@newstatus != 'Rejected'
           # Released => Approval 1
           
           if current_user.email == @purchase_order.prepared_by && @purchase_order.status == "Released"
              # Released => Approval 1
             
              if @@Review.nil? || @@Review == ""
                  if @@Approve.nil? || @@Approve == ""
                  else
                    UserMailer.reqapv_purchase_order1(@purchase_order,@purchase_order.approved_by).deliver_later
                  end   
              else
             
                  UserMailer.reqapv_purchase_order1(@purchase_order,@purchase_order.reviewed_by).deliver_later
              end  
           else
              # Approval 1 => Approval 2
              if @purchase_order.reviewed_by != "" && @purchase_order.review_date.nil? && current_user.email == @purchase_order.reviewed_by
                 @purchase_order.status = 'Approval - 1'
                 @purchase_order.review_date = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                 @@newstatus = 'Approval - 1'
              
                 if @purchase_order.approved_by.nil? || @purchase_order.approved_by == ""
                   
                    @purchase_order.status = 'Approved'
                    @purchase_order.apv_date = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                    @@newstatus = 'Approved'
                    UserMailer.reqapv_purchase_order2(@purchase_order,@purchase_order.prepared_by).deliver_later
                 else
                    UserMailer.reqapv_purchase_order1(@purchase_order,@purchase_order.approved_by).deliver_later
                 end   
             

              else
                
                if @purchase_order.approved_by != "" && @purchase_order.apv_date.nil? && current_user.email == @purchase_order.approved_by
                   
                   @purchase_order.status = 'Approved'
                   @purchase_order.apv_date = DateTime.parse(DateTime.now.to_s).strftime("%d/%m/%Y %R")
                   @@newstatus = 'Approved'
                   UserMailer.reqapv_purchase_order2(@purchase_order,@purchase_order.prepared_by).deliver_later
       
                else
                   respond_to do |format|
                      format.html { redirect_to purchase_orders_url,:action => 'index', alert: "You're not authorized to perform approval in this document." }
                   end  
                end
              end
            end
        end    

        #Jika Di Reject
        if @@laststatus != @@newstatus && params[:status] == 'Rejected' && @purchase_order.status != 'Approved'
          
           @purchase_order.status = 'Rejected'
           #kirim email ke requester
           UserMailer.reqapv_purchase_order3(@purchase_order,@purchase_order.req_email).deliver_later
          
        end
          
  

      if @purchase_order.update(purchase_order_params)
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_order }
      else
        format.html { render :edit }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    @purchase_order.destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Purchase order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      #params.require(:purchase_order).permit(:no, :supplier_id, :po_date, :delivery_date, :buyer, :terms_payment, :status, :prepared_by, :reviewed_by, :total, :vat, :grand_total)
      if params[:action] == "update"
          params.permit(:purchase_order)# (:_method, :authenticity_token, :purchase_request, :commit, :id)  
       else 
          params.require(:purchase_order).permit(:id,:is_vat,:sapno,:disc,:doctype, :address, :remarks,:pic, :no, :supplier, :po_date,:currency, :delivery_date, :buyer, :terms_payment, :status, :prepared_by, :reviewed_by, :total, :vat, :grand_total, :approved_by, :apv1_date, :supplier, :attn, attachment1:[], 
            :purchase_order_items_attributes => [:purchase_order_id,:item, :product,:description, :dept, :no, :spesification, :req_qty, :costcenter, :price, :quantity,  :amount, :_destroy,:id] )
      end

    end
end


