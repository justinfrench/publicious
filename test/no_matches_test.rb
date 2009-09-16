require File.dirname(__FILE__) + '/test_helper'

class NoMatchesTest < ActionController::TestCase
  tests PubliciousController
  
  test "when no assets are found" do
    assert_raises ActionView::MissingTemplate do
      get :show, :path => ['does', 'not', 'exist.css']
    end
  end

end
