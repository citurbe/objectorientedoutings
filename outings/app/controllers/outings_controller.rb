class OutingsController < ApplicationController

  def create
    Outing.create(user_id: current_user.id, plan_id: params[:id])
    redirect_to plan_path(params[:id])
  end

end
