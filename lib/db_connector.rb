# frozen_string_literal: true

require 'pg'

# Connects to the correct database for the current environment
# when the app starts
class DbConnector
  def self.setup(db_name, conn = nil)
    @connection = conn || PG.connect(dbname: db_name)
  end

  def self.query(sql)
    @connection.exec(sql)
  end

  def self.query_params(sql, data)
    @connection.exec_params(sql, data)
  end
end
