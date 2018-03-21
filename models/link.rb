require 'pg'

# Connects to the DB. Makes queries to fetch the links from the DB
class Link
  def self.all
    connection = PG.connect(dbname: 'new_bookmark_manager')
    result = connection.exec('SELECT * FROM links')
    result.map { |link| link['url'] }

  end
end
