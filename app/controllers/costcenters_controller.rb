class CostcentersController < ApplicationController
  before_action :set_costcenter, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /costcenters
  # GET /costcenters.json
  def index
    @costcenters = Costcenter.all

  end

  # GET /costcenters/1
  # GET /costcenters/1.json
  def show
    @costcenters = Costcenter.all
 
  end

  # GET /costcenters/new
  def new
    @costcenter = Costcenter.new
  end

  # GET /costcenters/1/edit
  def edit
  end

  # POST /costcenters
  # POST /costcenters.json
  def create
    @costcenter = Costcenter.new(costcenter_params)

    respond_to do |format|
      if @costcenter.save
        format.html { redirect_to @costcenter, notice: 'Costcenter was successfully created.' }
        format.json { render :show, status: :created, location: @costcenter }
      else
        format.html { render :new }
        format.json { render json: @costcenter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /costcenters/1
  # PATCH/PUT /costcenters/1.json
  def update
    respond_to do |format|
      if @costcenter.update(costcenter_params)
        format.html { redirect_to @costcenter, notice: 'Costcenter was successfully updated.' }
        format.json { render :show, status: :ok, location: @costcenter }
      else
        format.html { render :edit }
        format.json { render json: @costcenter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /costcenters/1
  # DELETE /costcenters/1.json
  def destroy
    @costcenter.destroy
    respond_to do |format|
      format.html { redirect_to costcenters_url, notice: 'Costcenter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_costcenter
      @costcenter = Costcenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def costcenter_params
      params.require(:costcenter).permit(:code, :name)
    end
end
