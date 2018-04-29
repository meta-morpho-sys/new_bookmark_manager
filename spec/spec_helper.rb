# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'selenium-webdriver'
require 'simplecov'
require 'simplecov-console'
require 'features/web_helpers'
require 'rake'

Rake.application.load_rakefile

RSpec.configure do |config|
  config.before(:each) do
    Rake::Task['test_database_setup'].execute
  end
end

RSpec.configure do |config|
  config.order = :random
end

# require our Sinatra app file
require File.join(File.dirname(__FILE__), '..', 'app.rb')

# Setting up driver to communicate with HTML forms with  RESTful routes.
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(Rack::MethodOverride.new(app))
end

Capybara.app = BookmarkManager

SCF = SimpleCov::Formatter
formatters = [SCF::Console, SCF::HTMLFormatter]
SimpleCov.formatter = SCF::MultiFormatter.new(formatters)

SimpleCov.start
