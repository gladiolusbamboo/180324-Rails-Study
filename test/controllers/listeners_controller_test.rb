require 'test_helper'

class ListenersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @listener = listeners(:one)
  end

  test "should get index" do
    get listeners_url
    assert_response :success
  end

  test "should get new" do
    get new_listener_url
    assert_response :success
  end

  test "should create listener" do
    assert_difference('Listener.count') do
      post listeners_url, params: { listener: { email: @listener.email, is_male: @listener.is_male, listenername: @listener.listenername, password_digest: @listener.password_digest, reviews_count: @listener.reviews_count, roles: @listener.roles } }
    end

    assert_redirected_to listener_url(Listener.last)
  end

  test "should show listener" do
    get listener_url(@listener)
    assert_response :success
  end

  test "should get edit" do
    get edit_listener_url(@listener)
    assert_response :success
  end

  test "should update listener" do
    patch listener_url(@listener), params: { listener: { email: @listener.email, is_male: @listener.is_male, listenername: @listener.listenername, password_digest: @listener.password_digest, reviews_count: @listener.reviews_count, roles: @listener.roles } }
    assert_redirected_to listener_url(@listener)
  end

  test "should destroy listener" do
    assert_difference('Listener.count', -1) do
      delete listener_url(@listener)
    end

    assert_redirected_to listeners_url
  end
end
