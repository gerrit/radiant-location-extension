class LocationPage < Page
  description 'A page representing a location'
  
  has_one :location, :foreign_key => 'page_id', :autosave => true
  accepts_nested_attributes_for :location, :reject_if => :all_blank
end
