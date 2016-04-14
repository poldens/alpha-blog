require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest
  test "get sign up form and create new user" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do 
      post_via_redirect users_path, user: {username: "bill", email: "billgates@example.com", password: "12345"}
    end
    assert_template 'users/show'
    assert_match "bill", response.body
  end
end