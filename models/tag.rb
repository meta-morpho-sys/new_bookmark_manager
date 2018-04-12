# frozen_string_literal: true

# Creates and stores tags in the database
class Tag
  attr_reader :id, :content

  def initialize(id, content)
    @id = id
    @content = content
  end

  def bookmarks
    result = DbConnector.query("SELECT
                                        bookmarks.id, title, url
                                     FROM
                                        bookmarks_tags
                                     INNER JOIN bookmarks
                                     ON bookmarks.id = bookmarks_tags.bm_id
                                     WHERE
                                        bookmarks_tags.tg_id = #{@id}")
    result.map { |bm| Bookmark.new(bm['id'], bm['url'], bm['title']) }
  end

  def self.create(content)
    result = DbConnector.query_params('INSERT INTO tags (content)
                                                VALUES ($1)
                                            RETURNING
                                                id, content', [content])
    Tag.new(result[0]['id'], result[0]['content'])
  end

  def self.find(id)
    result = DbConnector.query("SELECT * FROM tags WHERE id='#{id}'")
    result.map { |tag| Tag.new(tag['id'], tag['content']) }.first
  end
end
