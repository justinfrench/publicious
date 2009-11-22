require File.join(File.dirname(__FILE__), "test_helper")

class NoMatchTest < Test::Unit::TestCase
  
  include TestHelper
  
  def test_responds_with_not_found
    get "/stylesheets/not_here.css"
    assert last_response.not_found?
  end

end