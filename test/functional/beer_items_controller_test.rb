require 'test_helper'

class BeerItemsControllerTest < ActionController::TestCase
  setup do
    @beer_item = beer_items(:oberon_at_midway)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:beer_items)
  end
  
  test "should get new" do
    login_as(:eugene)
    get :new
    assert_response :success
  end
  
  test "should create beer_item" do
    login_as(:eugene)
    assert_difference('BeerItem.count') do
      post :create, :beer_item => { :beer_id => 1,
                                    :bar_id => 2,
                                    :price => 3 }
    end

    assert_response :redirect
    # assert_redirected_to beer_item_path(assigns(:beer_item))
  end
  
  test "should get edit" do
    login_as(:eugene)
    get :edit, :id => @beer_item.to_param
    assert_response :success
  end

  test "should update beer_item" do
    login_as(:eugene)
    put :update, :id => @beer_item.to_param, :beer_item => { :price => 2 }
    assert_redirected_to beer_item_path(assigns(:beer_item))
  end
  
  test "should show beer_item" do
    get :show, :id => @beer_item.to_param

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:beer_item)
    assert assigns(:beer_item).valid?
  end
  
  test "should destroy beer_item" do
    login_as(:eugene)
    assert_nothing_raised { BeerItem.find(@beer_item.to_param) }

    assert_difference('BeerItem.count', -1) do
      delete :destroy, :id => @beer_item.to_param
    end
    assert_response :redirect
    assert_redirected_to beer_items_path

    assert_raise(ActiveRecord::RecordNotFound) { BeerItem.find(@beer_item.to_param) }
  end
end
