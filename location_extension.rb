require_dependency 'application_controller'
require_dependency 'geo_kit/mappable'
require_dependency 'geo_kit/acts_as_mappable'
require_dependency 'geo_kit/ip_geocode_lookup'
require_dependency 'location_geo_kit'

require 'radiant-location-extension/version'

class LocationExtension < Radiant::Extension
  version RadiantLocationExtension::VERSION
  description 'Radiant Location Extension'
  url 'https://github.com/adsmart/radiant-location-extension'
  
  def activate
    ActiveRecord::Base.send :include, GeoKit::ActsAsMappable
    ActionController::Base.send :include, GeoKit::IpGeocodeLookup
    Page.send :include, LocationsTags
    tab 'Content' do
      add_item   "Locations", "/admin/locations", :after => "Pages"
    end
    Radiant::AdminUI.class_eval do
      attr_accessor :locations
    end
    admin.locations = load_default_location_regions
    LocationFinderPage
  end
  
  def deactivate
     # admin.tabs.remove "Locations"
  end
  
  private
  # Defines this extension's default regions (so that we can incorporate shards
  # into its views).
  def load_default_location_regions
    returning OpenStruct.new do |locations|
      locations.edit = Radiant::AdminUI::RegionSet.new do |edit|
        edit.main.concat %w{edit_header edit_form}
        edit.form.concat %w{edit_title edit_group edit_full_address edit_website_url edit_page_path edit_geocode}
        edit.form_bottom.concat %w{edit_timestamp edit_buttons}
      end
      locations.new = locations.edit.clone
    end
  end
  
 



  
end