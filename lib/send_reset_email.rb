class SendResetEmail

  attr_reader :client_email

  def initialize(user, client_email)
    @user = user
    @client_email = client_email
  end

  def self.call(user)
  end
end