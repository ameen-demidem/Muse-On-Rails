require 'test_helper'

class Teacher::HomeworksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get teacher_homeworks_index_url
    assert_response :success
  end

  test "should get show" do
    get teacher_homeworks_show_url
    assert_response :success
  end

  test "should get new" do
    get teacher_homeworks_new_url
    assert_response :success
  end

  test "should get edit" do
    get teacher_homeworks_edit_url
    assert_response :success
  end

  test "should get create" do
    get teacher_homeworks_create_url
    assert_response :success
  end

  test "should get update" do
    get teacher_homeworks_update_url
    assert_response :success
  end

  test "should get destroy" do
    get teacher_homeworks_destroy_url
    assert_response :success
  end

end
