# frozen_string_literal: true

require 'bcrypt'
# Interacts with the  DB to persist user data
class User
  attr_reader :id, :email, :password

  def initialize(id, email, password)
    @id = id
    @email = email
    @password = password
  end

  # TODO: look into how to merge this with initialize, using keyword args ** ?
  def self.make(user)
    User.new(user['id'], user['email'], user['password'])
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM users'
    result.map { |user| make(user) }
  end

  def self.create(email, pswd)
    password = BCrypt::Password.create(pswd)
    result = DbConnector.query_params('INSERT INTO users (email, password)
                                                VALUES ($1, $2)
                                            RETURNING
                                                id, email',
                                      [email, password])
    make(result[0])
  end

  def self.find(id)
    return nil unless id
    result = DbConnector.query("SELECT * FROM users WHERE id = #{id}")
    make(result[0])
  end
end
