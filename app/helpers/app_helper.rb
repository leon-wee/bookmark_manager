module ApplicationHelpers

  def current_user
    User.get(session[:user_id])
  end

  def rand_token
    [*'A'..'Z'].shuffle.join
  end

end