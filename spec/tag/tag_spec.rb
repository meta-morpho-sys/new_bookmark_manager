# frozen_string_literal: true

require_relative '../models/odels/tag'

describe Tag do
  subject(:tag) { Tag.create('Health and Well-being') }
  describe '.create' do
    it 'adds a new tag to the bookmark' do
      expect(tag.id).not_to be_nil
    end
  end

  describe '.find' do
    it 'finds a specific tag' do
      tag = Tag.create 'Fun and movies'
      found_tag = Tag.find(tag.id)
      expect(found_tag.id).to eq tag.id
      expect(found_tag.content).to eq 'Fun and movies'
    end
  end

  describe '#bookmarks' do
    # let(:bm1) { double :bookmark_netflix }
    # let(:bm2) { double :bookmark_odeon }

    it 'returns all the BMs for that particular tag ID' do
      bm1 = Bookmark.create('https://www.netflix.com', 'Netflix')
      bm2 = Bookmark.create('https://www.odeon.com', 'Odeon')
      tag = Tag.create'Movies'
      BookmarkTag.create(bm1.id, tag.id)
      BookmarkTag.create(bm2.id, tag.id)

      expect(tag.bookmarks).to include bm1, bm2
    end
  end

  describe '#==' do
    example 'two Tags are equal if their IDs match' do
      tag1 = Tag.new(1,'Business')
      tag2 = Tag.new(1,'Business')
      expect(tag1).to eq tag2
    end
  end
end
