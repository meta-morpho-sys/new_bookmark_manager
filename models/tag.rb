# frozen_string_literal: true

# Creates and stores tags in the database
class Tag
  attr_reader :id, :content

  def initialize(id, content)
    @id = id
    @content = content
  end

  def ==(other)
    @id == other.id
  end

  def bookmarks
    result = DbConnector.query_params(
      SQLStrings::SELECT_JOIN_BKMARK_ID,
      [id]
    )
    result.map { |bm| Bookmark.new(bm['id'], bm['url'], bm['title']) }
  end


  def self.create(content)
    result = DbConnector.query_params(
      SQLStrings::INSERT_TAGS_CONTENT,
      [content])
    Tag.new(result[0]['id'], result[0]['content']
    )
  end

  def self.find(id)
    result = DbConnector.query("SELECT * FROM tags WHERE id='#{id}'")
    result.map { |tag| Tag.new(tag['id'], tag['content']) }.first
  end
end
