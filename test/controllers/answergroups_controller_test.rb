require 'test_helper'

class AnswergroupsControllerTest < ActionController::TestCase
  setup do
    @answergroup = answergroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:answergroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create answergroup" do
    assert_difference('Answergroup.count') do
      post :create, answergroup: { qcd_id: @answergroup.qcd_id }
    end

    assert_redirected_to answergroup_path(assigns(:answergroup))
  end

  test "should show answergroup" do
    get :show, id: @answergroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @answergroup
    assert_response :success
  end

  test "should update answergroup" do
    patch :update, id: @answergroup, answergroup: { qcd_id: @answergroup.qcd_id }
    assert_redirected_to answergroup_path(assigns(:answergroup))
  end

  test "should destroy answergroup" do
    assert_difference('Answergroup.count', -1) do
      delete :destroy, id: @answergroup
    end

    assert_redirected_to answergroups_path
  end
end
