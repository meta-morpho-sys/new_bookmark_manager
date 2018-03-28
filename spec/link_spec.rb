# frozen_string_literal: true

require_relative '../models/link'

describe Link do
  let(:links) { Link.all }
  describe '.all' do
    it 'has all links' do
      expect(links).to include 'https://online.lloydsbank.co.uk'
      expect(links).to include 'https://www.borrowmydoggy.com/search/dogs'
      expect(links).to include 'http://vogliadicucina.blogspot.co.uk'
    end
  end

  describe '.create' do
    it 'adds a new link' do
      link = Link.create 'www.new-test-link.com'
      links << link
      expect(links).to include 'www.new-test-link.com'
    end
  end

  describe '.delete' do
    it 'deletes a link' do
      Link.delete 'https://online.lloydsbank.co.uk'
      expect(links).not_to include 'https://online.lloydsbank.co.uk'
    end
  end
end
