require 'rails_helper'

# ActiveRecord::Base.connection_config - gives db info
# Rails.application.load_seed - ruby to load seed data into test db
# rake db:seed RAILS_ENV=test - load seed data into test db via command line

# Need to load seed or StaticPages breaks it
# Doesn't check all users, assumes a logged out user is counts as any user.

describe 'As any user' do
  specify 'I can view the blogs page when I navigate to it'  do
    visit '/blogs'
    within(:css, '.page-header') {expect(page).to have_content 'Blogs'}
  end

  specify 'I can see a list of blog posts' do
    visit '/blogs'
    within(:css, '#wrap') {expect(page).to have_content 'View Post'}
  end

  specify 'I can see only public blogs when not logged in' do
    visit '/blogs'
    within(:css, '#wrap') {expect(page).to have_no_content 'Member Only Blog'}
  end

  specify 'I can see a public blog post when not logged in' do
    visit '/blogs'
    within(:css, '#wrap') {expect(page).to have_content 'Z Test Blog'}
    click_link 'View Post'
    within(:css, '#wrap') {expect(page).to have_content 'Test Blog'}
  end

  specify 'I can see files attached public blog post when not logged in' do
    blog = Blog.where(name: 'A Test Blog')
    file_src = File.new(Rails.root.join('spec/assets/test.png'))
    sleep(5)
    blog.update(file: file_src, updated_at: Time.now + 1.hour)
    sleep(1)
    visit '/blogs'
    within(:css, '#wrap') {expect(page).to have_content 'A Test Blog'}
    click_link 'View Post'
    within(:css, '#wrap') {expect(page).to have_content 'A Test Blog'}
    within(:css, '#wrap') {expect(page).to have_css 'img'}
  end

  specify 'I can download files attached public blog post when not logged in' do
    blog = Blog.where(name: 'A Test Blog')
    file_src = File.new(Rails.root.join('app/assets/files/constitution.pdf'))
    sleep(1)
    blog.update(file: file_src, updated_at: Time.now + 1.hour)
    visit '/blogs'
    within(:css, '#wrap') { expect(page).to have_content 'A Test Blog' }
    click_link 'View Post'
    within(:css, '#wrap') { expect(page).to have_css 'object' }
    within(:css, 'object') { click_link 'click here' }
    expect(page.response_headers['Content-Disposition']).to include("filename=\"constitution.pdf\"")
  end

  context 'Sorting the blog list' do
    specify 'I can order the list of blogs by Last Updated' do
      # create different last updated times
      Blog.where(name: 'Z Test Blog').update(updated_at: DateTime.now.midday)
      visit '/blogs'
      page.find('select').all('option')[0].select_option
      page.find('.submit-btn').click
      name = page.all('h3')[1].text
      time1 = page.all('h6')[0].text.split[5]
      time2 = page.all('h6')[1].text.split[5]
      expect(name).to eq 'Z Test Blog'
      expect(time1).to be > time2
    end

    specify 'I can order the list of blogs by Most Recent' do
      # create different most recent times
      visit '/blogs'
      page.find('select').all('option')[1].select_option
      page.find('.submit-btn').click
      sleep(5)
      within(:css, '.page-header') {expect(page).to have_content 'Most Recent'}
      name = page.all('h3')[1].text
      expect(name).to eq 'Z Test Blog'
    end

    specify 'I can order the list of blogs alphabetically ascending' do
      visit '/blogs'
      # asc
      page.find('select').all('option')[2].select_option
      page.find('.submit-btn').click
      name = page.all('h3')[1].text
      expect(name).to eq 'A Test Blog'
    end

    specify 'I can order the list of blogs alphabetically descending' do
      # desc
      visit '/blogs'
      page.find('select').all('option')[3].select_option
      page.find('.submit-btn').click
      name = page.all('h3')[1].text
      expect(name).to eq 'Z Test Blog'
    end
  end
end
