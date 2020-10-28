require 'test_helper'
class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create!(name: "FIFA")

    @user = User.create!(username: "Testname", email: "test@test.com", password: "parolaDeTest", admin: false)

    @adminuser=User.create!(username: "lucas", email: "lucas@example.com", password: "safepassword", admin: true )

    @article=Article.create!(title: "titlu", descriptions: "o descriere foarte buna", category_ids: @category.id, user: @user)

  end

  test "should get index" do
    get articles_path
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user, "parolaDeTest")
    get new_article_path
    assert_response :success
  end

  test "should show article" do
    sign_in_as(@user, "parolaDeTest")
    get article_path(@article)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user, "parolaDeTest")
    get edit_article_path(@article)
    assert_response :success
  end

  test "should create article" do
    sign_in_as(@user, "parolaDeTest")
    @category1 = Category.create!(name: "DOTA")
    @article1=Article.create!(title: "cyperpunk", descriptions: "bun joc, merita cumparat si jucat bla bla bla ", category_ids: @category1.id, user: @user)

    assert_difference('Article.count',1) do
      post articles_path, params: { article: { title: @article1.title, descriptions: @article1.descriptions, category_ids: @article1.category_ids, user: @user} }
    end

    assert_redirected_to article_path(Article.last)
  end


  test "should update article" do
    sign_in_as(@user, "parolaDeTest")
    @category2 = Category.create!(name: "SMITE")
    @article2=Article.create!(title: "FP MOBA?", descriptions: "bla bla exista asa ceva bla bla ", category_ids: @category2.id, user: @user)

    patch article_path(@article2), params: { article: {title: @article2.title, descriptions: @article2.descriptions, category_ids: @article2.category_ids, user: @user} }
    assert_redirected_to article_path(@article2)
  end

  test "admin should destroy article" do
    sign_in_as(@adminuser,"safepassword")
    assert_difference('Article.count', -1) do
      delete article_path(@article)
    end
    assert_redirected_to articles_path
  end

  test "same user should destroy article" do
    sign_in_as(@user,"parolaDeTest")
    assert_difference('Article.count', -1) do
      delete article_path(@article)
    end
    assert_redirected_to articles_path
  end


end
