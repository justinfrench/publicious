require 'rubygems'
require 'test/unit'
require "rack/test"
require "rails"
require "action_controller"
require "publicious"

RAILS_ROOT = "/tmp"

NOT_FOUND_APP = lambda{|e| Rack::Response.new("NOT FOUND", 404).finish}

module TestHelper
  include Rack::Test::Methods

  def app
    Publicious.new(NOT_FOUND_APP)
  end

  def setup_vendor_dir
    unless @vendor_dir
      @vendor_dir = "/tmp/vendor"
      FileUtils.mkdir(@vendor_dir)
    end
  end

  def teardown_vendor_dir
    if @vendor_dir
      begin
        FileUtils.rm_r(@vendor_dir)
      rescue StandardError => e
        puts "Error while removing #{@vendor_dir}"
      end
    end
  end

  def setup_standard_view_paths
    ActionController::Base.view_paths = ['/tmp/app/views']
  end

  def setup
    setup_vendor_dir
    setup_standard_view_paths
  end

  def teardown
    teardown_vendor_dir
    setup_standard_view_paths
  end

  def setup_plugin(*plugin_names)
    plugin_names.each do |plugin_name|
      plugin_name = plugin_name.to_s

      class_eval "
      module ::#{plugin_name.classify}
        class Engine < ::Rails::Engine
          #engine_name :#{plugin_name}
          paths.public = '#{@vendor_dir}/#{plugin_name}/public'
        end
      end"

      #ActionController::Base.view_paths << File.join(@vendor_dir, plugin_name, 'app', 'views')

      FileUtils.mkdir(File.join(@vendor_dir, plugin_name))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public'))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public', 'stylesheets'))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public', 'images'))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public', 'javascripts'))
    end
  end

end
