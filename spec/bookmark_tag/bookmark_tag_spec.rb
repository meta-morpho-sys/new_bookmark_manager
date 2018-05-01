# frozen_string_literal: true

require_relative '../../models/bookmark_tag'

describe BookmarkTag do
  describe '.create' do
    it 'creates a new join between links and tags' do
      user = User.create('test@example', 'password123')
      user2 = User.create('test2@example', 'password123')
      bm = Bookmark.create('https://www.borrowmydoggy.com/', 'Doggy', user.id)
      bm2 = Bookmark.create('https://www.great_dane.com/', 'Great Dane', user2.id)
      tag = Tag.create('Health and Well-being')
      bm_tag1 = BookmarkTag.create(bm.id, tag.id)
      bm_tag2 = BookmarkTag.create(bm2.id, tag.id)

      expect(bm_tag1).not_to be_nil
      expect(bm_tag2).not_to be_nil
    end
  end

  describe '#exists?' do
    example "we don't want the same tag to be assigned twice to the same bm" do
      user = User.create('test@example', 'password123')
      bm = Bookmark.create('https://www.borrowmydoggy.com/', 'Doggy', user.id)
      tag = Tag.create('Health and Well-being')
      BookmarkTag.create(bm.id, tag.id)
      expect(BookmarkTag.exists?(bm.id, tag.id)).to eq true
    end
  end
end
