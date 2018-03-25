# frozen_string_literal: true

require './lib/database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to the database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'my_database')
      DatabaseConnection.setup('my_database')
    end
  end

  describe '.query' do
    it 'makes a query through PG' do
      connection = DatabaseConnection.setup 'new_bookmark_manager_test'
      expect(connection).to receive(:exec).with('SELECT * FROM links;')
      DatabaseConnection.query('SELECT * FROM links;')
    end
  end
end
