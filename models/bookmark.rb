# frozen_string_literal: true

require './lib/db_connector'

# Connects to the DB via DatabaseConnection
# Makes queries to execute the CRUD actions on the bookmarks in the DB.
class Bookmark
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def ==(other)
    @id == other.id
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM bookmarks'
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  def self.create(url, title)
    return false unless a_url?(url)
    DbConnector.query("INSERT INTO bookmarks (url, title)
                                VALUES ('#{url}', '#{title}')")
  end

  def self.delete(id)
    DbConnector.query("DELETE FROM bookmarks WHERE id='#{id}'")
  end

  def self.update(id, url, title)
    return false unless a_url?(url)
    DbConnector.query("UPDATE
                                bookmarks
                            SET
                                Title = '#{title}',
                                url = '#{url}'
                            WHERE
                                id = #{id}")
  end

  def self.find(id)
    result = DbConnector.query("SELECT * FROM bookmarks WHERE id='#{id}'")
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }.first
  end

  def self.a_url?(string)
    string.match?(/\A#{URI.regexp(%w[http https])}\z/)
  end
end

# TODO : Use a 'max_length' CONSTANT to reference bookmark length in the app
# BOOKMARKS_MAX_LENGTH = 1000
# TODO : .update - If no new title or url are provided, keep the old one
# TODO : .delete - Add a request to confirm deletion before deleting.
