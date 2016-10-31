class LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @chartdata = @location.reviews.group(:score).count.map do |key,val|
      ["Rated #{key}",val]
    end
    @library = {library:{
      pieSliceText: 'label',
      width:600,
      tooltip:{
        text:'value',
        ignoreBounds: true
      },
      legend: 'none'
      }}
  end
end
