require 'simplecov'
SimpleCov.start 'rails'
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
$: << File.expand_path('../../db/', __FILE__)

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Shoulda::Matchers::ActiveRecord
  config.include Shoulda::Matchers::ActiveModel
  
  config.include Capybara::DSL              # Let's us use the capybara stuf in our specs
  config.include Warden::Test::Helpers      # Let's us do login_as(user)
  config.include Rails.application.routes.url_helpers
  config.after(:each) do
    Warden.test_reset!
  end

  config.mock_with :rspec
  
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  # config.use_transactional_fixtures = true  # Each example runs in a transaction avodiing the need to clean the db
end

Capybara.configure do |config|
  config.match = :prefer_exact
end