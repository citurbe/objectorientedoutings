class PlanMaker
  attr_reader :current_user, :timing, :loc

  def initialize(params:, current_user:)
    @current_user = current_user
    @timing = params[:timing]
    @loc = get_loc(params)
  end

  def get_loc(params)
    if params[:location_id] != "" && !params[:location_id] != nil
      Location.find(params[:location_id])
    else
      Location.create(name: params[:location])
    end
  end

  def run
    @plan = Plan.new(location:@loc, organizer:@current_user, timing:@timing, organization:@current_user.organization)
    Outing.create(user: @current_user, plan: @plan)
    @plan.save
    @plan
  end
end
