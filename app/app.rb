require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require_relative 'helpers/app_helper'
require_relative 'controllers/base'
Dir[__dir__ + '/controllers/*.rb'].each(&method(:require))
require_relative '../lib/send_reset_email'

include BookmarkManager::Models

module BookmarkManager
  class MyApp < Sinatra::Base
    use Routes::Homepage
    use Routes::Links
    use Routes::Sessions
    use Routes::Tags
    use Routes::Users
    use Routes::Passwords
  end
end
