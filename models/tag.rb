# frozen_string_literal: true

class Tag
  attr_reader :id, :content, :bm_id

  def initialize(id, content, bm_id)
    @id = id
    @content = content
    @bm_id = bm_id
  end

  def self.create(content, bm_id)
    result = DbConnector.query_params('INSERT INTO tags (content)
                                                VALUES ($1)
                                            RETURNING
                                                id, content', [content])
    Tag.new(result[0]['id'], result[0]['content'], bm_id)
  end
end
