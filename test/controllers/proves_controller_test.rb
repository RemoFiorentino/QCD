require 'test_helper'

class ProvesControllerTest < ActionController::TestCase
  setup do
    @profe = proves(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proves)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profe" do
    assert_difference('Profe.count') do
      post :create, profe: { numero: @profe.numero, ubicacion: @profe.ubicacion, user_id: @profe.user_id }
    end

    assert_redirected_to profe_path(assigns(:profe))
  end

  test "should show profe" do
    get :show, id: @profe
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profe
    assert_response :success
  end

  test "should update profe" do
    patch :update, id: @profe, profe: { numero: @profe.numero, ubicacion: @profe.ubicacion, user_id: @profe.user_id }
    assert_redirected_to profe_path(assigns(:profe))
  end

  test "should destroy profe" do
    assert_difference('Profe.count', -1) do
      delete :destroy, id: @profe
    end

    assert_redirected_to proves_path
  end
end
