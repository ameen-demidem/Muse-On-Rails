require 'test_helper'

class Student::HomeworksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_homeworks_index_url
    assert_response :success
  end

  test "should get show" do
    get student_homeworks_show_url
    assert_response :success
  end

  test "should get update" do
    get student_homeworks_update_url
    assert_response :success
  end

end
