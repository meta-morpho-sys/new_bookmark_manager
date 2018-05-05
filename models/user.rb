# frozen_string_literal: true

# Interacts with the  DB to persist user data; uses the BCRYPT gem
# for authentication
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

  def bookmarks_per_tag(content)
    result = DbConnector.query_params("SELECT
                                              bk.id, bk.url, bk.title
                                          FROM
                                              tags AS t, bookmarks AS bk, bookmarks_tags AS bt
                                          WHERE
                                          t.user_id=$1
                                          AND bt.bm_id=bk.id
                                          AND bt.tg_id=t.id
                                          OR t.content=$2", [id, content])
    result.map { |bm| Bookmark.new(bm['id'], bm['url'], bm['title']) }
  end
end
