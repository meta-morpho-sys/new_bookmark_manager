# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './models/link'
require './db_connection_setup.rb'

# Controller
class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @links = Link.all
    erb :index
  end

  post '/create-new-link' do
    link = Link.create(params['url'], params['title'])
    flash[:notice] = 'You must submit a valid URL' unless link
    redirect '/'
  end

  post '/delete_link' do
    connection = PG.connect(dbname: 'new_bookmark_manager_test')
    connection.exec("DELETE FROM links WHERE id = #{params['id']}")
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
