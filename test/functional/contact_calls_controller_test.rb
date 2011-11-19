require 'test_helper'

class ContactCallsControllerTest < ActionController::TestCase
  setup do
    @contact_call = contact_calls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_calls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_call" do
    assert_difference('ContactCall.count') do
      post :create, :contact_call => @contact_call.attributes
    end

    assert_redirected_to contact_call_path(assigns(:contact_call))
  end

  test "should show contact_call" do
    get :show, :id => @contact_call.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @contact_call.to_param
    assert_response :success
  end

  test "should update contact_call" do
    put :update, :id => @contact_call.to_param, :contact_call => @contact_call.attributes
    assert_redirected_to contact_call_path(assigns(:contact_call))
  end

  test "should destroy contact_call" do
    assert_difference('ContactCall.count', -1) do
      delete :destroy, :id => @contact_call.to_param
    end

    assert_redirected_to contact_calls_path
  end
end
