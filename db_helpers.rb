# frozen_string_literal: true

def create_if_needed(db_name)
  if db_exists?(db_name)
    puts "NOTICE:  database \"#{db_name}\" already exists, skipping...\n\n"
  else
    conn = PG.connect
    conn.exec("CREATE DATABASE #{db_name}")
    p "Creating DB: #{db_name}"
  end
end

def db_exists?(db_name)
  conn = PG.connect
  res = conn.exec(
    "SELECT count(*) FROM pg_database WHERE datname ='#{db_name}'"
  )
  res[0]['count'] == '1'
end
