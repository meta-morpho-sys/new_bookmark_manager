# frozen_string_literal: true

class Comments
  attr_reader :text, :link_id

  def initialize(text, link_id)
    @text = text
    @link_id = link_id
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM comments'
    result.map { |comm| Comments.new comm['text'], comm['link_id'] }.first
  end
end
