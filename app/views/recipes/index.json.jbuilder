json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :time, :ingredients, :description
  json.url recipe_url(recipe, format: :json)
end
