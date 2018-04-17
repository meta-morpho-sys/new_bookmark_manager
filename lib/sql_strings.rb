# frozen_string_literal: true

class SQLStrings
  CREATE_TABLE_BOOKMARKS = 'CREATE TABLE IF NOT EXISTS bookmarks (
                              id SERIAL PRIMARY KEY,
                              url VARCHAR(1000) NOT NULL,
                              title VARCHAR(100) NOT NULL UNIQUE
                              )'
  CREATE_TABLE_USERS = 'CREATE TABLE IF NOT EXISTS users (
                              id SERIAL PRIMARY KEY,
                              email VARCHAR(100) NOT NULL UNIQUE,
                              password VARCHAR(100) NOT NULL
                              )'
  CREATE_TABLE_BOOKMARK_TAGS = 'CREATE TABLE IF NOT EXISTS bookmarks_tags (
                              bt_id SERIAL PRIMARY KEY,
                              bm_id int REFERENCES bookmarks (id),
                              tg_id int REFERENCES tags (id)
                              )'
  CREATE_TABLE_TAGS = 'CREATE TABLE IF NOT EXISTS tags (
                              id SERIAL PRIMARY KEY,
                              content VARCHAR(250) NOT NULL
                              )'
  CREATE_TABLE_COMMENTS = 'CREATE TABLE IF NOT EXISTS comments (
                              id SERIAL PRIMARY KEY,
                              text VARCHAR(240) NOT NULL,
                              bookmark_id INTEGER REFERENCES bookmarks (id) ON DELETE CASCADE,
                              created_at TIMESTAMP DEFAULT now()
                              )'
  TRUNCATE_TABLES = 'TRUNCATE users, comments, tags, bookmarks_tags, bookmarks'


  INSERT_USERS_EML_PSWD_RETURN = 'INSERT INTO users (email, password)
                                                VALUES ($1, $2)
                                            RETURNING
                                                id, email'

  INSERT_BKMARKS_URL_TTL_RETURN = 'INSERT INTO bookmarks (url, title)
                                                VALUES ($1, $2)
                                            RETURNING
                                                id, url, title'

  SELECT_JOIN_TAG_ID = "SELECT
                          tags.id, content
                       FROM
                          bookmarks_tags
                       INNER JOIN tags
                       ON tags.id = bookmarks_tags.tg_id
                       WHERE
                          bookmarks_tags.bm_id = $1"

  UPDATE_BKMARKS_TTL_URL_ID = 'UPDATE
                                bookmarks
                            SET
                                Title = $3,
                                url = $2
                            WHERE
                                id = $1'
end
