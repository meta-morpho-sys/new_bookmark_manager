# frozen_string_literal: true

def create_if_needed(db_name)
  if db_exists?(db_name)
    puts "NOTICE:  database \"#{db_name}\" already exists, skipping"
  else
    conn = PG.connect
    conn.exec("CREATE DATABASE #{db_name}")
  end
end

def db_exists?(db_name)
  conn = PG.connect
  res = conn.exec(
    "SELECT count(*) FROM pg_database WHERE datname ='#{db_name}'"
  )
  res[0]['count'] == 1
end

def insert_bookmark(num, url, title)
  DbConnector.query("INSERT INTO bookmarks
                              VALUES(#{num}, '#{url}', '#{title}')")
end

def insert_comment(num, text, bookmark_id)
  DbConnector.query("INSERT INTO comments VALUES(#{num},'#{text}',#{bookmark_id})")
end
