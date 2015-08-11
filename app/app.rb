require 'sinatra/base'
require_relative '../data_mapper_setup'

class BookmarkManager < Sinatra::Base

  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    'Hello Shit!'
  end

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

  def input_tags?
    @tags_shit.split(" ").length > 1
  end


end