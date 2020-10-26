require 'rails_helper'

# ActiveRecord::Base.connection_config - gives db info
# Rails.application.load_seed - ruby to load seed data into test db
# rake db:seed RAILS_ENV=test - load seed data into test db via command line

# Need to load seed
# Doesn't check all users, assumes a logged out user is counts as any user.

describe 'As a University Admin' do
  def login_as(username)
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: username
    fill_in 'Password', with: 'Password123'
    click_button 'Log in'
  end


  specify 'I can view the blogs page when I navigate to it' do
    login_as('AMorgan@test1.ac.uk')
    visit '/blogs'
    within(:css, '.page-header') { expect(page).to have_content 'Blogs' }
  end

  specify 'I can see member only blogs when signed in' do
    login_as('AMorgan@test1.ac.uk')
    visit '/blogs'
    within(:css, '#wrap') { expect(page).to have_content 'Member Only Blog' }
  end

  specify 'I can edit a blog posted by a member of my institution', js: true do
    login_as('AMorgan@test1.ac.uk')
    visit '/blogs'
    within(:css, '#wrap') { expect(page).to have_content 'Member Only Blog' }
    click_link 'View Post'
    within(:css, '#wrap') { expect(page).to have_content 'Edit' }
    click_button 'Edit'
    text = 'Blog Edited'
    within(:css, '.modal-content') {
    page.execute_script %{ $('#blog_content').data("wysihtml5").editor.setValue('#{text}') }}
    within(:css, '.modal-body') {  click_button 'Update Blog' }
    wait_for_ajax
    within(:css, '#wrap') {expect(page).to have_content 'Blog Edited' }
  end

  specify 'I cannot edit a blog posted by a member not from my institution' do
    login_as('JMilton@test2.ac.uk')
      visit '/blogs'
      within(:css, '#wrap') { expect(page).to have_content 'Member Only Blog' }
      click_link 'View Post'
      within(:css, '#wrap') { expect(page).to have_no_content 'Edit' }
  end

  specify 'I can delete blogs posted by a member of my institution', js: true do
    login_as('AMorgan@test1.ac.uk')
    visit '/blogs'
    within(:css, '#wrap') { expect(page).to have_content 'Member Only Blog' }
    click_link 'View Post'
    accept_confirm do
      click_link 'Delete Post'
    end
    within(:css, '.flash-messages') {expect(page).to have_content 'Blog was successfully deleted' }
    within(:css, '#wrap') {expect(page).to have_no_content 'a New Blog' }
  end

  specify 'I cannot delete blogs posted by a member not from my institution' do
    login_as('JMilton@test2.ac.uk')
    visit '/blogs'
    within(:css, '#wrap') { expect(page).to have_content 'Member Only Blog' }
    click_link 'View Post'
    within(:css, '#wrap') { expect(page).to have_no_content 'Delete Post' }
  end
end
