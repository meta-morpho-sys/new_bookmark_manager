# frozen_string_literal: true

require_relative '../models/bookmark'

describe Bookmark do
  let(:bookmarks) { Bookmark.all }
  let(:urls) { bookmarks.map(&:url) }
  let(:titles) { bookmarks.map(&:title) }
  describe '.all' do
    it 'returns all bookmarks wrapped in bookmarks instances' do
      expect(titles).to include 'Lloyds'
      expect(titles).to include 'Doggy'
      expect(titles).to include 'Recipes'
    end
  end

  describe '.create' do
    it 'adds a new bookmark' do
      Bookmark.create 'http://www.new-test-bookmark.com', 'Test title'
      expect(titles).to include 'Test title'
      expect(urls).to include('http://www.new-test-bookmark.com')
    end

    it 'does not add a new bookmark if it is not a valid url' do
      Bookmark.create 'not a real bookmark', 'Not real title hehehe'
      expect(titles).not_to include 'Not real title hehehe'
      expect(urls).not_to include 'not a real bookmark'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      Bookmark.delete '2'
      expect(titles).not_to include 'Lloyds'
      expect(urls).not_to include 'https://online.lloydsbank.co.uk'
    end
  end

  describe '.update' do
    it 'updates the title' do
      Bookmark.update '2', 'https://test-online.lloydsbank.co.uk', 'Lloyds account'
      expect(urls).not_to include 'https://online.lloydsbank.co.uk'
      expect(urls).to include 'https://test-online.lloydsbank.co.uk'
      expect(titles).not_to include 'Lloyds'
      expect(titles).to include 'Lloyds account'
    end

    it 'does not update a bookmark if it is not valid' do
      Bookmark.update '3', 'not a real bookmark', 'Not real title hehehe'
      expect(titles).not_to include 'Not real title hehehe'
      expect(urls).not_to include 'not a real bookmark'
    end

    it 'returns previously submitted url if no new url is provided' do
      Bookmark.update '2', '', 'Lloyds account'
      expect(urls).to include 'https://online.lloydsbank.co.uk'
    end
  end

  describe '.find' do
    it 'finds a specific bookmark' do
      bookmark = Bookmark.find 2
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
end
