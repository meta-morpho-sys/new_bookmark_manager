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

  def comments
    Comment.comments @id
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM bookmarks'
    result.map { |bm| Bookmark.new(bm['id'], bm['url'], bm['title']) }
  end

  def self.create(url, title)
    return false unless a_url?(url)

    result = DbConnector.query_params('INSERT INTO bookmarks (url, title)
                                                VALUES ($1, $2)
                                            RETURNING
                                                id, url, title',
                                      [url, title])
    Bookmark.new(result[0]['id'], result[0]['url'], result[0]['title'])
  end

  def self.delete(id)
    DbConnector.query_params('DELETE FROM bookmarks WHERE id=$1', [id])
  end

  def self.update(id, url, title)
    return false unless a_url?(url)
    DbConnector.query_params('UPDATE
                                bookmarks
                            SET
                                Title = $3,
                                url = $2
                            WHERE
                                id = $1', [id, url, title])
  end

  def self.find(id)
    result = DbConnector.query("SELECT * FROM bookmarks WHERE id='#{id}'")
    result.map { |bm| Bookmark.new(bm['id'], bm['url'], bm['title']) }.first
  end

  def self.a_url?(string)
    string.match?(/\A#{URI.regexp(%w[http https])}\z/)
  end
end

# TODO : Use a 'max_length' CONSTANT to reference bookmark length in the app
# BOOKMARKS_MAX_LENGTH = 1000
# TODO : .delete - Add a request to confirm deletion before deleting.
