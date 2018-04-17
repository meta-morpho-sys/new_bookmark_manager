# frozen_string_literal: true

require './lib/db_connector'
require_relative 'db_helpers'
require './lib/sql_strings'

task :test_database_setup do
  puts 'Cleaning database...'
  DbConnector.setup 'new_bookmark_manager_test'
  DbConnector.query(SQLStrings::TRUNCATE_TABLES)
end

task :create_databases do
  puts "Looking for existing databases...\n\n"
  db_names = %w[new_bookmark_manager new_bookmark_manager_test]

  db_names.each do |db_name|
    create_if_needed(db_name)
    connection = PG.connect(dbname: db_name)
    connection.exec(SQLStrings::CREATE_TABLE_BOOKMARKS)
    connection.exec(SQLStrings::CREATE_TABLE_COMMENTS)
    connection.exec(SQLStrings::CREATE_TABLE_TAGS)
    connection.exec(SQLStrings::CREATE_TABLE_BOOKMARK_TAGS)
    connection.exec(SQLStrings::CREATE_TABLE_USERS)
  end
end

task :teardown do
  puts "*** Destroying databases ***.\n\n"
  puts "    Press 'y' to confirm you want to delete the Bookmark Manager database.\n\n"
  puts '*** Attention! All data will be lost! ***'
  print '>>'

  confirm = STDIN.gets.chomp.downcase
  return unless confirm == 'y'

  db_names = %w[new_bookmark_manager new_bookmark_manager_test]

  db_names.each do |db_name|
    connection = PG.connect(dbname: db_name)
    connection.exec("DROP DATABASE #{db_name}")
  end
end
