# frozen_string_literal: true

require './lib/db_connector'

# Creates and displays comments for each bookmark.
class Comment
  attr_reader :id, :text, :bookmark_id

  def initialize(id, text, bookmark_id)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM comments'
    result.map { |comm| Comment.new(comm['id'], comm['text'], comm['bookmark_id']) }
  end

  def self.create(text, bookmark_id)
    result = DbConnector.query("INSERT INTO comments (text, bookmark_id)
                                        VALUES ('#{text}', '#{bookmark_id}')
                                    RETURNING
                                        id, text, bookmark_id")
    Comment.new(result[0]['id'], result[0]['text'], result[0]['bookmark.id'])
  end
end
