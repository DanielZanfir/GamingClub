require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "FIFA")
    @category.save

    @user = User.create(username: "Testname", email: "test@test.com", password: "parolaDeTest", admin: false)
    @user.save

    @article=Article.new(title: "titlu", descriptions: "o descriere foarte buna", category_ids: @category.id)
    @article.user=@user
  end

  test 'article should be valid' do
    assert @article.valid?
  end

  test 'creating an article with a category but without an user' do
    @category1 = Category.new(name: "LOL")
    @article1=Article.new(title: "titlu", descriptions: "o descriere foarte buna", category_ids: @category1.id)
    assert_not @article1.valid?
  end

  test 'creating an article with an user but without a category' do
    @user = User.create(username: "Testname", email: "test@test.com", password: "parolaDeTest", admin: false)
    @article1=Article.new(title: "titlu", descriptions: "o descriere foarte buna", category_ids: nil)
    @article1.user=@user
    assert_not @article1.valid?
  end

  test 'creating an article without an user and category' do
    @article2=Article.new(title: "titlu", descriptions: "o descriere foarte buna", category_ids: nil)
    assert_not @article2.valid?
  end

  test 'article without a title' do
    @article.title=" "
    assert_not @article.valid?
  end

  test 'title length is short' do
    @article.title="aa"
    assert_not @article.valid?
  end

  test 'title length is long' do
    @article.title="a"*51
    assert_not @article.valid?
  end

  test 'article without a description' do
    @article.descriptions=" "
    assert_not @article.valid?
  end

  test 'description length is short' do
    @article.descriptions="a"*9
    assert_not @article.valid?
  end

  test 'description length is long' do
    @article.descriptions="a"*301
    assert_not @article.valid?
  end

end
