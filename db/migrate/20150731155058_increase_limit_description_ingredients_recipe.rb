class IncreaseLimitDescriptionIngredientsRecipe < ActiveRecord::Migration
  def change
    change_column :recipes, :description, :text, :limit => 16777215
    change_column :recipes, :ingredients, :text, :limit => 16777215
  end
end
