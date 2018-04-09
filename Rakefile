# frozen_string_literal: true

require './lib/db_connector'
require_relative 'db_helpers'

task :test_database_setup do
  puts 'Cleaning database...'
  DbConnector.setup 'new_bookmark_manager_test'
  DbConnector.query('TRUNCATE comments, bookmarks')
end

task :create_databases do
  puts "Looking for existing databases...\n\n"
  db_names = %w[new_bookmark_manager new_bookmark_manager_test]

  db_names.each do |db_name|
    create_if_needed(db_name)
    connection = PG.connect(dbname: db_name)
    connection.exec('CREATE TABLE IF NOT EXISTS bookmarks (
                              id SERIAL PRIMARY KEY,
                              url VARCHAR(1000) NOT NULL,
                              title VARCHAR(100) NOT NULL UNIQUE
                              )')
    connection.exec('CREATE TABLE IF NOT EXISTS comments (
                              id SERIAL PRIMARY KEY,
                              text VARCHAR(240) NOT NULL,
                              bookmark_id INTEGER REFERENCES bookmarks (id) ON DELETE CASCADE
                              created_at TIMESTAMP DEFAULT now()
                              )')
  end
end


task :teardown do
  puts "Tearing down databases...\n\n"
  db_names = %w[new_bookmark_manager new_bookmark_manager_test]

  db_names.each do |db_name|
    connection = PG.connect(dbname: db_name)
    connection.exec("DROP DATABASE #{db_name}")
  end
end
