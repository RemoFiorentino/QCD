require 'test_helper'

class AsignaturasControllerTest < ActionController::TestCase
  setup do
    @asignatura = asignaturas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asignaturas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asignatura" do
    assert_difference('Asignatura.count') do
      post :create, asignatura: { creditos: @asignatura.creditos, division: @asignatura.division, dpto: @asignatura.dpto, nombre: @asignatura.nombre, nrc: @asignatura.nrc, objetivo10: @asignatura.objetivo10, objetivo1: @asignatura.objetivo1, objetivo2: @asignatura.objetivo2, objetivo3: @asignatura.objetivo3, objetivo4: @asignatura.objetivo4, objetivo5: @asignatura.objetivo5, objetivo6: @asignatura.objetivo6, objetivo7: @asignatura.objetivo7, objetivo8: @asignatura.objetivo8, objetivo9: @asignatura.objetivo9, profe_id: @asignatura.profe_id, programa: @asignatura.programa, semestre: @asignatura.semestre }
    end

    assert_redirected_to asignatura_path(assigns(:asignatura))
  end

  test "should show asignatura" do
    get :show, id: @asignatura
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asignatura
    assert_response :success
  end

  test "should update asignatura" do
    patch :update, id: @asignatura, asignatura: { creditos: @asignatura.creditos, division: @asignatura.division, dpto: @asignatura.dpto, nombre: @asignatura.nombre, nrc: @asignatura.nrc, objetivo10: @asignatura.objetivo10, objetivo1: @asignatura.objetivo1, objetivo2: @asignatura.objetivo2, objetivo3: @asignatura.objetivo3, objetivo4: @asignatura.objetivo4, objetivo5: @asignatura.objetivo5, objetivo6: @asignatura.objetivo6, objetivo7: @asignatura.objetivo7, objetivo8: @asignatura.objetivo8, objetivo9: @asignatura.objetivo9, profe_id: @asignatura.profe_id, programa: @asignatura.programa, semestre: @asignatura.semestre }
    assert_redirected_to asignatura_path(assigns(:asignatura))
  end

  test "should destroy asignatura" do
    assert_difference('Asignatura.count', -1) do
      delete :destroy, id: @asignatura
    end

    assert_redirected_to asignaturas_path
  end
end
