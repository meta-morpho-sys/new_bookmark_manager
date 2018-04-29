# frozen_string_literal: true

require './lib/db_connector'
require_relative 'db_helpers'
require './lib/sql_strings'

task default: :help

desc 'Displays all existing tasks with description'
task :help do
  sh 'rake -T'
end

namespace :db do
  desc 'Creates the test database and erases the old data before every test run.'
  task :test_db_setup do
    puts 'Cleaning test database...'
    DbConnector.setup 'new_bookmark_manager_test'
    DbConnector.query(SQLStrings::TRUNCATE_TABLES)
  end

  desc 'Creates test and development databases and their relative tables.'
  task :create do
    include SQLStrings

    puts "Looking for existing databases...\n\n"

    db_names = %w[new_bookmark_manager new_bookmark_manager_test]
    sql_constants = [
      CREATE_TABLE_USERS,
      CREATE_TABLE_BOOKMARKS,
      CREATE_TABLE_COMMENTS,
      CREATE_TABLE_TAGS,
      CREATE_TABLE_BOOKMARK_TAGS
    ]

    db_names.each do |db_name|
      create_if_needed(db_name)
      connection = PG.connect(dbname: db_name)
      sql_constants.each do |const|
        connection.exec(const)
      end
    end
  end

  desc 'Drops all existing databases'
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
end


