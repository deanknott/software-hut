require 'rails_helper'

# ActiveRecord::Base.connection_config - gives db info
# Rails.application.load_seed - ruby to load seed data into test db
# rake db:seed RAILS_ENV=test - load seed data into test db via command line


# Doesn't check all users, assumes a logged out user is counts as any user.

describe 'As a registered user'do
  # Before each test, log in as John Smith
  before(:each) do
    login_as('jsmith@test1.ac.uk')
  end

  def login_as(username)
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: username
    fill_in 'Password', with: 'Password123'
    click_button 'Log in'
  end

  def create_new_blog
    visit '/blogs'
    click_link 'New Blog'
    fill_in 'Name', with: 'a New Blog'
    text = 'Blog Created'
    page.execute_script %{ $('#blog_content').data("wysihtml5").editor.setValue('#{text}') }
    within(:css, '.form-actions') { click_button 'Create Blog' }
    wait_for_ajax
    within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }
  end
  specify 'I can view the blogs page when I navigate to it' do
    visit '/blogs'
    within(:css, '.page-header') { expect(page).to have_content 'Blogs' }
  end

  specify ' I can see member only blogs when signed in' do
    visit '/blogs'
    within(:css, '#wrap') { expect(page).to have_content 'Member Only Blog' }
  end

  context ' creating and editing a blog', js: true do
    specify 'I can create a new blog' do
      create_new_blog
    end

    specify 'I can edit my own blogs' do
      create_new_blog
      visit '/blogs'
      within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }
      click_link 'View Post'
      within(:css, '.box') { expect(page).to have_content 'Edit' }
      click_button 'Edit'
      sleep(0.5)
      text = 'Blog Edited'
      within(:css, '.modal-content') {
      page.execute_script %{ $('#blog_content').data("wysihtml5").editor.setValue('#{text}') }}
      within(:css, '.modal-body') {  click_button 'Update Blog' }
      within(:css, '.flash-messages') {expect(page).to have_content 'Updated'}
      within(:css, '#wrap') {expect(page).to have_content 'Blog Edited' }
    end
  end

  context 'File Management', js: true do
    specify 'I can add a file to my own new blog' do
      visit '/blogs'
      click_link 'New Blog'
      fill_in 'Name', with: 'a New Blog'
      text = 'Blog Created'
      page.execute_script %{ $('#blog_content').data("wysihtml5").editor.setValue('#{text}') }
      attach_file('blog_file', File.join(Rails.root, '/spec/assets/test.png'))
      within(:css, '#new_blog') { click_button 'Create Blog' }
      wait_for_ajax
      within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }

      click_link 'View Post'
      within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }
      within(:css, '#wrap') { expect(page).to have_css 'img' }
    end

    specify 'I can add a file to my own existing blog' do
      create_new_blog
      visit '/blogs'
      within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }
      click_link 'View Post'
      within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }
      click_button 'Edit'
      sleep(0.5)
      text = 'Blog Edited'
      within(:css, '.modal-content') {
      page.execute_script %{ $('#blog_content').data("wysihtml5").editor.setValue('#{text}') }}
      attach_file('blog_file', File.join(Rails.root, '/spec/assets/test.png'))
      within(:css, '.modal-body') {  click_button 'Update Blog' }
      within(:css, '.flash-messages') {expect(page).to have_content 'Updated'}
      within(:css, '#wrap') {expect(page).to have_content 'Blog Edited' }
      within(:css, '#wrap') { expect(page).to have_css 'img' }
    end

    specify 'I can remove a file to my own existing blog' do
      create_new_blog
      visit '/blogs'
      within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }
      click_link 'View Post'
      within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }
      click_button 'Edit'
      text = 'Blog Edited'
      within(:css, '.modal-content') {
      page.execute_script %{ $('#blog_content').data("wysihtml5").editor.setValue('#{text}') }}
      find(:css, '#blog_remove_file').set(true)
      within(:css, '.modal-body') {  click_button 'Update Blog' }
      within(:css, '.flash-messages') {expect(page).to have_content 'Updated'}
      within(:css, '#wrap') {expect(page).to have_content 'Blog Edited' }
      within(:css, '#wrap') { expect(page).to have_no_css 'img' }
    end
  end

  # context 'deleting blogs' do
  #   specify 'I can delete my own blogs', js: true do
  #     create_new_blog
  #     visit '/blogs'
  #     within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }
  #     click_link 'View Post'
  #     accept_confirm do
  #       click_link 'Delete Post'
  #     end
  #     within(:css, '.flash-messages') {expect(page).to have_content 'Blog was successfully deleted' }
  #     within(:css, '#wrap') {expect(page).to have_no_content 'a New Blog' }
  #   end
  #   specify 'I cannot delete someone elses blog' do
  #     click_link 'Log out'
  #     login_as('jdoe@test2.ac.uk')
  #     visit '/blogs'
  #     within(:css, '#wrap') { expect(page).to have_content 'a New Blog' }
  #     click_link 'View Post'
  #     expect(page).to have_no_content 'Delete Post'
  #   end
  # end
end
