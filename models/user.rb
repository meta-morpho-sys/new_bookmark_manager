# frozen_string_literal: true

# Interacts with the  DB to persist user data
class User
  attr_reader :id, :email, :password

  def initialize(id, email, password)
    @id = id
    @email = email
    @password = password
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM users'
    result.map { |user| User.new(user['id'], user['email'], user['password']) }
  end

  def self.create(email, password)
    result = DbConnector.query_params('INSERT INTO users (email, password)
                                                VALUES ($1, $2)
                                            RETURNING
                                                id, email, password',
                                      [email, password])
    User.new(result[0]['id'], result[0]['email'], result[0]['password'])
  end

  def self.find(id)
    return nil unless id
    result = DbConnector.query("SELECT * FROM users WHERE id = #{id}")
    User.new(result[0]['id'], result[0]['email'], result[0]['password'])
  end
end
