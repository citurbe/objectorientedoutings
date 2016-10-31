class PlansController < ApplicationController

  def new
    @plan = Plan.new
  end

  def create
    redirect_to new_plan_path if params[:plan][:timing] == "" || (params[:plan][:location_id] == "" && params[:plan][:location] == "")
    plan_maker = PlanMaker.new(params:params[:plan], current_user: current_user)
    redirect_to plan_path plan_maker.run
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    @plan.update_attributes(location_id: get_loc(params), timing: params[:plan][:timing])
    if !@plan.errors.messages.empty?
      flash[:notice] = @plan.errors.messages
      redirect_to edit_plan_path(@plan)
    else
      redirect_to plan_path(@plan)
    end

  end

  def destroy
    Plan.find(params[:id]).destroy
    redirect_to root_path
  end

  def leave
    Outing.destroy(Outing.where(["plan_id = ? and user_id = ?", params[:id], current_user.id]))
    redirect_to plan_path(params[:id])
  end

  def go
    Plan.find(params[:id]).time_to_go
    redirect_to root_path
  end

  private

  def plan_params(*args)
    params.require(:plan).permit(args)
  end

end
