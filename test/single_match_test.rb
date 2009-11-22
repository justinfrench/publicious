require File.join(File.dirname(__FILE__), "test_helper")

class SingleMatchTest < Test::Unit::TestCase
  
  include TestHelper
  
  def setup
    super

    setup_plugin :my_plugin

    @path           = 'foo/bah.css'
    @filename       = "/tmp/vendor/my_plugin/public/stylesheets/#{@path}"
    @filecontents   = "hello from stylesheet"
    FileUtils.mkdir(File.dirname(@filename))
    File.open(@filename, 'w') do |file|
      file << @filecontents
    end
    
    get "/stylesheets/#{@path}"
  end
  
  def test_should_respond_with_success
    assert last_response.ok?
  end
  
  def test_view_paths_should_contain_three_items
    assert_equal 2, ActionController::Base.view_paths.size
  end
  
  def test_public_paths_should_contain_two_items
    assert_equal 1, app.public_paths.size # one less that view_paths
  end

  def test_public_paths_should_contain_the_plugins_public_dir
    assert_equal "/tmp/vendor/my_plugin/public", app.public_paths.first
  end
  
  def test_should_respond_with_first_file_contents
    assert_equal File.read(@filename), last_response.body
    assert_equal @filecontents, last_response.body
  end
  
end