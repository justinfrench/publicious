ActionController::Routing::Routes.draw do |map|

  map.stylesheet '/stylesheets/*path', :controller => "plugin_assets", :action => "show"
  map.image      '/images/*path',      :controller => "plugin_assets", :action => "show"
  map.javascript '/javascripts/*path', :controller => "plugin_assets", :action => "show"

end