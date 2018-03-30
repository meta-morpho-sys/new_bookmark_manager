# frozen_string_literal: true

require './lib/db_connector'

# Connects to the DB via DatabaseConnection
# Makes queries to create and fetch the links from the DB.
class Link
  def self.all
    result = DbConnector.query 'SELECT * FROM links'
    result.map { |link| link['url'] }
  end

  def self.create(url)
    return false unless a_url?(url)
    DbConnector.query("INSERT INTO links (url) VALUES('#{url}')")
  end

  def self.delete(url)
    DbConnector.query("DELETE FROM links WHERE url='#{url}'")
  end

  def self.a_url?(url_string)
    url_string.match?(/\A#{URI.regexp(%w[http https])}\z/)
  end

end
