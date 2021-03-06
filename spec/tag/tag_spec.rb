# frozen_string_literal: true

require_relative '../../models/tag'

describe Tag do
  subject(:user) { User.create('test_tag@example', 'password123') }
  subject(:tag) { Tag.create('Health and Well-being') }

  describe '.create' do
    it 'adds a new tag to the bookmark' do
      expect(tag.id).not_to be_nil
    end

    it "evens out user's input" do
      consistent_tag = Tag.create('fUn')
      expect(consistent_tag.content).to eq 'Fun'
    end
  end

  describe '.fetch_existing_tag' do
    it 'fetches the tag if it already exists in the DB' do
      tag1 = Tag.create('Health and Well-being')
      fetched_tag = Tag.fetch_existing_tag('Health and well-being')
      expect(fetched_tag.id).to eq tag1.id
    end

    it 'fetches the tag even if partial name is given' do
      tag1 = Tag.create('Health and Well-being')
      fetched_tag = Tag.fetch_existing_tag('Health ')
      fetched_tag2 = Tag.fetch_existing_tag('-being')

      expect(fetched_tag.id).to eq tag1.id
      expect(fetched_tag2.id).to eq tag1.id
    end
  end

  describe '.find' do
    it 'finds a specific tag' do
      found_tag = Tag.find(tag.id)
      expect(found_tag.id).to eq tag.id
      expect(found_tag.content).to eq 'Health and well-being'
    end
  end

  describe '#bookmarks' do
    it 'returns all the BMs for that particular tag ID' do
      user1 = User.create('test@example', 'password123')
      user2 = User.create('test2@example', 'password1')
      bm1 = Bookmark.create('https://www.netflix.com', 'Netflix', user1.id)
      bm2 = Bookmark.create('https://www.odeon.com', 'Odeon', user1.id)
      bm3 = Bookmark.create('https://www.cora.com', 'Cora', user2.id)
      tag1 = Tag.create'Cinema'
      tag2 = Tag.create'Magic'
      BookmarkTag.create(bm1.id, tag1.id)
      BookmarkTag.create(bm2.id, tag1.id)
      BookmarkTag.create(bm3.id, tag2.id)

      expect(tag1.bookmarks).to include bm1, bm2
      expect(tag1.bookmarks).not_to include bm3
      expect(tag2.bookmarks).to include bm3
      expect(tag2.bookmarks).not_to include bm1, bm2
    end
  end

  describe '#==' do
    example 'two Tags are equal if their IDs match' do
      tag1 = Tag.new(1, 'Business')
      tag2 = Tag.new(1, 'Business')
      expect(tag1).to eq tag2
    end
  end
end
