require File.dirname(__FILE__) + '/test_helper'

class SingleMatchTest < ActionController::TestCase
  tests PubliciousController
  
  def setup
    super
    PubliciousController.view_paths = ['/tmp/app/views','/tmp/vendor/my_plugin/app/views']
    
    @path           = ['foo', 'bah.css']
    
    @vendordir      = "/tmp/vendor"
    @plugindir      = "/tmp/vendor/my_plugin"
    @publicdir      = "/tmp/vendor/my_plugin/public"
    @stylesheetsdir = "/tmp/vendor/my_plugin/public/stylesheets"
    @filename       = "/tmp/vendor/my_plugin/public/stylesheets/#{@path.join('/')}"
    @filecontents   = "hello from stylesheet"
    
    FileUtils.mkdir(@vendordir)
    FileUtils.mkdir(@plugindir)
    FileUtils.mkdir(@publicdir)
    FileUtils.mkdir(@stylesheetsdir)
    
    FileUtils.mkdir(File.dirname(@filename))
    File.open(@filename, 'w') do |file|
      file << "hello from stylesheet"
    end
    
    get :show, :path => @path
  end
  
  def teardown
    super
    begin
      FileUtils.rm_r(@vendordir)
    rescue StandardError => e
      puts "Error while removing #{@plugindir}"
    end
  end
  
  test "view_paths should contain two items" do
    assert_equal 2, @controller.view_paths.size
  end
  
  test "public_paths should contain one item (one less than view paths)" do
    assert_equal 1, @controller.send(:public_paths).size
  end
  
  test "public_paths should contain the plugin's public dir" do
    assert_equal @publicdir, @controller.send(:public_paths).first
  end
  
  test "should respond with the file contents" do
    assert_equal File.read(@filename), @controller.response.body
    assert_equal @filecontents, @controller.response.body
  end
  
end
