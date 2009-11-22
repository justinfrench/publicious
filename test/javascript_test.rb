require File.join(File.dirname(__FILE__), "test_helper")

class JavascriptTest < Test::Unit::TestCase
  
  include TestHelper
  
  def setup
    super
    
    setup_plugin :my_plugin

    @path           = 'foo/bah.js'
    @filename       = "/tmp/vendor/my_plugin/public/javascripts/#{@path}"
    @filecontents   = "hello from javascript"
    FileUtils.mkdir(File.dirname(@filename))
    File.open(@filename, 'w') do |file|
      file << @filecontents
    end
    
    get "/javascripts/#{@path}"
  end
  
  def test_responds_ok
    assert last_response.ok?
  end
  
  def test_responds_with_css_content_type
    assert_equal "text/javascript", last_response.content_type
  end
  
end