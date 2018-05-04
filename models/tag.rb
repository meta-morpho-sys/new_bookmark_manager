# frozen_string_literal: true

# Creates and stores tags in the database
class Tag
  attr_reader :id, :content, :user_id

  def initialize(id, content, user_id)
    @id = id
    @content = content
    @user_id = user_id
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

  def self.create(content, user_id)
    result = DbConnector.query_params(
      SQLStrings::INSERT_TAGS_CONTENT,
      [content.capitalize, user_id]
    )
    wrap(result[0])
  end

  def self.fetch_existing_tag(identifier)
    result = DbConnector.query("SELECT
                                    *
                                FROM
                                    tags
                                WHERE
                                    content ILIKE '%#{identifier}%'")
    result.map { |tag| wrap(tag) }.first
  end

  def self.find(id)
    result = DbConnector.query("SELECT * FROM tags WHERE id='#{id}'")
    result.map { |tag| wrap(tag) }.first
  end

  def self.wrap(tag)
    Tag.new(tag['id'], tag['content'], tag['user_id'])
  end
end
