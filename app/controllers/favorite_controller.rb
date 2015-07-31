class FavoriteController < ApplicationController
  def toggle
    return unless user_signed_in?
    find_and_toggle_recipe
    render template: 'recipes/toggle.js.erb'
  end

  def recipes
    return unless user_signed_in?
    @recipes = []
    if favorites = find_user_recipes
      favorites.each do |f|
        @recipes << Recipe.find(f.recipe_id)
      end
      render partial: 'recipes/favorites.js.erb'
    else
      render :nothing => true
    end
  end

  private

  def find_and_toggle_recipe
    @recipe = find_recipe
    if @recipe.favorited_by current_user
      current_user.unfavorite @recipe
    else
      current_user.favorite @recipe
    end
  end

  def find_recipe
    if id = params[:recipe_id].presence
      Recipe.find id
    end
  end

  def find_user_recipes
    if id = params[:user_id].presence
      current_user.favorites
    end
  end
end
