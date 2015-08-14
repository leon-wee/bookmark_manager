module BookmarkManager
  module Routes
    class Base < Sinatra::Base
      enable :sessions
      register Sinatra::Flash
      set :session_secret, 'super secret'
      set :views, proc { File.join(root, '..', 'views') }
      use Rack::MethodOverride
      include ApplicationHelpers
    end
  end
end