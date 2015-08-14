module BookmarkManager
  module Routes
    class Homepage < Base
      get '/' do
        redirect '/links'
      end
    end
  end
end
