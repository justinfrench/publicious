Mime::Type.register "image/jpeg", :jpg
Mime::Type.register "image/gif", :gif
Mime::Type.register "image/png", :png

module Publicious
  class Engine < Rails::Engine
  end
end

require "publicious/responder"


