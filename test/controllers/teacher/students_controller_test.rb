require 'test_helper'

class Teacher::StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teacher_students_index_url
    assert_response :success
  end

  test "should get show" do
    get teacher_students_show_url
    assert_response :success
  end

  test "should get new" do
    get teacher_students_new_url
    assert_response :success
  end

  test "should get edit" do
    get teacher_students_edit_url
    assert_response :success
  end

  test "should get create" do
    get teacher_students_create_url
    assert_response :success
  end

  test "should get update" do
    get teacher_students_update_url
    assert_response :success
  end

  test "should get destroy" do
    get teacher_students_destroy_url
    assert_response :success
  end

end
