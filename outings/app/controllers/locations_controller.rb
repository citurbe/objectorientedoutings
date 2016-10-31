class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])

    @review_chart_data = @location.reviews_chart_data
    @pie_chart_library = @location.pie_chart_library

    @column_chart_library = @location.column_chart_library
  end
end
