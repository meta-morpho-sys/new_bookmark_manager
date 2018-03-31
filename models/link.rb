# frozen_string_literal: true

require './lib/db_connector'

# Connects to the DB via DatabaseConnection
# Makes queries to create and fetch the links from the DB.
class Link
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM links'
    result.map { |link| Link.new(link['id'], link['url'], link['title']) }
  end

  def self.create(url, title)
    return false unless a_url?(url)
    DbConnector.query("INSERT INTO links (url,title) VALUES('#{url}','#{title}')")
  end

  def self.delete(url)
    DbConnector.query("DELETE FROM links WHERE url='#{url}'")
  end

  def self.a_url?(url_string)
    url_string.match?(/\A#{URI.regexp(%w[http https])}\z/)
  end
end
# TODO : Raise Exception if user tries to save the same link more than once.
# TODO : Use a 'max_length' CONSTANT to reference link length in the app
# LINK_MAX_LENGTH = 1000
