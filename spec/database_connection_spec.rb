# frozen_string_literal: true

require './models/database_connection'

describe DatabaseConnection do
  describe'.setup' do
    it 'sets up a connection to the database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'my_database')
      DatabaseConnection.setup('my_database')
    end

    example 'the connection is persistent' do
      conn = DatabaseConnection.setup('new_bookmark_manager_test')
      expect(DatabaseConnection.connection).to eq conn
    end
  end

end
