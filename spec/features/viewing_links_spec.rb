require 'spec_helper'

feature 'Viewing links' do
  before(:each) do
    tag = create(:tag, name: 'bubbles')
    create(:link, tags: [tag])
    create(:link, title: 'Bubble Bobble', tags: [tag])
  end

  scenario 'home page should redirect to links page' do
    visit '/'
    expect(current_path).to eq('/links')
  end

  scenario 'I can see existing links on the links page' do
    create(:link, url: 'http://www.makersacademy.com/', title: 'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end

  scenario 'I can filter links by tag' do
    visit '/tags/bubbles'
    within 'ul#links' do
      expect(page).not_to have_content('Makers Academy')
      expect(page).not_to have_content('Code.org')
      expect(page).to have_content('This is Zombocom')
      expect(page).to have_content('Bubble Bobble')
    end
  end

end