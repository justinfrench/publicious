require File.join(File.dirname(__FILE__), "test_helper")

class CssTest < Test::Unit::TestCase
  
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
  
  def test_responds_ok
    assert last_response.ok?
  end
  
  def test_responds_with_css_content_type
    assert_equal "text/css", last_response.content_type
  end
  
end