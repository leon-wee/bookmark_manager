module BookmarkManager
  module Routes
    class Links < Base
      get '/links' do
        @links = Link.all
        erb :'links/index'
      end

      post '/links' do
        link = Link.new(url: params[:url], title: params[:title])
        tags_list = params[:tags].split
        redirect '/links/new' if tags_list.empty?
        tags_list.each { |each_tag| link.tags << Tag.create(name: each_tag) }
        link.save
        redirect '/links'
      end

      get '/links/new' do
        erb :'links/form'
      end
    end
  end
end