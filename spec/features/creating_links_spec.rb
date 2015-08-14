feature 'Creating links' do

  scenario 'I can create a new link' do
    user = build(:user)
    sign_up(user)
    visit '/links/new'
    fill_in('url', with: 'http://www.zombo.com/')
    fill_in('title', with: 'This is Zombocom')
    fill_in('tags', with: 'welcome')
    click_button 'Create Link'
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content('This is Zombocom')
    end
  end

  scenario 'I cannot create a new link when not logged in' do
    visit '/links/new'
    fill_in 'url', with: 'http://www.zombo.com/'
    fill_in 'title', with: 'This is Zombocom'
    click_button 'Create Link'
    expect(current_path).to eq '/links'
    expect(page).to have_content('Please sign up or sign in first!')
  end

  scenario 'there are no links in the database at the start of the test' do
    expect(Link.count).to eq 0
  end
end