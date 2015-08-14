feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    user = build :user
    expect { sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, #{user.email}")
    expect(user.email).to eq("#{user.email}")
  end

  scenario 'requires a matching confirmation password' do
    user = build(:user, password_confirmation: 'wrong')
    expect { sign_up(user) }.not_to change(User, :count)
  end

  scenario 'with a password that does not match' do
    user = build(:user, password_confirmation: 'wrong')
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users') # current_path is a helper provided by Capybara
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'require\'s user to input an email' do
    user = build(:user, email: '')
    expect { sign_up(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
  end

  scenario 'I cannot sign up with an existing email' do
    user = build(:user)
    sign_up(user)
    expect { sign_up(user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end
end

feature 'User sign in' do
  scenario 'with correct credentials' do
    user = create(:user)
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content "Welcome, #{user.email}"
  end
end

feature 'User signs out' do
  scenario 'while being signed in' do
    @user = create(:user)
    sign_in(email: @user.email, password: @user.password)
    click_button 'Sign out'
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content("Welcome, #{@user.email}")
  end
end
