# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './models/link'
require './models/comment'
require './db_connection_setup.rb'

# Controller
class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links/new' do
    begin
      link = Link.create(params['url'], params['title'])
      flash[:notice] = 'You must submit a valid URL.' unless link
    rescue PG::UniqueViolation
      flash[:notice] = 'That title is already taken, choose another.'
    rescue StandardError
      flash[:notice] = 'Something went wrong with the database. \
                        This sometimes happens, please try again.'
    end
    redirect '/links'
  end

  post '/links/delete' do
    Link.delete(params['id'])
    flash[:notice] = "Link #{params['title']} was successfully deleted!"
    redirect '/links'
  end

  get '/links/edit' do
    @link = Link.find(params['id'])
    erb :'links/edit'
  end

  post '/links/update' do
    begin
      link = Link.update(params['id'], params['new_url'], params['new_title'])
      flash[:notice] = 'You must submit a valid URL' unless link
    rescue PG::UniqueViolation
      flash[:notice] = 'That title is already taken, choose another.'
    rescue StandardError
      flash[:notice] = 'Something went wrong with the database. \
                        This sometimes happens, please try again.'
    end
    redirect '/'
  end

  get '/links/comments' do
    @comments = Comment.all
    erb :'comments/index'
  end
  run! if app_file == $PROGRAM_NAME
end
