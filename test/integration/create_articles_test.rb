require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup 
      @user = User.create(username: "steve", email: "balmer@example.com", password: "12345", admin: false)
  end
  
  test "sign up user and create new article" do
    sign_in_as(@user, "12345")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do 
      post_via_redirect articles_path, article: {title: "super article", description: "description for super article", user: @user}
    end
    assert_template 'articles/show'
    assert_match "super article", response.body
  end
end