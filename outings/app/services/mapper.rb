class Mapper
  attr_reader :location



  def initialize(location)
    @location = location
  end

  def search_string

    search_name = self.location.name.gsub(/\'/, '').split(" ").join("+")
    if self.location.address != "" && self.location.address != nil
      search_address = self.location.address.gsub(/\'/, '').split(/[\s,]+/).join("+")
      "#{search_name}+#{search_address}"
    else
      "#{search_name}+11+broadway+NY"
    end
  end

  def map_string
    "https://www.google.com/maps/embed/v1/search?q=#{search_string}&key=AIzaSyAGMGxxbUMxzPUR1t6NDI-dThf8Nab34AQ&zoom=14"
  end

  def run
    self.map_string
  end

end
