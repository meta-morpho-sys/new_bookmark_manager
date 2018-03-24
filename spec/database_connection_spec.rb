# frozen_string_literal: true

require './models/database_connection'

describe DatabaseConnection do
  describe'.setup' do
    it 'sets up a connection to the database through PG' do
      expect(PG).to receive(:connect).with(db_name: 'my_database')
      DatabaseConnection.setup('my_database')
    end

  end

end
