class SearchController < ApplicationController
  def recipes
    @recipes = Recipe.whose_name_starts_with(params[:keywords])
    @recipes = @recipes.page(params[:page]).per(2)
  end
end
