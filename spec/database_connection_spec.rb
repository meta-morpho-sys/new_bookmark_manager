# frozen_string_literal: true

require './lib/db_connector'

describe DbConnector do
  describe '.setup' do
    it 'sets up a connection to the database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'my_database')
      DbConnector.setup('my_database')
    end
  end

  describe '.query' do
    it 'makes a query through PG' do
      connection = DbConnector.setup 'new_bookmark_manager_test'
      expect(connection).to receive(:exec).with('SELECT * FROM bookmarks;')
      DbConnector.query('SELECT * FROM bookmarks;')
    end
  end
end
