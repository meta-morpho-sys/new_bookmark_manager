# frozen_string_literal: true

require './lib/db_connector'

db_name = 'new_bookmark_manager'
db_name += '_test' if ENV['RACK_ENV'] == 'test'

DbConnector.setup(db_name)
