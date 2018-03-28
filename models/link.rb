# frozen_string_literal: true

require './lib/database_connection'

# Connects to the DB via DatabaseConnection
# Makes queries to create and fetch the links from the DB.
class Link
  def self.all
    result = DatabaseConnection.query 'SELECT * FROM links'
    result.map { |link| link['url'] }
  end

  def self.create(url)
    DatabaseConnection.query("INSERT INTO links (url) VALUES('#{url}')")
  end

  def self.delete(url)
    DatabaseConnection.query("DELETE FROM links WHERE url='#{url}'")
  end
end
