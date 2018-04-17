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

  def self.make(comm)
    Comment.new(comm['id'], comm['text'], comm['bookmark_id'])
  end

  def ==(other)
    @id == other.id
  end

  def self.comments(bm_id = nil)
    where_clause = bm_id.nil? ? '' : "WHERE bookmark_id=#{bm_id}"
    result = DbConnector.query("SELECT * FROM comments #{where_clause}")
    result.map { |comm| make(comm) }
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM comments'
    result.map { |comm| make(comm) }
  end

  def self.create(text, bookmark_id)
    result = DbConnector.query_params(
      SQLStrings::INSERT_COMMS_TXT_BKMKID_RETURN,
      [text, bookmark_id]
    )
    make(result[0])
  end
end
