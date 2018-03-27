require 'test_helper'

class CdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cd = cds(:one)
  end

  test "should get index" do
    get cds_url
    assert_response :success
  end

  test "should get new" do
    get new_cd_url
    assert_response :success
  end

  test "should create cd" do
    assert_difference('Cd.count') do
      post cds_url, params: { cd: { artist: @cd.artist, is_major: @cd.is_major, jan: @cd.jan, price: @cd.price, released: @cd.released, title: @cd.title } }
    end

    assert_redirected_to cd_url(Cd.last)
  end

  test "should show cd" do
    get cd_url(@cd)
    assert_response :success
  end

  test "should get edit" do
    get edit_cd_url(@cd)
    assert_response :success
  end

  test "should update cd" do
    patch cd_url(@cd), params: { cd: { artist: @cd.artist, is_major: @cd.is_major, jan: @cd.jan, price: @cd.price, released: @cd.released, title: @cd.title } }
    assert_redirected_to cd_url(@cd)
  end

  test "should destroy cd" do
    assert_difference('Cd.count', -1) do
      delete cd_url(@cd)
    end

    assert_redirected_to cds_url
  end
end
