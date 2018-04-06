# frozen_string_literal: true

def create_if_needed(db_name)
  if db_exists?(db_name)
    puts "NOTICE:  database \"#{db_name}\" already exists, skipping"
  else
    connection.exec("CREATE DATABASE #{db_name}")
  end
end

def db_exists?(db_name)
  conn = PG.connect
  res = conn.exec(
      "SELECT count(*) FROM pg_database WHERE datname ='#{db_name}'"
  )
  res.cmd_tuples == 1
end

def insert_link(num, url, title)
  DbConnector.query("INSERT INTO links VALUES(#{num}, '#{url}', '#{title}')")
end

def insert_comment(num, text, link_id)
  DbConnector.query("INSERT INTO comments VALUES(#{num},'#{text}',#{link_id})")
end
