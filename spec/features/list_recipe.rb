require 'spec_helper'
include Warden::Test::Helpers

describe "List Recipes" do
  it "shows a message when no recipes is available" do
    when_I_visit_recipes_page
    then_I_see_that_no_recipes_is_available
  end

  it "shows a list of recipes available " do
    given_that_some_recipes_are_available 5
    when_I_visit_recipes_page
    then_I_see_the_list_of_recipes
  end

  it "shows edit recipe for admin users" do
    given_that_I_am_admin
    given_that_some_recipes_are_available 5
    when_I_visit_recipes_page
    then_I_can_edit_a_recipe
  end

  it "shows destroy recipe for admin users" do
    given_that_I_am_admin
    given_that_some_recipes_are_available 5
    when_I_visit_recipes_page
    then_I_can_destroy_a_recipe
  end

  it "shows a link for creating a new recipe for admin users" do
    given_that_I_am_admin
    when_I_visit_recipes_page
    then_I_can_create_a_recipe
  end

  it "shows max ten recipes per page" do
    given_that_some_recipes_are_available 11
    when_I_visit_recipes_page
    then_I_see_just_10_recipes
  end

  it "shows next page when there are more than 10 recipes" do
    given_that_some_recipes_are_available 11
    when_I_visit_recipes_page
    then_I_can_go_on_the_next_page
  end

  def given_that_I_am_admin
    admin = User.create(email: "what@ever.com", password: "password", roles: "admin")
    login_as(admin, :scope => :user)
  end

  def given_that_I_am_user
    user = User.create(email: "what@ever.com", password: "paassword")
    login_as(user, :scope => :user)
  end

  def given_that_some_recipes_are_available n
    n.times do
      Recipe.create(name: "Parmigiana")
    end
  end

  def when_I_visit_recipes_page
    visit recipes_path
  end

  def then_I_see_that_no_recipes_is_available
    page.should have_content("Sorry we currently have no recipes for you")
  end

  def then_I_see_the_list_of_recipes
    #check that there are 5 recipes lines in the html generated plus the header line
    expect(page).to have_selector('.recipe', count: 5)
  end

  def then_I_can_edit_a_recipe
    first(".recipe").click_link("Edit")
    page.should have_content("Editing recipe")
  end

  def then_I_can_destroy_a_recipe
    first(".recipe").click_link("Destroy")
    expect(page).to have_selector('.recipe', count: 4)
  end

  def then_I_can_create_a_recipe
    click_link("New Recipe")
    page.should have_content("New recipe")
  end

  def then_I_see_just_10_recipes
    expect(page).to have_selector('.recipe', count: 10)
  end

  def then_I_can_go_on_the_next_page
    click_link("Next")
    expect(page).to have_selector('.recipe', count: 1)
  end
end
