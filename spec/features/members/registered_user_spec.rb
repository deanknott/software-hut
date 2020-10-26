require 'rails_helper'

describe 'As a registered user' do

  context 'Logging in' do
    specify 'I can log in' do
      # Log in
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: 'admin@test1.ac.uk'
      fill_in 'Password', with: 'Password123'
      click_button 'Log in'
      within(:css, '.navbar-right') {expect(page).to have_content 'Log Out'}
    end

    specify 'I cannot log in if I input an incorrect password' do
      # Log in with wrong password
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: 'admin@test1.ac.uk'
      fill_in 'Password', with: 'Password'
      click_button 'Log in'
      within(:css, 'body') {expect(page).to have_content 'Invalid Email or password.'}
    end

    specify 'I cannot log in if I input an incorrect email address' do
      # Log in with wrong email address
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: 'admin@test1.uk'
      fill_in 'Password', with: 'Password123'
      click_button 'Log in'
      within(:css, 'body') {expect(page).to have_content 'Invalid Email or password.'}
    end

    specify 'I cannot log in if I input an incorrect username and password' do
      # Log in with wrong username and password
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: 'admin@test1.uk'
      fill_in 'Password', with: 'Password'
      click_button 'Log in'
      within(:css, 'body') {expect(page).to have_content 'Invalid Email or password.'}
    end

    specify 'I can log out' do
      # Log out
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: 'admin@test1.ac.uk'
      fill_in 'Password', with: 'Password123'
      click_button 'Log in'
      within(:css, '.navbar-right') {expect(page).to have_content 'Log Out'}
      click_link 'Log Out'
      within(:css, 'body') { expect(page).to have_content 'Signed out successfully'}
    end
  end

  def login_as(username)
    # Log in
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: username
    fill_in 'Password', with: 'Password123'
    click_button 'Log in'
  end


  def start_edit
    login_as('AMorgan@test1.ac.uk')
    visit '/members'
    click_link 'View Profile'
    sleep(0.5)
    expect(page).to have_content 'Arthur Morgan'
    expect(page).to have_content 'Edit'
    click_link 'Edit'
    expect(page).to have_content 'Editing Member Profile'
  end

  context 'Editing My Account', js: true do
    specify 'I can edit my name' do
      start_edit
      fill_in 'member_name', with: 'Arthur Callahan'
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      within(:css, '#wrap') { expect(page).to have_content 'Arthur Callahan' }
    end

    specify 'I Can edit my job' do
      start_edit
      fill_in 'member_job', with: 'Support Officer'
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      within(:css, '#wrap') { expect(page).to have_content 'Support Officer' }
    end

    specify 'I can edit my biography' do
      start_edit
      text = 'Edited Bio'
      page.execute_script %{ $('#member_bio').data("wysihtml5").editor.setValue('#{text}') }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      within(:css, '#wrap') { expect(page).to have_content 'Edited Bio' }
    end

    specify 'I cannot update my information if i do not have a name' do
      start_edit
      fill_in 'member_name', with: nil
      click_button 'Update Member'
      within(:css, '.flash-messages') {expect(page).to have_content 'Error'}
    end
  end

  context 'Editing my privacy settings', js: true do
    specify 'I can edit my email privacy settings' do
      start_edit
      within(:css, '#modalWindow') { page.find('#member_email_privacy_id').all('option')[2].select_option }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      expect(page).to have_content 'Edit'
      click_link 'Edit'
      expect(page.find('select#member_email_privacy_id option[value="2"]')).to be_selected
    end

    specify 'I can edit my job privacy settings' do
      start_edit
      within(:css, '#modalWindow') { page.find('#member_job_privacy_id').all('option')[2].select_option }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      expect(page).to have_content 'Edit'
      click_link 'Edit'
      expect(page.find('select#member_job_privacy_id option[value="2"]')).to be_selected
    end

    specify 'I can edit my biography privacy settings' do
      start_edit
      within(:css, '#modalWindow') { page.find('#member_bio_privacy_id').all('option')[2].select_option }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      expect(page).to have_content 'Edit'
      click_link 'Edit'
      expect(page.find('select#member_bio_privacy_id option[value="2"]')).to be_selected
    end
  end
  context 'Deleting My Account' do
    specify 'I can delete my own account', js: true do
      login_as('AMorgan@test1.ac.uk')
      visit '/members'
      click_link 'View Profile'
      expect(page).to have_content 'Arthur Morgan'
      expect(page).to have_content 'Delete Account'
      accept_confirm do
        click_link 'Delete Account'
      end
      within(:css, '.flash-messages') {expect(page).to have_content 'Member Was Successfully Deleted' }
      within(:css, '#wrap') {expect(page).to have_no_content 'Arthur Morgan' }
    end
  end
end
