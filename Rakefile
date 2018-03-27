# frozen_string_literal: true

require './lib/database_connection'

p 'Setting up test database.....'
task :test_database_setup do
  DatabaseConnection.setup 'new_bookmark_manager_test'

  DatabaseConnection.query('TRUNCATE links;')

  def insert(num, url)
    DatabaseConnection.query("INSERT INTO links VALUES(#{num}, '#{url}');")
  end

  insert(1, 'https://online.lloydsbank.co.uk')
  insert(2, 'https://www.borrowmydoggy.com/search/dogs')
  insert(3, 'http://vogliadicucina.blogspot.co.uk')
end

task :create_databases do
  p 'Creating up database'
  databases = %w[new_bookmark_manager new_bookmark_manager_test]

  databases.each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{database};")
    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE links (id SERIAL PRIMARY KEY, 'url' varchar(60));")
  end
end

