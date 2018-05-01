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
    res = DbConnector.query("SELECT count(*) FROM bookmarks_tags WHERE bm_id = #{bm_id} AND tg_id = #{tg_id}")
    p res[0]['count'] == '1'
    # result.map { |bt| BookmarkTag.new(bt['bt_id']) } == '1'
  end
end
