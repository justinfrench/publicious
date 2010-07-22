class PubliciousRailtie < Rails::Railtie
  config.app.middelware.insert_before(Rack::Lock, Publicious) if config.respond_to?(:app)
end