class MyRailtie < Rails::Railtie
  initializer "publicious.configure_middleware" do |app|
    app.middleware.insert_before(Rack::Lock, Publicious)
  end
end