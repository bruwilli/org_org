require 'test_helper'

class OrgTypesControllerTest < ActionController::TestCase
  setup do
    @org_type = org_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:org_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create org_type" do
    assert_difference('OrgType.count') do
      post :create, org_type: { description: @org_type.description, name: @org_type.name }
    end

    assert_redirected_to org_type_path(assigns(:org_type))
  end

  test "should show org_type" do
    get :show, id: @org_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @org_type
    assert_response :success
  end

  test "should update org_type" do
    put :update, id: @org_type, org_type: { description: @org_type.description, name: @org_type.name }
    assert_redirected_to org_type_path(assigns(:org_type))
  end

  test "should destroy org_type" do
    assert_difference('OrgType.count', -1) do
      delete :destroy, id: @org_type
    end

    assert_redirected_to org_types_path
  end
end
