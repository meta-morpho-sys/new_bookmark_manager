# frozen_string_literal: true

require './lib/database_connection'

task :test_database_setup do
  p 'Setting up test database.....'
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
  p 'Looking for existing databases...'; puts
  databases = %w[new_bookmark_manager new_bookmark_manager_test]
  databases.each do |database|
    connection = PG.connect
    connection.exec(db_exists?(database))
    connection = PG.connect(dbname: database)
    connection.exec('CREATE TABLE IF NOT EXISTS links (id SERIAL PRIMARY KEY, url varchar(60));')
  end
end

private

def db_exists?(database)
  "DO
      $do$
      BEGIN
        IF EXISTS (SELECT 1 FROM pg_database WHERE datname = '#{database}')
        THEN
          RAISE NOTICE 'database #{database} already exists, skipping';
         ELSE
          PERFORM dblink_exec('dbname=' || current_database() -- current db
          , 'CREATE DATABASE #{database}');
        END IF;
      END
      $do$;"
end
