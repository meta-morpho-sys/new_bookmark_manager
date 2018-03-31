# frozen_string_literal: true

require_relative '../models/link'

describe Link do
  let(:links) { Link.all }
  describe '.all' do
    it 'returns all links wrapped in links instances' do
      urls = links.map(&:url)
      expect(urls).to include('https://online.lloydsbank.co.uk')
      expect(urls).to include('https://www.borrowmydoggy.com/')
      expect(urls).to include('http://vogliadicucina.blogspot.co.uk')
    end
  end

  describe '.create' do
    it 'adds a new link' do
      Link.create 'http://www.new-test-link.com', 'Test title'
      urls = links.map(&:url)
      titles = links.map(&:title)
      expect(titles).to include 'Test title'
      expect(urls).to include('http://www.new-test-link.com')
    end

    it 'does not add a new link if it is not valid' do
      Link.create 'not a real link', 'Not real title hehehe'
      urls = links.map(&:url)
      titles = links.map(&:title)
      expect(titles).not_to include 'Not real title hehehe'
      expect(urls).not_to include 'not a real link'
    end
  end

  describe '.delete' do
    it 'deletes a link' do
      Link.delete '1'
      expect(links).not_to include 'https://online.lloydsbank.co.uk'
    end
  end
end
