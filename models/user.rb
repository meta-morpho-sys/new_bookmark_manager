# frozen_string_literal: true

require 'bcrypt'

# Interacts with the  DB to persist user data
class User
  attr_reader :id, :email

  def initialize(id, email)
    @id = id
    @email = email
  end

  # TODO: look into how to merge this with initialize, using keyword args ** ?
  def self.wrap(user)
    User.new(user['id'], user['email'])
  end

  def self.all
    result = DbConnector.query 'SELECT * FROM users'
    result.map { |user| wrap(user) }
  end

  def self.create(email, pswd)
    password = BCrypt::Password.create(pswd)
    result = DbConnector.query_params(
      SQLStrings::INSERT_USERS_EML_PSWD_RETURN,
      [email, password]
    )
    wrap(result[0])
  end

  def self.find(id)
    return nil unless id
    result = DbConnector.query("SELECT * FROM users WHERE id = #{id}")
    wrap(result[0])
  end

  def self.authenticate(email, pswd)
    result = DbConnector.query("SELECT * FROM users WHERE email = '#{email}'")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password_hash']) == pswd
    wrap(result[0])
  end

  def bookmarks
    result = DbConnector.query("SELECT
                                      *
                                  FROM
                                      bookmarks
                                  WHERE
                                      user_id = '#{id}'")
    result.map { |bm| Bookmark.new(bm['id'], bm['url'], bm['title']) }
  end

end
