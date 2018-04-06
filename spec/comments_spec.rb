# frozen_string_literal: true

require_relative '../models/comment.rb'

describe Comment do
  let(:comments) { Comment.all }
  let(:text) { comments.map(&:text) }

  describe '.all' do
    it 'returns all comments wrapped in comments instances' do
      expect(text).to include 'Great link'
      expect(text).to include 'Very useful'
    end
  end
end
