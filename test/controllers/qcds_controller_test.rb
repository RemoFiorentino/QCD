require 'test_helper'

class QcdsControllerTest < ActionController::TestCase
  setup do
    @qcd = qcds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qcds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qcd" do
    assert_difference('Qcd.count') do
      post :create, qcd: { asignatura_id: @qcd.asignatura_id, fecha: @qcd.fecha, grupo: @qcd.grupo, salon: @qcd.salon }
    end

    assert_redirected_to qcd_path(assigns(:qcd))
  end

  test "should show qcd" do
    get :show, id: @qcd
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qcd
    assert_response :success
  end

  test "should update qcd" do
    patch :update, id: @qcd, qcd: { asignatura_id: @qcd.asignatura_id, fecha: @qcd.fecha, grupo: @qcd.grupo, salon: @qcd.salon }
    assert_redirected_to qcd_path(assigns(:qcd))
  end

  test "should destroy qcd" do
    assert_difference('Qcd.count', -1) do
      delete :destroy, id: @qcd
    end

    assert_redirected_to qcds_path
  end
end
