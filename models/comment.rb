# frozen_string_literal: true

class Comment
  attr_reader :id, :text, :link_id

  def initialize(id, text, link_id)
    @id = id
    @text = text
    @link_id = link_id
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM comments'
    result.map { |comm| Comment.new(comm['id'], comm['text'], comm['link_id']) }
  end
end
