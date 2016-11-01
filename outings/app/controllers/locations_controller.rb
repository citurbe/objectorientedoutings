class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])

    # @review_chart_data = @location.reviews_chart_data
    @column_chart_library = @location.column_chart_library
    mapper = Mapper.new(@location)
    @map_string = mapper.run
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
    redirect_to location_path(@location)
  end

  private
  def location_params
    params.require(:location).permit(:name, :address)
  end
end
