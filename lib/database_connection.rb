# frozen_string_literal: true

# Connects to the correct database for the current environment
# when the app starts
class DatabaseConnection
  def self.setup(db_name)
    @connection = PG.connect(dbname: db_name)
  end

  def self.query(sql)
    @connection.exec(sql)
  end
end
