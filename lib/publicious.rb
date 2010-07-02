Mime::Type.register "image/jpeg", :jpg
Mime::Type.register "image/gif", :gif
Mime::Type.register "image/png", :png

module Publicious
  class Engine < Rails::Engine
    engine_name :publicious
  end
end

require "publicious/responder"


