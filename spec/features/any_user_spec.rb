require 'rails_helper'

# ActiveRecord::Base.connection_config - gives db info
# Rails.application.load_seed - ruby to load seed data into test db
# rake db:seed RAILS_ENV=test - load seed data into test db via command line

# Need to load seed or StaticPages breaks it
# Doesn't check all users, assumes a logged out user is counts as any user.

describe 'As any user' do

  context 'Home Page' do
    specify 'I can view the home page when I open the site' do
      visit '/'
      within(:css, '.twitter-timeline') {expect(page).to have_content 'Tweets'}
    end

    specify 'I can see FYN\'s tweets' do
      visit '/'
      within(:css, '.twitter-timeline') {expect(page).to have_content 'Tweets'}
    end
  end

  context 'Navigating the site' do
    # Only tests links for the home page
    specify 'I can navigate the home page' do
      # Home Link
      visit '/'
      click_link 'Home'
      expect(page.current_url.split('com')[1]).to eq '/'
    end

    specify 'I can navigate to the degree search page' do
      # Degrees Link
      visit '/'
      click_link 'Degrees'
      expect(page.current_url.split('com')[1]).to eq '/degree_search'
    end

    specify 'I can navigate to the courses index' do
      # Search Link
      visit '/'
      click_button 'Search'
      expect(page.current_url.split('com')[1]).to eq '/courses?utf8=%E2%9C%93&subject=&location='
    end

    specify 'I can navigate to the advanced search page' do
      # Advanced Search Link
      visit '/'
      click_link 'Advanced Search'
      expect(page.current_url.split('com')[1]).to eq '/degree_search/advanced'
    end

    specify 'I can navigate to the conference page' do
      # Conference Link
      visit '/'
      click_link 'Conference'
      expect(page.current_url.split('com')[1]).to eq '/about/conference'
    end

    specify 'I can navigate to the about page' do
      # About Link
      visit '/'
      click_link 'About'
      expect(page.current_url.split('com')[1]).to eq '/about'
    end

    specify 'I can navigate to the constitution page' do
      # Constitution Link
      visit '/'
      click_link 'Constitution'
      expect(page.current_url.split('com')[1]).to eq '/about/constitution'
    end

    specify 'I can navigate to the blogs page' do
      # Blogs Link
      visit '/'
      click_link 'Blog'
      expect(page.current_url.split('com')[1]).to eq '/blogs'
    end

    specify 'I can naviate to the members page' do
      # Members Link
      visit '/'
      click_link 'Members'
      expect(page.current_url.split('com')[1]).to eq '/members'
    end

    specify 'I can naviate to the get involved page' do
      # Get Involved Link
      visit '/'
      click_link 'Get Involved'
      expect(page.current_url.split('com')[1]).to eq '/about/get_involved'
    end

    specify 'I can navigate to the contact page' do
      # Contact Us Link
      visit '/'
      click_link 'Contact Us'
      expect(page.current_url.split('com')[1]).to eq '/about/contact'
    end

    specify 'I can navigate to the privacy policy page' do
      # Privacy Policy Link
      visit '/'
      click_link 'Privacy Policy'
      expect(page.current_url.split('com')[1]).to eq '/about/privacy_policy'
    end

    specify 'I can navigate to the help page' do
      # Help Link
      visit '/'
      click_link 'Help'
      expect(page.current_url.split('com')[1]).to eq '/about/help'
    end

    specify 'I can navigate to the login page' do
      # Login Link
      visit '/'
      click_link 'Login'
      expect(page.current_url.split('com')[1]).to eq '/login'
    end
  end
end
