ActionController::Routing::Routes.draw do |map|

  map.stylesheet '/stylesheets/*path', :controller => "publicious", :action => "show"
  map.image      '/images/*path',      :controller => "publicious", :action => "show"
  map.javascript '/javascripts/*path', :controller => "publicious", :action => "show"

end