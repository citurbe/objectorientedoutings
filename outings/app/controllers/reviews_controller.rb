class ReviewsController < ApplicationController

  def new
    @location = Location.find(flash[:location_id]||params[:location_id])
    @review = Review.new(comment:flash[:comment])
  end

  def create
    @review = Review.new(review_params)
    if @review.valid?
      @review.save
      redirect_to location_path(params[:review][:location_id])
    else
      flash[:location_id]=params[:review][:location_id]
      flash[:comment]=params[:review][:comment]
      redirect_to new_review_path
    end
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.assign_attributes(review_params)
    if @review.valid?
      @review.save
      redirect_to review_path(@review)
    else
      redirect_to edit_review_path(@review)
    end
  end

private

  def review_params
    params.require(:review).permit(:user_id,:location_id,:score,:comment,:user_id)
  end

end
