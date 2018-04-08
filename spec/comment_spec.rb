# frozen_string_literal: true

require_relative '../models/comment.rb'

describe Comment do
  let(:comments) { Comment.all }
  let(:text) { comments.map(&:text) }

  describe '.all' do
    it 'returns all comments wrapped in comments instances' do
      expect(text).to include 'Great bookmark'
      expect(text).to include 'Very useful'
    end
  end

  describe '.create' do
    it 'adds a new comment' do
      bookmark = Bookmark.new(3, 'http://www.testlink.com', 'test')
      comment = Comment.create('My comment', bookmark.id)
      expect(comment.id).not_to be_nil
    end
  end

  describe '.comments' do
    it 'returns all comments with a bookmark_id equal to this BM ID' do
      bookmark = Bookmark.create('https://test_for_comments.com', 'test 1')
      comment1 = Comment.create('I am comment1 for this BM ID', bookmark.id)
      comment2 = Comment.create('I am comment2 for this BM ID', bookmark.id)
      expect(Comment.comments.map(&:id)).to include comment1.id, comment2.id
    end
  end

  describe '#==' do
    example 'two Comments are equal if their IDs match' do
      comment1 = Comment.new(1, 'https://test.com', 'test 1')
      comment2 = Comment.new 1, 'https://test.com', 'test 1'
      expect(comment1).to eq comment2
    end
  end
end