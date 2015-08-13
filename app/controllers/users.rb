class BookmarkManager < Sinatra::Base

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = ['goodbye!']
      redirect '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/users/password_reset' do
    erb :'users/reset'
  end

  post '/users/password_reset' do
    user = User.first(email: params[:Email])
    user.update(password_token: rand_token)
    SendResetEmail.call(user)
    flash[:notice] = 'Check your emails'
  end

  get '/users/password_reset/:token' do
    erb :'users/change_password'
  end


end