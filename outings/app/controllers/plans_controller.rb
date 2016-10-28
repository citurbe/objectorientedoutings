class PlansController < ApplicationController

  def new
    @plan = Plan.new
  end

  def create
    return redirect_to new_plan_path if params[:plan][:timing] == "" || (params[:plan][:location_id] == "" && params[:plan][:location] == "")

    @plan = Plan.new(plan_params(:timing))
    @plan.location_id, @plan.organizer_id, @plan.organization_id = get_loc(params), current_user.id, 1
    if @plan.save
      Outing.create(user_id: current_user.id, plan_id: @plan.id)
      redirect_to plan_path(@plan)
    else
      redirect_to new_plan_path
    end
  end

  def get_loc(params)
    #byebug
    if params[:plan][:location_id] != "" && !params[:plan][:location_id] != nil
      Location.find(params[:plan][:location_id]).id
    else

      make_loc(params).id
    end
  end

  def make_loc(params)
    location = Location.new(name: params[:plan][:location])
  #  byebug
    if location.save
      location
    else
      redirect_to new_plan_path
    end
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
    byebug
    Outing.destroy(Outing.where(["plan_id = ? and user_id = ?", params[:id], current_user.id]))
    redirect_to plan_path(params[:id])
  end

  private

  def plan_params(*args)
    params.require(:plan).permit(args)
  end

end
