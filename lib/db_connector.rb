# frozen_string_literal: true

require 'pg'

# Connects to the correct database for the current environment
# when the app starts
class DbConnector
  def self.setup(db_name)
    @connection = PG.connect(dbname: db_name)
  end

  def self.query(sql)
    @connection.exec(sql)
  end
end
