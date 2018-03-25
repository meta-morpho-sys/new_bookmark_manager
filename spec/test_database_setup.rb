# frozen_string_literal: true

p 'Setting up test database.....'

require 'pg'

connection = PG.connect(dbname: 'new_bookmark_manager_test')

connection.exec('TRUNCATE links;')

sql = 'INSERT INTO links VALUES'
connection.exec("#{sql}""(1, 'https://online.lloydsbank.co.uk');")
connection.exec("#{sql}""(2, 'https://www.borrowmydoggy.com/search/dogs');")
connection.exec("#{sql}""(3, 'http://vogliadicucina.blogspot.co.uk');")
