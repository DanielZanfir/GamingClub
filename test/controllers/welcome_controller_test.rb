require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = User.create!(username: "Testname", email: "test@test.com", password: "parolaDeTest", admin: false)
  end

  test 'should get root' do
    get root_path
    assert_response :success
  end

  test 'should get about' do
    get about_path
    assert_response :success
  end

end
