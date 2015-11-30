require 'test_helper'

class TeachersControllerTest < ActionController::TestCase
  setup do
    @teacher = teachers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teachers)
  end

  test "should create teacher" do
    assert_difference('Teacher.count') do
      post :create, teacher: { admin: @teacher.admin, auth_token: @teacher.auth_token, email: @teacher.email, password: @teacher.password, school_id: @teacher.school_id }
    end

    assert_response 201
  end

  test "should show teacher" do
    get :show, id: @teacher
    assert_response :success
  end

  test "should update teacher" do
    put :update, id: @teacher, teacher: { admin: @teacher.admin, auth_token: @teacher.auth_token, email: @teacher.email, password: @teacher.password, school_id: @teacher.school_id }
    assert_response 204
  end

  test "should destroy teacher" do
    assert_difference('Teacher.count', -1) do
      delete :destroy, id: @teacher
    end

    assert_response 204
  end
end
