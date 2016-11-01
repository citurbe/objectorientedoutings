class PlansController < ApplicationController

  def new
    @plan = Plan.new
  end

  def create
    # byebug

    if params[:plan][:timing] == "" || (params[:plan][:location_id] == "" && params[:plan][:location] == "")
      flash[:notice] = "Missing required information"
      return redirect_to new_plan_path
    end
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
    if params[:plan][:timing] == "" || (params[:plan][:location_id] == "" && params[:plan][:location] == "")
      flash[:notice] = "Missing required information"
      return redirect_to edit_plan_path
    end
    @plan = Plan.find(params[:id])
    plan_editor = PlanEditor.new(params:params[:plan], current_user: current_user, plan: @plan)
    redirect_to plan_path plan_editor.run
  end

  def destroy
    Plan.find(params[:id]).destroy
    Outing.destroy(Outing.all.select{|out| out.plan_id == params[:id]})
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
