# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.before(:each) do
    require_relative 'test_database_setup'
  end
end

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'simplecov'
require 'simplecov-console'
# require 'features/web_helpers'

# require our Sinatra app file
require File.join(File.dirname(__FILE__), '..', 'app.rb')

Capybara.app = BookmarkManager

SCF = SimpleCov::Formatter
formatters = [SCF::Console, SCF::HTMLFormatter]
SimpleCov.formatter = SCF::MultiFormatter.new(formatters)

SimpleCov.start
