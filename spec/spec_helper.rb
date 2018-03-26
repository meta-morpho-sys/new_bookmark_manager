# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rake'

Rake.application.load_rakefile

RSpec.configure do |config|
  config.before(:each) do
    Rake::Task['test_database_setup'].execute
  end
end

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'simplecov'
require 'simplecov-console'

# require our Sinatra app file
require File.join(File.dirname(__FILE__), '..', 'app.rb')

Capybara.app = BookmarkManager

SCF = SimpleCov::Formatter
formatters = [SCF::Console, SCF::HTMLFormatter]
SimpleCov.formatter = SCF::MultiFormatter.new(formatters)

SimpleCov.start
