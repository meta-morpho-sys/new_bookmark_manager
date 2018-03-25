# frozen_string_literal: true

require './lib/database_connection'

db_name = 'new_bookmark_manager'
db_name += '_test' if ENV['RACK_ENV'] == 'test'

DatabaseConnection.setup(db_name)
