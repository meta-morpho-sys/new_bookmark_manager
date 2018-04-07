# frozen_string_literal: true

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
end
