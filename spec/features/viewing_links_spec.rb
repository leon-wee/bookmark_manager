require 'spec_helper'

feature 'Viewing links' do
  # let(:link) { build(:link, tags: [create(:tag, name: 'bubbles')]) }
  # let(:link2) { build(:link, title: 'Bubble Bobble', tags: [create(:tag, name: 'bubbles')]) }

  before(:each) do

    # p attempt
    # bubbles_tag = build(:tag, name: 'bubbles')
    # p '------------------------'
    tag = create(:tag, name: 'bubbles')
    #create(:link, tags: [create(:tag, name: 'bubbles')])
    create(:link, tags: [tag])
    create(:link, title: 'Bubble Bobble', tags: [tag])
    # create(:link, title: 'Bubble Bobble', tags: [create(:tag, name: 'bubbles')])
    # p '------------------------'

    # create(:link, tags: bubble_tags)
    # Link.create(url: 'http://www.makersacademy.com',
    #             title: 'Makers Academy',
    #             tags: [Tag.first_or_create(name: 'education')])
    # Link.create(url: 'http://www.google.com',
    #             title: 'Google',
    #             tags: [Tag.first_or_create(name: 'search')])
    # Link.create(url: 'http://www.zombo.com'
    #             title: 'This is Zombocom',
    #             tags: [Tag.first_or_create(name: 'bubbles')])
    # Link.create(url: 'http://www.bubble-bobble.com',
    #             title: 'Bubble Bobble',
    #             tags: [Tag.first_or_create(name: 'bubbles')])
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