# frozen_string_literal: true

require_relative '../models/tag'

describe Tag do
  subject(:tag) { Tag.create('Health and Well-being') }
  describe '.create' do
    it 'adds a new tag to the bookmark' do
      expect(tag.id).not_to be_nil
    end
  end
end
