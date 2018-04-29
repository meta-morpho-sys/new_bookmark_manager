# frozen_string_literal: true

require 'pg_tester'
require './models/postgres_manager'

xdescribe PostgresqlManager do
  describe '.create' do
    psql = PgTester.new(
      database: 'new_bookmark_manager_test2',
      user: 'yuliya'
    )


    before(:each) do
      psql.setup
      psql.exec(SQLStrings::CREATE_TABLE_USERS)
      DbConnector.setup(psql.database)
    end
    after(:each) { psql.teardown }

    subject { PostgresqlManager.new(psql.host, psql.database, psql.user, psql.port) }
    # subject { PostgresqlManager.new(psql.id, psql.email) }


    context 'testing create user method' do
      it 'creates a new user' do
        PostgresqlManager.create('DummyUsername', 'Complex Password')
        p result = psql.exec('SELECT email FROM users')
        p result.any?
        expect(result.values).to include ['DummyUsername']
      end
    end
  end
end
