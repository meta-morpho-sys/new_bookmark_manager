# frozen_string_literal: true

# Connects to the correct database for the current environment
# when the app starts
class DatabaseConnection

  def self.setup(db_name)
    @connection = PG.connect(db_name: db_name)
  end
end
