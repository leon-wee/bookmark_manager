require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
require_relative 'controllers/init'


class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  set :session_secret, 'super secret'
  set :views, proc { File.join(root, '..', 'views') }
  use Rack::MethodOverride

end