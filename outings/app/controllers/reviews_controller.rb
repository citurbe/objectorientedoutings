class ReviewsController < ApplicationController

  def new
    # byebug
    @location = Location.find(flash[:location_id]||params[:location_id])
    # @location = Location.find(1)
    @review = Review.new(comment:flash[:comment])
  end

  def create
    @review = Review.new(new_review_params)
    if @review.valid?
      @review.save
      redirect_to location_path(params[:review][:location_id])
    else
      # redirect_to new_review_path
      flash[:location_id]=params[:review][:location_id]
      flash[:comment]=params[:review][:comment]
      redirect_to new_review_path#, location_id:params[:review][:location_id], comment: params[:review][:comment]
    end
  end

private

  def new_review_params
    params.require(:review).permit(:user_id,:location_id,:score,:comment,:user_id)
  end

end
