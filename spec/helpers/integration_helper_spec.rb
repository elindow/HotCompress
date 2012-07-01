#require File.expand_path("../../helper/spec_helper", __FILE__)
require 'capybara/rails'

### capybara configuration ###
DatabaseCleaner.strategy = :truncation
class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Warden::Test::Helpers

  Warden.test_mode!
  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
    # seed_file = File.join(Rails.root, "db", "seeds.rb")
    # load(seed_file)
    Warden.test_reset!
  end
end