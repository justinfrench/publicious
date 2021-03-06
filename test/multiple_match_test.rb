require File.dirname(__FILE__) + '/test_helper'

class MultipleMatchesTest < Test::Unit::TestCase
  
  include TestHelper
  
  def setup
    super
    
    setup_plugin :no_file_here
    setup_plugin :my_plugin
    setup_plugin :your_plugin

    @path           = 'foo/bah.css'
    
    @filename_1     = "/tmp/vendor/my_plugin/public/stylesheets/#{@path}"
    @filecontents_1 = "hello from my stylesheet"
    FileUtils.mkdir(File.dirname(@filename_1))
    File.open(@filename_1, 'w') do |file|
      file << @filecontents_1
    end
    
    @filename_2     = "/tmp/vendor/your_plugin/public/stylesheets/#{@path}"
    @filecontents_2 = "hello from your stylesheet"
    FileUtils.mkdir(File.dirname(@filename_2))
    File.open(@filename_2, 'w') do |file|
      file << @filecontents_2
    end
    
    get "/stylesheets/#{@path}"
  end
  
  def test_should_respond_with_success
    assert last_response.ok?
  end
    
  def test_should_respond_with_first_file_contents
    assert_equal File.read(@filename_1), last_response.body
    assert_equal @filecontents_1, last_response.body
  end
  
end