ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'capybara/rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

class IntegrationTest < MiniTest::Spec

  include Rails.application.routes.url_helpers
  include Capybara::DSL

  before(:each) do
    DatabaseCleaner.start
  end
  after(:each) do
    DatabaseCleaner.clean
  end

  register_spec_type(/integration$/, self)
end
