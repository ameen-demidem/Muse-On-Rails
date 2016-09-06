require 'test_helper'

class Parent::HomeworksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parent_homeworks_index_url
    assert_response :success
  end

  test "should get show" do
    get parent_homeworks_show_url
    assert_response :success
  end

end
