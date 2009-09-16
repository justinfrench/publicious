require File.dirname(__FILE__) + '/test_helper'

class PubliciousControllerTest < ActionController::TestCase
  tests PubliciousController
  
  test "when no assets are found" do
    assert_raises ActionView::MissingTemplate do
      get :show, :path => 'does/not/exist.js'
    end
  end

end
