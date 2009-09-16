require File.dirname(__FILE__) + '/test_helper'

class PubliciousBaseTest < ActionController::TestCase
  tests PubliciousController
  
  def setup_plugin(*plugin_names)
    plugin_names.each do |plugin_name|
      plugin_name = plugin_name.to_s
      
      PubliciousController.view_paths << File.join(@vendor_dir, plugin_name, 'app', 'views')

      FileUtils.mkdir(File.join(@vendor_dir, plugin_name))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public'))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public', 'stylesheets'))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public', 'images'))
      FileUtils.mkdir(File.join(@vendor_dir, plugin_name, 'public', 'javascripts'))
    end
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
    PubliciousController.view_paths = ['/tmp/app/views']
  end
  
  def setup
    super
    setup_vendor_dir
    setup_standard_view_paths
  end

  def teardown
    super
    teardown_vendor_dir
  end
  
end
