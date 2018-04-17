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

end
