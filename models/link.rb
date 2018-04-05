# frozen_string_literal: true

require './lib/db_connector'

# Connects to the DB via DatabaseConnection
# Makes queries to execute the CRUD actions on the links in the DB.
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
    DbConnector.query("INSERT INTO links (url, title)
                                VALUES ('#{url}', '#{title}')")
  end

  def self.delete(id)
    DbConnector.query("DELETE FROM links WHERE id='#{id}'")
  end

  def self.update(id, url, title)
    return false unless a_url?(url)
    DbConnector.query("UPDATE
                                links
                            SET
                                Title = '#{title}',
                                url = '#{url}'
                            WHERE
                                id = #{id}")
  end

  def self.find(id)
    result = DbConnector.query("SELECT * FROM links WHERE id='#{id}'")
    result.map { |link| Link.new(link['id'], link['url'], link['title']) }.first
  end

  def self.a_url?(string)
    string.match?(/\A#{URI.regexp(%w[http https])}\z/)
  end
end

# TODO : Use a 'max_length' CONSTANT to reference link length in the app
# LINK_MAX_LENGTH = 1000
# TODO : .update - If no new title or url are provided, keep the old one
# TODO : .delete - Add a request to confirm deletion before deleting.
