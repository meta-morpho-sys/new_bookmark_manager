# frozen_string_literal: true

require 'pg'

# Connects to the DB. Makes queries to fetch the links from the DB
class Link
  def self.all
    db_name = 'new_bookmark_manager'
    db_name += '_test' if ENV['RACK_ENV'] == 'test'

    connection = PG.connect(dbname: db_name)

    result = connection.exec('SELECT * FROM links')
    result.map { |link| link['url'] }
  end

  def self.create(url)
    db_name = 'new_bookmark_manager'
    db_name += '_test' if ENV['RACK_ENV'] == 'test'

    connection = PG.connect(dbname: db_name)
    connection.exec("INSERT INTO links (url) VALUES('#{url}')")
  end
end
