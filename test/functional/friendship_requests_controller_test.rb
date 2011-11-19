require 'test_helper'

class FriendshipRequestsControllerTest < ActionController::TestCase
  setup do
    @friendship_request = friendship_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friendship_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friendship_request" do
    assert_difference('FriendshipRequest.count') do
      post :create, :friendship_request => @friendship_request.attributes
    end

    assert_redirected_to friendship_request_path(assigns(:friendship_request))
  end

  test "should show friendship_request" do
    get :show, :id => @friendship_request.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @friendship_request.to_param
    assert_response :success
  end

  test "should update friendship_request" do
    put :update, :id => @friendship_request.to_param, :friendship_request => @friendship_request.attributes
    assert_redirected_to friendship_request_path(assigns(:friendship_request))
  end

  test "should destroy friendship_request" do
    assert_difference('FriendshipRequest.count', -1) do
      delete :destroy, :id => @friendship_request.to_param
    end

    assert_redirected_to friendship_requests_path
  end
end
