require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Capybara.register_driver :chrome do |app|
  #   Capybara::Selenium::Driver.new(app, browser: :chrome)
  # end

  # Capybara.javascript_driver = :chrome
  # Capybara.default_wait_time = 5
  # # Add more helper methods to be used by all tests here...

  #test
  #fixes issues with capybara not detecting db changes made during tests

  # -- JS driver setup
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: true)
  end

  Capybara.register_driver :debug do |app|
    Capybara::Poltergeist::Driver.new(app, inspector: true, js_errors: true)
  end

  Capybara.register_driver :stripe_poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, phantomjs_options: ['--ignore-ssl-errors=true', '--web-security=false', '--ssl-protocol=any'],
                                      js_errors: false,
                                      # gets rid of phantomjs warnings about not being able to access the shopa logo icon
                                      phantomjs_logger: File.open(File::NULL, 'w'))
  end

  Capybara.javascript_driver = ENV['CHROME_DRIVER'] ? :chrome : :poltergeist

  Capybara.default_host = 'https://example.com'
end
