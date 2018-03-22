# frozen_string_literal: true

require 'pg'

# Connects to the DB. Makes queries to fetch the links from the DB
class Link
  def self.all
    connection = if ENV['RACK_ENV'] == 'test'
                   PG.connect(dbname: 'new_bookmark_manager_test')
                 else
                   PG.connect(dbname: 'new_bookmark_manager')
                 end

    result = connection.exec('SELECT * FROM links')
    result.map { |link| link['url'] }
  end
end
