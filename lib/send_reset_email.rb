require 'rest-client'

class SendResetEmail

  API_KEY = ENV['API_KEY']

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def self.call(user)
    RestClient.post "https://api:#{API_KEY}"\
    "@api.mailgun.net/v3/sandboxff8aca0bc0f34b9d9634d15a22e76460.mailgun.org/messages",
    :from => "Mailgun Sandbox <postmaster@sandboxff8aca0bc0f34b9d9634d15a22e76460.mailgun.org>",
    :to => "#{user.email}",
    :subject => "Password reset",
    :text => "Dear #{user.email},
    Please click this link to reset your password:
    http://localhost:9292/users/password_reset/#{user.password_token}

    Bookmark Manager"
  end


end