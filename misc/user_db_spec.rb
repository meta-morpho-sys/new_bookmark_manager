# frozen_string_literal: true

require 'pg_tester'
require './models/user'


describe User do
  psql = PgTester.new(
    database: 'new_bookmark_manager_test2',
    user: 'yuliya'
  )

  before(:each) do
    conn = psql.setup
    psql.exec(SQLStrings::CREATE_TABLE_USERS)
    DbConnector.setup(psql.database, conn)
  end
  after(:each) { psql.teardown }

  it '.create' do
    user = User.create('DummyUsername', 'Complex Password')
    p result = psql.exec('SELECT email FROM users')
    # p result.any?
    p User.all
    expect(user.email).to eq 'DummyUsername'
    expect(result.values).to include ['DummyUsername']
  end
end
