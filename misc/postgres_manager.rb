# frozen_string_literal: true

require 'pg'

class PostgresqlManager
  def initialize(host, database, user, port)
    @connection = PG.connect(host: host, dbname: database, user: user, port: port)
  end

  def create(email, password)
    result = @connection.exec(
      SQLStrings::INSERT_USERS_EML_PSWD_RETURN, [email, password]
    )
  end
end
