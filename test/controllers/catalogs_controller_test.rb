require 'test_helper'

class CatalogsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get catalogs_create_url
    assert_response :success
  end

  test "should get update" do
    get catalogs_update_url
    assert_response :success
  end

end
