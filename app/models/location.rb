class Location < ActiveRecord::Base
  # Associations
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'

  acts_as_mappable :default_units => :kms
  before_validation :geocode_address
  
  default_scope :order => 'name'
  
  after_save :clear_page_cache
  
  def self.optional_fields
    [:tel, :email, :street_address, :postal_code, :locality, :region, :country_name]
  end
  
  def self.enabled_fields
    optional_fields
  end
  
  def full_address
    self[:full_address] || "#{street_address} #{postal_code} #{locality} #{country_name}"
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
