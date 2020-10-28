require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    sign_in_as(@admin_user, "password")
  end

  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "FireWatch"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "FireWatch", response.body
  end

  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " "} }
    end
    assert_match "errors", response.body
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end