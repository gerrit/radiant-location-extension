GeoKit.class_eval do
  class << self
    [:default_units, :default_formula].each do |sym|
      define_method sym do
        Radiant::Config["geokit.#{sym}"].to_sym
      end
      
      define_method "#{sym}=" do |obj|
        Radiant::Config["geokit.#{sym}"] = obj
      end
    end
  end
end

GeoKit::Geocoders.class_eval do
  class << self
    [:yahoo, :google, :geocoder_us, :geocoder_ca, :proxy_addr, :proxy_port, :proxy_user, :proxy_pass].each do |sym|
      define_method sym do
        val = Radiant::Config["geokit.geocoders.#{sym}"]
        if val.strip.downcase.eql?("nil")
          nil
        else
          val
        end
      end
      
      define_method "#{sym}=" do |obj|
        Radiant::Config["geokit.geocoders.#{sym}"] = obj
      end
    end
  end
end

GeoKit::Geocoders.class_eval do
  def self.provider_order
    #    puts Radiant::Config["geokit.geocoders.provider_order"]
    Radiant::Config["geokit.geocoders.provider_order"].split(" ").map { |s| s.to_sym }
  end
  def self.timeout
    val = Radiant::Config["geokit.geocoders.timeout"]
    if val.strip.downcase.eql?("nil")
      nil
    else
      val.to_i
    end
  end
  def self.timeout=(obj)
    Radiant::Config["geokit.geocoders.timeout"] = obj
  end
end
