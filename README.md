# Cookbook

Cookbook is a small webapp written in Ruby on Rails. A few features are available so far:

 - signin/signup
 - create/edit/destroy a recipe [only admin users]
 - Show a Recipe
 - List all the recipes available
 - Search recipes with a keyword across name, ingredients and cooking time fields
 - favorite/unfavorite recipes
 - Filter by favorite recipes

Every features in the app is covered with end to end tests, written with `rspec` and `capybara`.

For achieving these goals I used a few gems, that are quite popular in RoR framework. Here's a list:

 - [devise](https://github.com/plataformatec/devise) - for having a flexible authentication solution
 - [pg-search](https://github.com/Casecommons/pg_search) - for full-text search
 - [kaminari](https://github.com/amatsuda/kaminari) - for pagination
 - [gaffe](https://github.com/mirego/gaffe) - for handling exceptions

I deployed this first version on [heroku](https://ricettario.herokuapp.com/), if you want to play a bit with it, I created an admin user: [admin@cookbook.com|adminadmin]
## Notes
The frontend part of the webapp is really basic. I wanted to focus in making available all the features instead. Basic improvments are quite easy to achieve by the way, but they were not the focus of my task.

### Tests
- Tests are made using Rspec and Capybara. And I made end to end tests. To execute all the suite: `bundle exec rspec spec` you can read them in the folder `/spec/features/`

### Show recipe
- The ingredients are showed as an html list. I created an helper that convert the ingredients into a list. As a prerequisite when you create a recipe you should separate all the ingredients by a comma.
- The picture of the recipe should be an url. The view will resolve the url and show the picture
- `Favorite` is a link with an ajax call included. It will call add the recipe to the user's favorite recipes. When clicked, the text of the link will change in `Unfavorite`.

### List recipes
- Every recipe is listed with the available actions: if you are admin, you can other than `show` also `edit` and `destroy` the recipe
- Favorite filter, show just recipes that were previously set as `favorite`. Its available only for logged in users.
- `Search`, search full text on recipes fields: name, ingredients and time, allowing partial match. I.e. the keyword `mush` will partially match with `mushrooms`
- Kaminari is setup to show `pagination` when the recipes are more than 10, every page will show 10 recipes

### What I would do with more time (a few days more)
- Add bootstrap and some javascript for a basic improvement of the user interface (currently its from '80 :D )
- Using an AJAX call also for the search
- Add Tags and taxonomy, to use to have a feature for similar recipes and for improving the search. i.e. `cake` will return all the cake available in the website even the one that doesn't come with cake in the name
