require 'spec_helper'

feature 'Show recipe'

describe "Recipe" do
  it "shows recipe" do
    given_a_recipe_exists
    when_I_visit_the_recipe_page
    then_I_can_see_igrendients
    then_I_can_see_the_cooking_time
    then_I_can_see_recipe_picture
  end

  it "shows a message if the recipe doesn't exist" do
    when_I_visit_a_recipe_page_that_does_not_exists
    then_I_can_see_that_it_does_not_exists
  end
end


def given_a_recipe_exists
  @recipe = Recipe.create!(name: "Risotto ai carciofi", time: "30min", image_url: "some_url.jpg",
                          ingredients: "riso,cipolla,burro,funghi,parmigiano")
end

def when_I_visit_the_recipe_page
  visit recipe_path @recipe.id
end

def when_I_visit_a_recipe_page_that_does_not_exists
  visit recipe_path 10
end

def then_I_can_see_igrendients
  # I check that the number of the ingredients is right
  expect(page).to have_selector('li', count: 5)
  page.should have_content ("riso")
  page.should have_content ("cipolla")
  page.should have_content ("funghi")
  page.should have_content ("parmigiano")
end

def then_I_can_see_the_cooking_time
  page.should have_content("30min")
end

def then_I_can_see_recipe_picture
  page.should have_css("img[src*='some_url.jpg']")
end

def then_I_can_see_that_it_does_not_exists
  page.should have_content ("Sorry this recipe doesn't exist or may have been removed!")
end
