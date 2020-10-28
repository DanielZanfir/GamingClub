require 'test_helper'

class Usertest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: "Testname", email: "test@test.com", password: "parolaDeTest", admin: false)
  end

  test 'valid username without special chars' do
    assert @user.valid?
  end

  test 'valid username with special chars' do
    @user.username = "test/*ada"
    assert @user.valid?
  end

  test 'unique username ' do
    @user.save
    user2 = User.create(username: "Testname", email: "test@test.com", password: "parolaDeTest", admin: false)
    assert_not user2.valid?
  end

  test 'empty username' do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 29
    assert_not @user.valid?
  end

  test "name should not be too short" do
    @user.username = "aa"
    assert_not @user.valid?
  end

  test 'empty email' do
    @user.email = " "
    assert_not @user.valid?
  end

  test 'email not ending with @something.com' do
    @user.email = "test"
    assert_not @user.valid?
  end

  test 'email not having @ char' do
    @user.email = "test.com"
    assert_not @user.valid?
  end

  test 'email not having .com termination' do
    @user.email = "test@firma"
    assert_not @user.valid?
  end

  test 'empty password' do
    @user.password_digest = " "
    assert_not @user.valid?
  end

end
