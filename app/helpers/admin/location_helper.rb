module Admin::LocationHelper
  def link_to_location_edit_form(location)
    href = location.page ? edit_admin_page_path(location.page) : edit_admin_location_path(location)
    link_to location.name, href
  end
  
  def link_to_location_removal_page(location)
    href = location.page ? remove_admin_page_path(location.page) : remove_admin_location_path(location)
    link_to 'Remove', href
  end
end
