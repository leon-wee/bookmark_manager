require 'sinatra/base'
require 'sinatra/flash'
require_relative './data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  set :session_secret, 'super secret'
  set :views, proc { File.join(root, '..', 'app', 'views') }
  use Rack::MethodOverride

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    tags_list = params[:tags].split
    redirect '/links/new' if tags_list.empty?
    tags_list.each do |each_tag|
      tag = Tag.create(name: each_tag)
      link.tags << tag
    end
    link.save
    redirect '/links'
  end

  get '/links/new' do
    erb :'links/form'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = ['goodbye!']
      redirect '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  delete '/sessions' do
    session.clear
    flash[:notice] = ['goodbye!']
    redirect '/links'
  end

  helpers do
    def current_user
      User.get(session[:user_id])
    end
  end

  def input_tags?
    @tags_shit.split(" ").length > 1
  end


end