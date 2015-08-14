feature 'Password reset' do
  scenario 'requesting a password reset' do
    user = create(:user)
    visit '/users/password_reset'
    fill_in 'Email', with: user.email
    expect(SendResetEmail).to receive(:call)
    click_button 'Reset password'
    user = User.first(email: user.email)
    expect(user.password_token).not_to be_nil
    expect(page).to have_content 'Check your emails'
  end

  scenario 'resetting password' do
     user = create(:user)
     user.update(password_token: 'token')
     visit "/users/password_reset/#{user.password_token}"
     expect(page.status_code).to eq 200
     expect(page).to have_content 'Enter a new password'
  end

  scenario 'users can change password' do
    user = create(:user)
    user.update(password_token: 'token')
    visit "/users/password_reset/#{user.password_token}"
    fill_in("new password", with: "hello")
    fill_in("password confirmation", with: "hello")
    click_button 'Submit'
    expect(page).to have_content("Welcome, #{user.email}")
    sign_in(email: "#{user.email}", password: "potato")
    expect(page).to have_content("The email or password is incorrect")
  end

  scenario 'users cannot access changing password page without token' do
    visit "/users/password_reset/potato"
    expect(page).not_to have_content('Enter a new password')
  end
end