# frozen_string_literal: true

require './lib/db_connector'
require './models/tag'
require './lib/sql_strings'

# Connects to the DB via DatabaseConnection
# Makes queries to execute the CRUD actions on the bookmarks in the DB.
class Bookmark
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.make(bkmark)
    Bookmark.new(bkmark['id'], bkmark['url'], bkmark['title'])
  end

  def ==(other)
    @id == other.id
  end

  def comments
    Comment.comments id
  end

  def tags
    result = DbConnector.query_params(SQLStrings::SELECT_JOIN_TAG_ID, [id])
    result.map { |tag| Tag.new(tag['id'], tag['content']) }
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM bookmarks'
    result.map { |bm| make(bm) }
  end

  def self.create(url, title)
    return false unless a_url?(url)
    result = DbConnector.query_params(
      SQLStrings::INSERT_BKMARKS_URL_TTL_RETURN,
      [url, title]
    )
    make(result[0])
  end

  def self.delete(id)
    DbConnector.query_params('DELETE FROM bookmarks WHERE id=$1', [id])
  end

  def self.update(id, url, title)
    return false unless a_url?(url)
    DbConnector.query_params(
      SQLStrings::UPDATE_BKMARKS_TTL_URL_ID,
      [id, url, title]
    )
  end

  def self.find(id)
    result = DbConnector.query("SELECT * FROM bookmarks WHERE id='#{id}'")
    result.map { |bm| make(bm) }.first
  end

  def self.a_url?(string)
    string.match?(/\A#{URI.regexp(%w[http https])}\z/)
  end
end

# TODO : Use a 'max_length' CONSTANT to reference bookmark length in the app
# BOOKMARKS_MAX_LENGTH = 1000
# TODO : .delete - Add a request to confirm deletion before deleting.
