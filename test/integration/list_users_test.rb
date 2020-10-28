require 'test_helper'

class ListUsersTest < ActionDispatch::IntegrationTest

  def setup
    @user1 = User.create!(username: "Daniel", email: "daniel@test.com", password: "parolaDeDani", admin: true)
    @user2 = User.create!(username: "Ioana", email: "ioana@test.com", password: "parolaDeIoana", admin: false)
    @user3 = User.create!(username: "Cristian", email: "cristian@test.com", password: "parolaDeCristian", admin: false)
  end

  test "should show categories listing" do
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@user1), username: @user1.username
    assert_select "a[href=?]", user_path(@user2), username: @user2.username
    assert_select "a[href=?]", user_path(@user3), username: @user3.username
  end

end
