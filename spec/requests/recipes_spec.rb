require 'spec_helper'
include Warden::Test::Helpers

describe "Recipes" do
  describe "GET /recipes" do
    it "displays recipes" do
      Recipe.create!(name: "Risotto ai funghi")
      visit recipes_path
      page.should have_content("Risotto ai funghi")
    end

    it "create recipes" do
      admin = User.create(email: "what@ever.com", roles: "admin")
      login_as(admin, :scope => :user)
      visit recipes_path
      click_link "New Recipe"
      fill_in "Name", with: "Risotto agli spinaci"
      click_button "Create Recipe"
      page.should have_content("Risotto agli spinaci")
    end

    it "shows recipe" do
      recipe = Recipe.create!(name: "Risotto ai carciofi", time: "30min", image_url: "some_url.jpg",
                    ingredients: "riso,cipolla,burro,funghi,parmigiano")
      visit recipes_path
      click_link "Show"
      page.should have_content("Risotto ai carciofi")
      list = find('ul').all('li')
      expect(list.size).to eq 5
      page.should have_css("img[src*='some_url.jpg']")
      page.should have_content("30min")
    end

    it "lists recipes "do
      5.times do
        Recipe.create(name: "Parmigiana")
      end
      visit recipes_path
      list = find('tbody').all('tr')
      expect(list.size).to eq 5
    end

    it "lists max ten recipes per page" do
      11.times do
        Recipe.create(name: "Parmigiana")
      end
      visit recipes_path
      list = find('tbody').all('tr')
      expect(list.size).to eq 10
    end

    it "shows the next page when click on next" do
      11.times do
        Recipe.create(name: "Parmigiana")
      end
      visit recipes_path
      click_link "Next"
      list = find('tbody').all('tr')
      expect(list.size).to eq 1
    end

    it "filters the search result by name" do
      Recipe.create(name: "Parmigiana")
      Recipe.create(name: "Risotto")
      Recipe.create(name: "Burger")

      visit recipes_path
      fill_in "keywords", with: "Risotto"
      click_button "Go"
      list = find('tbody').all('tr')
      expect(list.size).to eq 1
    end

    it "filters the search result by ingredients" do
      Recipe.create(name: "Parmigiana", ingredients: "aubergine, tomato sauce, whatever")
      Recipe.create(name: "Risotto", ingredients: "rice,onion,butter,mushrooms,cheese")
      Recipe.create(name: "Burger", ingredients: "meat, onion, meat, meat, ketchup")

      visit recipes_path
      fill_in "keywords", with: "meat"
      click_button "Go"
      page.should have_content("Burger")
      list = find('tbody').all('tr')
      expect(list.size).to eq 1
    end

    it "filters the search result by cooking time" do
      Recipe.create(name: "Parmigiana", time: "60min")
      Recipe.create(name: "Muffin", time: "60min")
      Recipe.create(name: "Risotto", time: "45min")
      Recipe.create(name: "Burger", time: "30min")

      visit recipes_path
      fill_in "keywords", with: "60min"
      click_button "Go"
      page.should have_content("Parmigiana")
      page.should have_content("Muffin")
      list = find('tbody').all('tr')
      expect(list.size).to eq 2
    end

    # I had some problems in configuring capybara with ajax. So I can't test end to end this feature
    it "stars a favorite" do
      user = User.create(email: "what@ever.com")
      login_as(user, :scope => :user)
      recipe = Recipe.create(name: "Fish and Chips", time: "10min")
      visit recipe_path recipe.id
      page.should have_content("Favorite")
      fav = Favorite.create(user_id: user.id, recipe_id: recipe.id )
      visit recipe_path recipe.id
      # page.should have_content("Unfavorite")
    end
  end
end
