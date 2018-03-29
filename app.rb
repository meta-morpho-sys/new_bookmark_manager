# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './models/link'
require './database_connection_setup.rb'

# Controller
class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @links = Link.all
    erb :index
  end

  post '/create-a-new-link' do
    if params['url'].match?(/\A#{URI.regexp(%w[http https])}\z/)
      Link.create(url: params['url'])
    else
      flash[:notice] = 'You must submit a valid URL'
    end
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
