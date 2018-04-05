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
    begin
      link = Link.create(params['url'], params['title'])
      flash[:notice] = 'You must submit a valid URL.' unless link
    rescue PG::UniqueViolation
      flash[:notice] = 'That title is already taken, choose another.'
    rescue StandardError
      flash[:notice] = 'Something went wrong with the database. \
                        This sometimes happens, please try again.'
    end
    redirect '/'
  end

  post '/delete_link' do
    Link.delete(params['id'])
    flash[:notice] = "Link #{params['title']} was successfully deleted!"
    redirect '/'
  end

  get '/update_link' do
    @link = Link.find(params['id'])
    erb :update_link
  end

  post '/update_link' do
    link = Link.update(params['id'], params['new_url'], params['new_title'])
    flash[:notice] = 'You must submit a valid URL' unless link
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
