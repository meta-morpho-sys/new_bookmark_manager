# frozen_string_literal: true

# Persists a new join between bookmarks and tags to the DB
class BookmarkTag
  attr_reader :bt_id

  def initialize(bt_id)
    @bt_id = bt_id
  end

  def self.create(bm_id, tg_id)
    result = DbConnector.query_params(
      SQLStrings::INSERT_BKMARKS_TAGS_RETURN,
      [bm_id, tg_id]
    )
    BookmarkTag.new(result[0]['bt_id'])
  end

  def self.exists?(bm_id, tg_id)
    res = DbConnector.query_params(SQLStrings::COUNT_BKMARK_TAG_PAIR,
                                   [bm_id, tg_id])
    res[0]['count'] == '1'
  end
end
