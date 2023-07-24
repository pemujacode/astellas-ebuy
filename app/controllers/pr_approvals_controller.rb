class PrApprovalsController < ApplicationController
  before_action :set_pr_approval, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource

  # GET /pr_approvals
  # GET /pr_approvals.json

     respond_to :js, :json, :html
  def getGroup()

     #@Expense = Expense.find_by(costcenter: params[:costcenter])
     #@Po = Expense.where(:costcenter => params[:supplier])
     @Group = PrApproval.find_by_sql("SELECT * FROM pr_approvals WHERE trans='" + params[:trans] + "' and approval_group='" + params[:group] + "' and requester like '%%" + params[:requester] + "%%'").first



     respond_with @Group


    
  end

  def index
    @pr_approvals = PrApproval.all
  end

  # GET /pr_approvals/1
  # GET /pr_approvals/1.json
  def show
    
  end

  # GET /pr_approvals/new
  def new
    @pr_approval = PrApproval.new
  end

  # GET /pr_approvals/1/edit
  def edit
  end

  # POST /pr_approvals
  # POST /pr_approvals.json
  def create
    @pr_approval = PrApproval.new(pr_approval_params)

    respond_to do |format|
      if @pr_approval.save
        format.html { redirect_to @pr_approval, notice: 'Pr approval was successfully created.' }
        format.json { render :show, status: :created, location: @pr_approval }
      else
        format.html { render :new }
        format.json { render json: @pr_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pr_approvals/1
  # PATCH/PUT /pr_approvals/1.json
  def update
    respond_to do |format|
      if @pr_approval.update(pr_approval_params)
        format.html { redirect_to @pr_approval, notice: 'Pr approval was successfully updated.' }
        format.json { render :show, status: :ok, location: @pr_approval }
      else
        format.html { render :edit }
        format.json { render json: @pr_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pr_approvals/1
  # DELETE /pr_approvals/1.json
  def destroy
    @pr_approval.destroy
    respond_to do |format|
      format.html { redirect_to pr_approvals_url, notice: 'Pr approval was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pr_approval
      @pr_approval = PrApproval.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pr_approval_params
      params.require(:pr_approval).permit(:requester,:approval_group, :trans, :apv1, :apv1_amount, :apv2, :apv2_amount, :apv3, :apv3_amount, :apv4, :apv4_amount, :is_active, :pic)
    end
end
