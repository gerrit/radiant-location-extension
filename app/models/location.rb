class Location < ActiveRecord::Base
  # Associations
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  acts_as_mappable :default_units => :kms
  before_validation :geocode_address
  
  default_scope :order => 'name'
  
  after_save :clear_page_cache
  
  # Returns json object in the form
  # {"location_name1":{"lat":0.1,"lng":0.2}, "location_name2":{"lat":0.2,"lng":0.4}}
  def self.json_coords
    all.inject({}) do |hash, location|
      unless location.lat.blank? || location.lng.blank?
        hash.tap{|h| h[location.name] = {
          :lat=>location.lat, :lng=>location.lng
        }}
      end
    end.to_json
  end
  
  private
  def geocode_address
    unless self.manual_geocode
      geo=GeoKit::Geocoders::MultiGeocoder.geocode self.full_address
      errors.add(:full_address, "Could not Geocode address") if !geo.success
      self.lat, self.lng = geo.lat,geo.lng if geo.success
    end
  end
  
  def clear_page_cache
    Radiant::Cache.clear
  end
  
end
