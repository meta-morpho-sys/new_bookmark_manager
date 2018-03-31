# frozen_string_literal: true

require_relative '../models/link'

describe Link do
  let(:links) { Link.all }
  let(:urls) { links.map(&:url) }
  let(:titles) { links.map(&:title) }
  describe '.all' do
    it 'returns all links wrapped in links instances' do
      expect(titles).to include 'Lloyds'
      expect(titles).to include 'Doggy'
      expect(titles).to include 'Recipes'
    end
  end

  describe '.create' do
    it 'adds a new link' do
      Link.create 'http://www.new-test-link.com', 'Test title'
      expect(titles).to include 'Test title'
      expect(urls).to include('http://www.new-test-link.com')
    end

    it 'does not add a new link if it is not valid' do
      Link.create 'not a real link', 'Not real title hehehe'
      expect(titles).not_to include 'Not real title hehehe'
      expect(urls).not_to include 'not a real link'
    end
  end

  describe '.delete' do
    it 'deletes a link' do
      Link.delete '2'
      expect(titles).not_to include 'Lloyds'
      expect(links).not_to include 'https://online.lloydsbank.co.uk'
    end
  end
end
