require File.join(File.dirname(__FILE__), "test_helper")

class NoMatchTest < Test::Unit::TestCase
  
  include TestHelper
  
  def test_redirect_logged_in_users_to_dashboard
    get "/stylesheets/not_here.css"
    assert last_response.not_found?
  end

end