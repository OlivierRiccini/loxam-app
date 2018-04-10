require 'test_helper'

class PromoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get promo_index_url
    assert_response :success
  end

  test "should get show" do
    get promo_show_url
    assert_response :success
  end

  test "should get new" do
    get promo_new_url
    assert_response :success
  end

  test "should get create" do
    get promo_create_url
    assert_response :success
  end

  test "should get edit" do
    get promo_edit_url
    assert_response :success
  end

  test "should get update" do
    get promo_update_url
    assert_response :success
  end

  test "should get destroy" do
    get promo_destroy_url
    assert_response :success
  end

end
