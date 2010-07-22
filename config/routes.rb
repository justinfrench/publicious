Rails::Application.routes.draw do |map|
  match "/stylesheets/*path" => Publicious::Responder
  match "/images/*path"      => Publicious::Responder
  match "/javascripts/*path" => Publicious::Responder
end
