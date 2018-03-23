# frozen_string_literal: true

require 'sinatra/base'
require './models/link'

# Controller
class BookmarkManager < Sinatra::Base
  enable :sessions

  get '/' do
    @links = Link.all
    erb :index
  end

  get '/add-a-new-link' do
    erb :new
  end

  post '/create-a-new-link' do
    url = params['url']
    @links = Link.create url
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
