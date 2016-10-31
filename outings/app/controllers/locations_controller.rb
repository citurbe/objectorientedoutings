class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])

    @pie_chart_data = @location.reviews.group(:score).count.map do |key,val|
      ["Rated #{key}",val]
    end
    @pie_chart_library = {library:{
      pieSliceText: 'label',
      width:600,
      tooltip:{
        text:'value',
        ignoreBounds: true
      },
      legend: 'none'
      }}

      @column_chart_library = {library:{
        width:600,
        vAxis:{
          gridlines: {count:0}
        }
        }}
  end
end
