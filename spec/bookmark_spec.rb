# frozen_string_literal: true

require_relative '../models/bookmark'

describe Bookmark do

  let(:bm) { Bookmark.create('https://online.lloydsbank.co.uk', 'Lloyds') }
  let(:bookmarks) { Bookmark.all }
  let(:urls) { bookmarks.map(&:url) }
  let(:titles) { bookmarks.map(&:title) }

  describe '.all' do
    it 'returns all bookmarks wrapped in bookmarks instances' do
      bm1 = Bookmark.create('https://online.lloydsbank.co.uk1', 'Lloyds1')
      bm2 = Bookmark.create('https://online.lloydsbank.co.uk1', 'Lloyds2')
      expect(bookmarks).to eq [bm1, bm2]
    end
  end

  describe '.create' do
    it 'adds a new bookmark' do
      expect(bm.title).to eq 'Lloyds'
      expect(bm.url).to eq 'https://online.lloydsbank.co.uk'
      expect(bm.id).not_to be_nil
    end

    it 'does not add a new bookmark if it is not a valid url' do
      Bookmark.create 'not a real bookmark', 'Not real title hehehe'
      expect(titles).not_to include 'Not real title hehehe'
      expect(urls).not_to include 'not a real bookmark'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      Bookmark.delete(bm.id)
      expect(titles).not_to include 'Lloyds'
      expect(urls).not_to include 'https://online.lloydsbank.co.uk'
    end
  end

  describe '.update' do
    it 'updates the title' do
      Bookmark.update bm.id, 'https://test-online.lloydsbank.co.uk', 'Lloyds account'
      expect(urls).not_to include 'https://online.lloydsbank.co.uk'
      expect(urls).to include 'https://test-online.lloydsbank.co.uk'
      expect(titles).not_to include 'Lloyds'
      expect(titles).to include 'Lloyds account'
    end

    it 'does not update a bookmark if it is not valid' do
      Bookmark.update bm.id, 'not a real bookmark', 'Not real title hehe'
      expect(titles).not_to include 'Not real title hehe'
      expect(urls).not_to include 'not a real bookmark'
    end
  end

  describe '.find' do
    it 'finds a specific bookmark' do
      bookmark = Bookmark.find bm.id
      expect(bookmark.url).to eq 'https://online.lloydsbank.co.uk'
      expect(bookmark.title).to eq 'Lloyds'
    end
  end

  describe '#==' do
    example 'two Bookmarks are equal if their IDs match' do
      bookmark1 = Bookmark.new(1, 'https://test.com', 'test 1')
      bookmark2 = Bookmark.new 1, 'https://test.com', 'test 1'
      expect(bookmark1).to eq bookmark2
    end
  end

  describe '#comments' do
    it 'returns all the comments for that particular bookmark ID' do
      bm = Bookmark.create('https://test_comments.com', 'BM with comments')

      comment1 = Comment.create('I am comment1 for this BM ID', bm.id)
      comment2 = Comment.create('I am comment2 for this BM ID', bm.id)
      expect(bm.comments).to include comment1, comment2
    end
  end

  describe '#tags' do
    it 'returns all the tags associated with that particular BM ID' do
      tag1 = Tag.create'Business'
      tag2 = Tag.create 'Personal'
      BookmarkTag.create(bm.id, tag1.id)
      BookmarkTag.create(bm.id, tag2.id)

      expect(bm.tags.map(&:content)).to include tag1.content, tag2.content
    end
  end
end
