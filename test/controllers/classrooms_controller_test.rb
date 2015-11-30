require 'test_helper'

class ClassroomsControllerTest < ActionController::TestCase
  setup do
    @classroom = classrooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classrooms)
  end

  test "should create classroom" do
    assert_difference('Classroom.count') do
      post :create, classroom: { name: @classroom.name, school_id: @classroom.school_id }
    end

    assert_response 201
  end

  test "should show classroom" do
    get :show, id: @classroom
    assert_response :success
  end

  test "should update classroom" do
    put :update, id: @classroom, classroom: { name: @classroom.name, school_id: @classroom.school_id }
    assert_response 204
  end

  test "should destroy classroom" do
    assert_difference('Classroom.count', -1) do
      delete :destroy, id: @classroom
    end

    assert_response 204
  end
end
