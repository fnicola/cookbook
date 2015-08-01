require 'spec_helper'
include Warden::Test::Helpers

describe "Favorite" do
  it "favorites a recipe if you are logged in" do
    given_I_am_logged_in
    given_that_some_recipes_are_available
    when_I_visit_a_recipe_page
    then_I_can_favorite_a_recipe
  end

  it "unfavorites a recipe if you are logged in" do
    given_I_am_logged_in
    given_that_some_recipes_are_available
    given_that_I_have_a_favorited_recipe
    when_I_visit_a_recipe_page
    then_I_can_unfavorite_the_recipe
  end

  it "does not favorites a recipe if you are not logged in" do
    given_that_some_recipes_are_available
    when_I_visit_a_recipe_page
    then_I_cannot_favorite_a_recipe
  end

  it "shows a message when filtering recipes by favorites with no favorites" do
    given_I_am_logged_in
    given_that_some_recipes_are_available
    when_I_visit_the_home_page
    then_I_can_filter_by_favorite
    then_I_see_the_message
  end

  it "filters recipes by favorites" do
    given_I_am_logged_in
    given_that_some_recipes_are_available
    given_that_I_have_a_favorited_recipe
    when_I_visit_the_home_page
    then_I_can_filter_by_favorite
    then_I_see_favorite_recipes
  end

  def given_I_am_logged_in
    @user = User.create(email: "what@ever.com", password: "whatever")
    login_as(@user, :scope => :user)
  end

  def given_that_some_recipes_are_available
    @recipe = Recipe.create(name: "Parmigiana", ingredients: "aubergine, tomato sauce, whatever", time: "60min")
    Recipe.create(name: "Risotto", ingredients: "rice,onion,butter,mushrooms,cheese", time: "40min")
  end

  def given_that_I_have_a_favorited_recipe
    @fav = Favorite.create(user_id: @user.id, recipe_id: @recipe.id )
  end

  def when_I_visit_a_recipe_page
    visit recipe_path @recipe.id
  end

  def then_I_can_favorite_a_recipe
    page.should have_content("Favorite")
    click_link "Favorite"
    page.should have_content("Unfavorite")
  end

  def then_I_can_unfavorite_the_recipe
    page.should have_content("Unfavorite")
    click_link "Unfavorite"
    page.should have_content("Favorite")
  end

  def then_I_cannot_favorite_a_recipe
    page.should have_no_content("Favorite")
  end

  def when_I_visit_the_home_page
    visit recipes_path
  end

  def then_I_can_filter_by_favorite
    expect(page).to have_selector('.recipe', count: 2)
    click_link "Favorites"
  end

  def then_I_see_favorite_recipes
    expect(page).to have_selector("tr", count: 2)
  end

  def then_I_see_the_message
    page.should have_content("Sorry you don\\'t currently have any favorited recipes")
  end
end
