# frozen_string_literal: true

require_relative '../models/link'

describe Link do
  describe '.all' do
    it 'has all links' do
      links = Link.all

      expect(links).to include 'https://online.lloydsbank.co.uk'
      expect(links).to include 'https://www.borrowmydoggy.com/search/dogs'
      expect(links).to include 'http://vogliadicucina.blogspot.co.uk'
    end
  end
end
