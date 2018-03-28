# frozen_string_literal: true

require './lib/database_connection'

task :test_database_setup do
  p 'Setting up test database.....'
  DatabaseConnection.setup 'new_bookmark_manager_test'
  DatabaseConnection.query('TRUNCATE links')

  def insert(num, url)
    DatabaseConnection.query("INSERT INTO links VALUES(#{num}, '#{url}')")
  end

  insert(1, 'https://online.lloydsbank.co.uk')
  insert(2, 'https://www.borrowmydoggy.com/search/dogs')
  insert(3, 'http://vogliadicucina.blogspot.co.uk')
end

task :create_databases do
  puts "Looking for existing databases...\n\n"
  db_names = %w[new_bookmark_manager new_bookmark_manager_test]

  db_names.each do |db_name|
    create_if_needed(db_name)
    connection = PG.connect(dbname: db_name)
    connection.exec('CREATE TABLE IF NOT EXISTS links (id SERIAL PRIMARY KEY,
                    url varchar(60))')
  end
end

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
