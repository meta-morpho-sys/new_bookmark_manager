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
    flash[:notice] = 'You must submit a valid URL' unless Link.create(params['url'])
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
