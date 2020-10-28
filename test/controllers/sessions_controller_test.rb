require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @session = sessions(:one)
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false )
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should create session" do
    post login_path, params: { session: { email: @user.email, password: @user.password } }
    assert_redirected_to user_path(@user)
  end

  test "should retry login" do
    post login_path, params: { session: { email: "laptop@dell.com", password: "dellEsmecher" } }
    assert_template :new
  end

  test "should destroy session" do
      delete logout_path
    assert_redirected_to root_path
  end
end
