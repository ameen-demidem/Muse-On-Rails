require 'test_helper'

class Parent::ChildrenControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parent_children_index_url
    assert_response :success
  end

  test "should get show" do
    get parent_children_show_url
    assert_response :success
  end

end
