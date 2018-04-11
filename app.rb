# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './models/bookmark'
require './models/comment'
require './db_connection_setup.rb'

# Controller
class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/bookmarks/new' do
    begin
      bookmark = Bookmark.create(params[:url], params[:title])
      flash[:notice] = 'You must submit a valid URL.' unless bookmark
    rescue PG::UniqueViolation
      flash[:notice] = 'That title is already taken, choose another.'
    rescue StandardError
      flash[:notice] = 'Something went wrong with the database. \
                        This sometimes happens, please try again.'
    end
    redirect '/bookmarks'
  end

  delete '/bookmarks/delete' do
    Bookmark.delete(params[:id])
    flash[:notice] = "Bookmark '#{params[:title]}' was successfully deleted!"
    redirect '/bookmarks'
  end

  get '/bookmarks/edit' do
    @bookmark = Bookmark.find(params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/update' do
    begin
      bookmark = Bookmark.update(params[:id], params['new_url'], params['new_title'])
      flash[:notice] = 'You must submit a valid URL' unless bookmark
    rescue PG::UniqueViolation
      flash[:notice] = 'That title is already taken, choose another.'
    rescue StandardError
      flash[:notice] = 'Something went wrong with the database. \
                        This sometimes happens, please try again.'
    end
    redirect '/'
  end

  get '/bookmarks/comments' do
    @bookmark = Bookmark.find(params[:id])
    erb :'comments/new'
  end

  post '/bookmarks/comments/new' do
    Comment.create(params[:text], params[:id])
    redirect '/'
  end

  get '/bookmark/comments' do
    @bookmark = Bookmark.find(params[:id])
    @comments = @bookmark.comments
    erb :'comments/view'
  end

  get '/bookmarks/tags' do
    @bookmark = Bookmark.find(params[:id])
    erb :'tags/new'
  end

  run! if app_file == $PROGRAM_NAME
end
