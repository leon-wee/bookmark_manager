feature 'User sign up' do

  # Strictly speaking, the tests that check the UI
  # (have_content, etc.) should be separate from the tests
  # that check what we have in the DB since these are separate concerns
  # and we should only test one concern at a time.

  # However, we are currently driving everything through
  # feature tests and we want to keep this example simple.

  scenario 'I can sign up as a new user' do
    user = User.new(user_params)
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, #{user.email}")
    expect(user.email).to eq("#{user.email}")
  end

  scenario 'requires a matching confirmation password' do
    user = User.new(user_params_unmatched_password)
    expect { sign_up(user) }.not_to change(User, :count)
  end

  scenario 'with a password that does not match' do
    user = User.new(user_params_unmatched_password)
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'require\'s user to input an email' do
    user = User.new(user_params_no_email)
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Please fill in your email'
  end

  def sign_up(user)
    visit '/users/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end

  def sign_up(user)
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email,    with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end

  def user_params
     { email: 'ucl@example.com',
       password: 'orange!',
       password_confirmation: 'orange!' }
  end

  def user_params_unmatched_password
    { email: 'ucl@example.com',
      password: 'orange!',
      password_confirmation: 'wrong' }
  end

  def user_params_no_email
    { email: '',
      password: 'orange!',
      password_confirmation: 'wrong' }
  end

end