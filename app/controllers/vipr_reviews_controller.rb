class ViprReviewsController < ApplicationController
  before_action :set_vipr_review, only: [:show, :edit, :update, :destroy]

  # GET /vipr_reviews
  # GET /vipr_reviews.json
  def index
    @vipr_reviews = ViprReview.all
  end

  # GET /vipr_reviews/1
  # GET /vipr_reviews/1.json
  def show
  end

  # GET /vipr_reviews/new
  def new
    @vipr_review = ViprReview.new
  end

  # GET /vipr_reviews/1/edit
  def edit
  end

  # POST /vipr_reviews
  # POST /vipr_reviews.json
  def create
    @vipr_review = ViprReview.new(vipr_review_params)

    respond_to do |format|
      if @vipr_review.save
        format.html { redirect_to @vipr_review, notice: 'Vipr review was successfully created.' }
        format.json { render :show, status: :created, location: @vipr_review }
      else
        format.html { render :new }
        format.json { render json: @vipr_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vipr_reviews/1
  # PATCH/PUT /vipr_reviews/1.json
  def update
    respond_to do |format|
      if @vipr_review.update(vipr_review_params)
        format.html { redirect_to @vipr_review, notice: 'Vipr review was successfully updated.' }
        format.json { render :show, status: :ok, location: @vipr_review }
      else
        format.html { render :edit }
        format.json { render json: @vipr_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vipr_reviews/1
  # DELETE /vipr_reviews/1.json
  def destroy
    @vipr_review.destroy
    respond_to do |format|
      format.html { redirect_to vipr_reviews_url, notice: 'Vipr review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vipr_review
      @vipr_review = ViprReview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vipr_review_params
      params.require(:vipr_review).permit(:name, :title, :email, :plafond, :order)
    end
end
