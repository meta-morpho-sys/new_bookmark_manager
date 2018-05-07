# frozen_string_literal: true

require './lib/db_connector'

db_name = 'new_bookmark_manager'
db_name += '_test' if ENV['RACK_ENV'] == 'test'
DB_NAME = db_name

DbConnector.setup(DB_NAME)
