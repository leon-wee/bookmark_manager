require 'spec_helper'

feature 'Viewing links' do
  before(:each) do
    # user = build(:user)
    # sign_up(user)
    # tag = create(:tag, name: 'bubbles')
    # link1 = create(:link, tags: [tag])
    # user.links << link1
    # user.save
    # link2 = create(:link, title: 'Bubble Bobble', tags: [tag])
    # user.links << link2
    # user.save
  end

  scenario 'home page should redirect to links page' do
    visit '/'
    expect(current_path).to eq('/links')
  end

  scenario 'I can see existing links on the links page' do
    user = build(:user)
    sign_up(user)
    visit '/links/new'
    fill_in('url', with: 'http://www.makersacademy.com')
    fill_in('title', with: 'Makers Academy')
    fill_in('tags', with: 'education')
    click_button('Create Link')
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end

  scenario 'I can filter links by tag' do
    tag = create(:tag,name: 'bubbles')
    user = build(:user)
    sign_up(user)
    create(:link, url: 'http://www.zombocom.com', title: 'This is Zombocom', tags: [tag])
    create(:link, url: 'http://www.bubblebobble.com', title: 'Bubble Bobble', tags: [tag])
    visit '/tags/bubbles'
    within 'ul#links' do
      expect(page).not_to have_content('Makers Academy')
      expect(page).not_to have_content('Code.org')
      expect(page).to have_content('This is Zombocom')
      expect(page).to have_content('Bubble Bobble')
    end
  end

end