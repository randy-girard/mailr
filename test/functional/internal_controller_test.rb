require 'test_helper'

class InternalControllerTest < ActionController::TestCase
  test "should get error" do
    get :error
    assert_response :success
  end

end
