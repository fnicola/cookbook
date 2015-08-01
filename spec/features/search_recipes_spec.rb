require 'spec_helper'


describe "Search recipes" do
  it "search recipes by name" do
    given_that_there_are_some_recipes
    when_I_visit_the_home_page
    then_I_search_a_keyword "Risotto"
    then_I_see_all_recipe_with_the_keyword_in_the_name
  end

  it "search recipes by ingredients" do
    given_that_there_are_some_recipes
    when_I_visit_the_home_page
    then_I_search_a_keyword "meat"
    then_I_see_all_recipe_with_the_keyword_in_the_ingredients
  end

  it "search recipes by cooking time" do
    given_that_there_are_some_recipes
    when_I_visit_the_home_page
    then_I_search_a_keyword "60min"
    then_I_see_all_recipe_with_the_keyword_in_the_cooking_time
  end



  def given_that_there_are_some_recipes
    Recipe.create(name: "Parmigiana", ingredients: "aubergine, tomato sauce, whatever", time: "60min")
    Recipe.create(name: "Risotto", ingredients: "rice,onion,butter,mushrooms,cheese", time: "40min")
    Recipe.create(name: "Burger", ingredients: "meat, onion, meat, meat, ketchup", time: "60min")
  end

  def when_I_visit_the_home_page
    visit recipes_path
  end

  def then_I_search_a_keyword keyword
    fill_in "keywords", with: keyword
    click_button "Go"
  end

  def then_I_see_all_recipe_with_the_keyword_in_the_name
    page.should have_content("Risotto")
    expect(page).to have_selector('.recipe', count: 1)
  end

  def then_I_see_all_recipe_with_the_keyword_in_the_ingredients
    expect(page).to have_selector('.recipe', count: 1)
    page.should have_content("Burger")
  end

  def then_I_see_all_recipe_with_the_keyword_in_the_cooking_time
    expect(page).to have_selector('.recipe', count: 2)
    page.should have_content("Parmigiana")
    page.should have_content("Burger")
  end
end
