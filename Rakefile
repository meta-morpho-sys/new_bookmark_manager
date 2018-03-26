# frozen_string_literal: true

p 'Setting up test database.....'

require './lib/database_connection'

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
