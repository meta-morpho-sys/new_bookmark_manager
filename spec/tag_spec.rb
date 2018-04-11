# frozen_string_literal: true

require_relative '../models/tag'

describe Tag do
  before(:each) do
    @bm = Bookmark.create('https://www.borrowmydoggy.com/', 'Doggy')
    @tag = Tag.create('Health and Well-being', @bm.id)
  end

  describe '.create' do
    it 'adds a new tah to the bookmark' do
      expect(@tag.id).not_to be_nil
    end
  end
end
