require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false )
    @adminuser=User.create(username: "lucas", email: "lucas@example.com", password: "safepassword", admin: true )
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get new" do
    get user_path(@user)
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count',1) do
      post users_path, params: { user: {username: "tim", email: "tim@example.com", password: "parola", admin: false   } }
    end

    assert_redirected_to user_path(User.last)
  end

  test "should show user" do
    get user_path(@user)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user" do
    sign_in_as(@user, "password")
    patch user_path(@user), params: { user: {username: "tim", email: "tim@example.com", password: "parola"  } }
    assert_redirected_to articles_path
  end

  test "should destroy user" do
    sign_in_as(@adminuser,"safepassword")
    assert_difference('User.count', -1) do
      delete user_path(@user)
    end

    assert_redirected_to users_path
  end
end
