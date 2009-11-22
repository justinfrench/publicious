require 'rubygems'
require 'test/unit'
require "rack/test"
require "action_controller"
require File.join(File.dirname(__FILE__), "../app/metal/publicious_metal")

RAILS_ROOT = "/tmp"

module TestHelper
  include Rack::Test::Methods
  
  def app
    PubliciousMetal
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
      
      ActionController::Base.view_paths << File.join(@vendor_dir, plugin_name, 'app', 'views')
  
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public'))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public', 'stylesheets'))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public', 'images'))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public', 'javascripts'))
    end
  end
  
end
