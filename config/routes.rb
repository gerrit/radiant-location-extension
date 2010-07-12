ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :locations, :member => {:remove => :get}
  end
end
