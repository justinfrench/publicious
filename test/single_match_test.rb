require File.dirname(__FILE__) + '/test_helper'

class SingleMatchTest < PubliciousBaseTest

  def setup
    super
    setup_plugin :my_plugin

    @path           = ['foo', 'bah.css']
    @filename       = "/tmp/vendor/my_plugin/public/stylesheets/#{@path.join('/')}"
    @filecontents   = "hello from stylesheet"
    FileUtils.mkdir(File.dirname(@filename))
    File.open(@filename, 'w') do |file|
      file << "hello from stylesheet"
    end
    
    get :show, :path => @path
  end
  
  test "view_paths should contain two items" do
    assert_equal 2, @controller.view_paths.size
  end
  
  test "public_paths should contain one item (one less than view paths)" do
    assert_equal 1, @controller.send(:public_paths).size
  end
  
  test "public_paths should contain the plugin's public dir" do
    assert_equal "/tmp/vendor/my_plugin/public", @controller.send(:public_paths).first
  end
  
  test "should respond with the file contents" do
    assert_equal File.read(@filename), @controller.response.body
    assert_equal @filecontents, @controller.response.body
  end
  
end
