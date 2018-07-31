require 'test_helper'

class ExpendablesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get expendables_create_url
    assert_response :success
  end

  test "should get update" do
    get expendables_update_url
    assert_response :success
  end

  test "should get destroy" do
    get expendables_destroy_url
    assert_response :success
  end

end
