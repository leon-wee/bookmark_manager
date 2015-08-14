require_relative '../../app/models/tag'

feature 'Adding tags' do

  scenario 'I can add multiple tags to a new link' do
    user = build(:user)
    sign_up(user)
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    # our tags will be space separated
    fill_in 'tags',  with: 'education ruby'
    click_button 'Create Link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end

  scenario 'Page should refresh if no tags were put' do
    user = build(:user)
    sign_up(user)
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    # our tags will be space separated
    fill_in 'tags',  with: ''
    click_button 'Create Link'
    expect(current_path).to eq '/links/new'
  end

end