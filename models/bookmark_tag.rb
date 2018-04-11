# frozen_string_literal: true

# Persists a new join between bookmarks and tags to the DB
class BookmarkTag
  attr_reader :bt_id

  def initialize(bt_id)
    @bt_id = bt_id
  end

  def self.create(bm_id, tg_id)
    result = DbConnector.query_params('INSERT INTO bookmarks_tags (bm_id, tg_id)
                                                VALUES ($1, $2)
                                            RETURNING
                                                bt_id', [bm_id, tg_id])
    BookmarkTag.new(result[0]['bt_id'])
  end
end
