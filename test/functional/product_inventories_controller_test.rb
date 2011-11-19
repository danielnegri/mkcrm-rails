require 'test_helper'

class ProductInventoriesControllerTest < ActionController::TestCase
  setup do
    @product_inventory = product_inventories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_inventories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_inventory" do
    assert_difference('ProductInventory.count') do
      post :create, :product_inventory => @product_inventory.attributes
    end

    assert_redirected_to product_inventory_path(assigns(:product_inventory))
  end

  test "should show product_inventory" do
    get :show, :id => @product_inventory.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product_inventory.to_param
    assert_response :success
  end

  test "should update product_inventory" do
    put :update, :id => @product_inventory.to_param, :product_inventory => @product_inventory.attributes
    assert_redirected_to product_inventory_path(assigns(:product_inventory))
  end

  test "should destroy product_inventory" do
    assert_difference('ProductInventory.count', -1) do
      delete :destroy, :id => @product_inventory.to_param
    end

    assert_redirected_to product_inventories_path
  end
end
