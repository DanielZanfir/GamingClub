require 'test_helper'

class ListArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create!(name: "LOL")
    @category2 = Category.create!(name: "FIFA")

    @user1 = User.create!(username: "Daniel", email: "daniel@test.com", password: "parolaDeDani", admin: true)
    @user2 = User.create!(username: "Ioana", email: "ioana@test.com", password: "parolaDeIoana", admin: false)
    @user3 = User.create!(username: "Cristian", email: "cristian@test.com", password: "parolaDeCristian", admin: false)

    @article1=Article.create!(title: "titlu1", descriptions: "o descriere foarte buna pentru articolul 1", category_ids: @category.id, user: @user1)
    @article2=Article.create!(title: "titlu2", descriptions: "o descriere foarte buna pentru articolul 2", category_ids: @category.id, user: @user2)
    @article3=Article.create!(title: "titlu3", descriptions: "o descriere foarte buna 3", category_ids: @category2.id, user: @user2)
    @article4=Article.create!(title: "titlu4", descriptions: "o descriere foarte buna cel mai bun 4", category_ids: @category2.id, user: @user3)


  end

  test "should show categories listing" do
    get articles_path
    assert_template 'articles/index'
    assert_select "a[href=?]", article_path(@article1), title: @article1.title, description: @article1.descriptions, category_ids: @article1.category_ids
    assert_select "a[href=?]", article_path(@article2), title: @article2.title, description: @article2.descriptions, category_ids: @article2.category_ids
    assert_select "a[href=?]", article_path(@article3), title: @article3.title, description: @article3.descriptions, category_ids: @article3.category_ids
    assert_select "a[href=?]", article_path(@article4), title: @article4.title, description: @article4.descriptions, category_ids: @article4.category_ids
  end

end

