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

  post '/create-a-new-link' do
    @links = Link.create params['url']
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
