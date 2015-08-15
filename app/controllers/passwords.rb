module BookmarkManager
  module Routes
    class Passwords < Base
      get '/users/password_reset' do
        erb :'users/reset'
      end

      post '/users/password_reset' do
        user = User.first(email: params[:Email])
        user.update(password_token: rand_token)
        SendResetEmail.call(user)
        flash[:notice] = 'Check your emails'
      end

      get "/users/password_reset/:token" do
        session[:token] = params[:token]
        erb :'users/change_password'
      end

      post "/users/password_reset_status" do
        user = User.first(password_token: session[:token])
        if user.update(password: params[:new_password],
                       password_confirmation: params[:password_confirmation],
                       password_token: nil)
          session[:user_id] = user.id
          redirect '/'
        else
          flash[:errors] = user.errors.full_messages
        end
      end
    end
  end
end