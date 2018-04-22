# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require './models/user'
require './models/bookmark'
require './models/comment'
require './models/tag'
require './models/bookmark_tag'
require './db_connection_setup.rb'
# require './lib/message_strings'

# Controller
class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(20) }
  register Sinatra::Flash

  get '/' do
    erb :home
  end

  # <editor-fold desc="Sessions">
  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect "/user/#{user.id}/bookmarks"
    else
      flash[:notice] = 'You must have entered a wrong email or password!'
      redirect '/sessions/new'
    end
  end

  post '/user/:id/sessions/destroy' do
    session.clear
    flash[:notice] = 'You successfully signed out'
    redirect '/'
  end
  # </editor-fold>

  # <editor-fold desc="Users">
  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    begin
      user = User.create(params[:email], params[:password])
      session[:user_id] = user.id
    rescue PG::UniqueViolation
      flash[:notice] = 'This address is already used, choose another.'
      redirect '/users/new'
    end

    redirect "/user/#{user.id}/bookmarks"
  end
  # </editor-fold>

  # <editor-fold desc="Bookmarks">
  get '/user/:id/bookmarks' do
    @user = User.find(session[:user_id])
    @bookmarks = @user.bookmarks
    erb :'bookmarks/index'
  end

  post '/bookmarks/new' do
    begin
      user = User.find(session[:user_id])
      bookmark = Bookmark.create(params[:url], params[:title], session[:user_id])
      flash[:notice] = MessageStrings::VALID_URL unless bookmark
    rescue PG::UniqueViolation
      flash[:notice] = MessageStrings::DUPLICATE_TITLE
    rescue StandardError
      flash[:notice] = MessageStrings::GENERIC_DB_ERROR
    end
    redirect "/user/#{user.id}/bookmarks"
  end

  delete '/bookmarks/:id/delete' do
    user = User.find(session[:user_id])
    Bookmark.delete(params[:id])
    flash[:notice] = MessageStrings::BKMARK_DELETED.call(params[:title])
    redirect "/user/#{user.id}/bookmarks"
  end

  get '/bookmarks/:id/edit' do
    @user = User.find(session[:user_id])
    @bookmark = Bookmark.find(params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id/update' do
    begin
      bookmark = Bookmark.update(params[:id], params['new_url'], params['new_title'])
      user = User.find(session[:user_id])
      flash[:notice] = 'You must submit a valid URL' unless bookmark
    rescue PG::UniqueViolation
      flash[:notice] = 'That title is already taken, choose another.'
    rescue StandardError
      flash[:notice] = GENERIC_DB_ERROR
    end
    redirect "/user/#{user.id}/bookmarks"
  end
  # </editor-fold>

  # <editor-fold desc="Comments">
  get '/bookmarks/:id/comments' do
    @bookmark = Bookmark.find(params[:id])
    @user = User.find(session[:user_id])
    erb :'comments/new'
  end

  post '/bookmarks/comments/new' do
    user = User.find(session[:user_id])
    Comment.create(params[:text], params[:id])
    redirect "/user/#{user.id}/bookmarks"
  end

  get '/bookmark/:id/comments/view' do
    @user = User.find(session[:user_id])
    @bookmark = Bookmark.find(params[:id])
    @comments = @bookmark.comments
    erb :'comments/view'
  end
  # </editor-fold>

  # <editor-fold desc="Tags">
  get '/bookmarks/:id/tags' do
    @user = User.find(session[:user_id])
    @bookmark = Bookmark.find(params[:id])
    erb :'tags/new'
  end

  post '/bookmarks/tags/new' do
    begin
      user = User.find(session[:user_id])
      tag = Tag.create(params[:content])
      BookmarkTag.create(params[:id], tag.id)
      flash[:notice] = "'#{params[:content]}' tag successfully created"
    rescue PG::UniqueViolation
      fetched_tag = Tag.fetch_existing_tag(params[:content])
      BookmarkTag.create(params[:id], fetched_tag.id)
      flash[:notice] = "'#{params[:content]}' tag successfully assigned"
    end
    redirect "/user/#{user.id}/bookmarks"
  end

  get '/tags/:id/bookmarks' do
    @user = User.find(session[:user_id])
    @bookmarks = Tag.find(params[:id]).bookmarks
    erb :'tags/bookmarks/index'
  end
  # </editor-fold>

  run! if app_file == $PROGRAM_NAME
end
