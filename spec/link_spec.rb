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

    it 'raises an exception if a title is duplicated' do
      Link.create 'http://www.new-test-link.com', 'Test title'
      expect { Link.create 'http://www.doubled-title.com', 'Test title' }
        .to raise_error 'Title *Test title* already exists'
    end
  end

  describe '.delete' do
    it 'deletes a link' do
      Link.delete '2'
      expect(titles).not_to include 'Lloyds'
      expect(links).not_to include 'https://online.lloydsbank.co.uk'
    end
  end

  describe '.update' do
    it 'updates the title' do
      Link.update '2', 'https://test-online.lloydsbank.co.uk', 'Lloyds account'
      expect(urls).not_to include 'https://online.lloydsbank.co.uk'
      expect(urls).to include 'https://test-online.lloydsbank.co.uk'
      expect(titles).not_to include 'Lloyds'
      expect(titles).to include 'Lloyds account'
    end

    it 'does not update a link if it is not valid' do
      Link.update '3', 'not a real link', 'Not real title hehehe'
      expect(titles).not_to include 'Not real title hehehe'
      expect(urls).not_to include 'not a real link'
    end

    it 'returns previously submitted url if no new url is provided' do
      Link.update '2', '', 'Lloyds account'
      expect(urls).to include 'https://online.lloydsbank.co.uk'
    end

    xit 'returns previously submitted title if no new title is provided' do
      Link.update '2', 'https://test-online.lloydsbank.co.uk', ''
      expect(titles).to include 'Lloyds'
    end
  end

  describe '.find' do
    it 'finds a specific link' do
      link = Link.find 2
      expect(link.url).to eq 'https://online.lloydsbank.co.uk'
      expect(link.title).to eq 'Lloyds'
    end
  end
end
