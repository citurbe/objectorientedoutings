class PlanEditor
  attr_reader :current_user, :timing, :loc

  def initialize(params:, current_user:, plan: )
    @current_user = current_user
    @timing = params[:timing]
    @loc = get_loc(params)
    @plan = plan
  end

  def get_loc(params)
    if params[:location] != "" && !params[:location] != nil
      Location.create(name: params[:location])

    else
      Location.find(params[:location_id])
    end
  end

  def run
    @plan.update(location: @loc, timing: @timing)
    @plan
  end
end
