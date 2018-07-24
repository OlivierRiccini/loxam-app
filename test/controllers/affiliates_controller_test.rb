require 'test_helper'

class AffiliatesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get affiliates_show_url
    assert_response :success
  end

end
