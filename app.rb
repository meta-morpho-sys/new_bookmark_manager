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

  run! if app_file == $PROGRAM_NAME
end
