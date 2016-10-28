class PlansController < ApplicationController

  def new
    @plan = Plan.new
  end

  def create
    return redirect_to new_plan_path if params[:plan][:timing] == "" || (params[:plan][:location_id] == "" && params[:plan][:location] == "")
    
    @plan = Plan.new(plan_params(:timing))
    @plan.location_id, @plan.organizer_id, @plan.organization_id = get_loc(params), current_user.id, 1
    if @plan.save
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
    @plan = Plan.new
  end

  def update

  end

  def destroy

  end

  private

  def plan_params(*args)
    params.require(:plan).permit(args)
  end

end
