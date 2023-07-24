class PoApprovalsController < ApplicationController
  before_action :set_po_approval, only: [:show, :edit, :update, :destroy]

  # GET /po_approvals
  # GET /po_approvals.json
  def index
    @po_approvals = PoApproval.all
  end

  # GET /po_approvals/1
  # GET /po_approvals/1.json
  def show
  end

  # GET /po_approvals/new
  def new
    @po_approval = PoApproval.new
  end

  # GET /po_approvals/1/edit
  def edit
  end

  # POST /po_approvals
  # POST /po_approvals.json
  def create
    @po_approval = PoApproval.new(po_approval_params)

    respond_to do |format|
      if @po_approval.save
        format.html { redirect_to @po_approval, notice: 'Po approval was successfully created.' }
        format.json { render :show, status: :created, location: @po_approval }
      else
        format.html { render :new }
        format.json { render json: @po_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /po_approvals/1
  # PATCH/PUT /po_approvals/1.json
  def update
    respond_to do |format|
      if @po_approval.update(po_approval_params)
        format.html { redirect_to @po_approval, notice: 'Po approval was successfully updated.' }
        format.json { render :show, status: :ok, location: @po_approval }
      else
        format.html { render :edit }
        format.json { render json: @po_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /po_approvals/1
  # DELETE /po_approvals/1.json
  def destroy
    @po_approval.destroy
    respond_to do |format|
      format.html { redirect_to po_approvals_url, notice: 'Po approval was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_po_approval
      @po_approval = PoApproval.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def po_approval_params
      params.require(:po_approval).permit(:requester, :apv1, :apv1_amount, :apv2, :apv2_amount, :apv3, :apv3_amount, :is_active)
    end
end
