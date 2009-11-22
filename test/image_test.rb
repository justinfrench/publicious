require File.join(File.dirname(__FILE__), "test_helper")

class ImageTest < Test::Unit::TestCase
  
  include TestHelper
  
  def setup
    super
    
    setup_plugin :my_plugin

    @gif_path       = 'foo/bah.gif'
    @jpg_path       = 'foo/bah.jpg'
    @png_path       = 'foo/bah.png'
    
    @gif_filename   = "/tmp/vendor/my_plugin/public/images/#{@gif_path}"
    @jpg_filename   = "/tmp/vendor/my_plugin/public/images/#{@jpg_path}"
    @png_filename   = "/tmp/vendor/my_plugin/public/images/#{@png_path}"

    @gif_filecontents   = "hello from GIF"
    @jpg_filecontents   = "hello from JPG"
    @png_filecontents   = "hello from PNG"
    
    FileUtils.mkdir(File.dirname(@jpg_filename))
    
    File.open(@jpg_filename, 'w') do |file|
      file << @jpg_filecontents
    end
    
    File.open(@gif_filename, 'w') do |file|
      file << @gif_filecontents
    end
    
    File.open(@png_filename, 'w') do |file|
      file << @png_filecontents
    end
  end
  
  def test_responds_ok
    get "/images/#{@gif_path}"
    assert last_response.ok?
    
    get "/images/#{@jpg_path}"
    assert last_response.ok?
    
    get "/images/#{@png_path}"
    assert last_response.ok?
    
  end
  
  def test_responds_with_css_content_type
    get "/images/#{@gif_path}"
    assert_equal "image/gif", last_response.content_type
    
    get "/images/#{@png_path}"
    assert_equal "image/png", last_response.content_type
    
    get "/images/#{@jpg_path}"
    assert_equal "image/jpeg", last_response.content_type
  end
  
end