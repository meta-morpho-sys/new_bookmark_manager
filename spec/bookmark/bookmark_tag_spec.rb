# frozen_string_literal: true

require_relative '../../models/bookmark_tag'

describe BookmarkTag do
  describe '.create' do
    it 'creates a new join between links and tags' do
      user = User.create('test@example', 'password123')
      bm = Bookmark.create('https://www.borrowmydoggy.com/', 'Doggy', user.id)
      tag = Tag.create('Health and Well-being')
      bm_tag = BookmarkTag.create(bm.id, tag.id)
      expect(bm_tag).not_to be_nil
    end
  end
end
