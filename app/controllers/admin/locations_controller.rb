class Admin::LocationsController < Admin::ResourceController
  helper 'admin/location'
  model_class 'Location'
  before_filter :redirect_to_page_admin
private
  def redirect_to_page_admin
    if model.page
      case params[:action]
      when 'edit'
        redirect_to edit_admin_page_path(model.page)
      when 'remove'
        redirect_to remove_admin_page_path(model.page)
      end
    end
  end
end
