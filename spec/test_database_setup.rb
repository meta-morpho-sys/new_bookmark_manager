# frozen_string_literal: true

p 'Setting up test database.....'

require 'pg'

connection = PG.connect(dbname: 'new_bookmark_manager_test')

connection.exec("TRUNCATE links;")

connection.exec("INSERT INTO links VALUES(1, 'https://online.lloydsbank.co.uk');")
connection.exec("INSERT INTO links VALUES(2, 'https://www.borrowmydoggy.com/search/dogs');")
connection.exec("INSERT INTO links VALUES(3, 'http://vogliadicucina.blogspot.co.uk');")




