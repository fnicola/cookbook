module RecipesHelper
  def ingredients_format
    if @recipe.ingredients.present?
      a =  @recipe.ingredients.split(',')
      string = '<ul>'
      a.each do |i|
        string = string + "<li>#{i}</li>"
      end
      string = string + "</ul>"
    end
  end

  def toggle_xhr(recipe)
    if current_user
      if recipe.favorited_by current_user
        'Unfavorite'
      else
        'Favorite'
      end
    end
  end
end
