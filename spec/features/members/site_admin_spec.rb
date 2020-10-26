require 'rails_helper'

describe 'As a Site Admin' do
  def login_as(username)
    # Log in
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: username
    fill_in 'Password', with: 'Password123'
    click_button 'Log in'
  end

  def start_edit
    login_as('admin@test1.ac.uk')
    sleep(1)
    User.where(email: 'jsmith@test1.ac.uk').update(last_sign_in_at: Time.now)
    visit '/members'
    click_link 'View Profile'
    expect(page).to have_content 'John Smith'
    expect(page).to have_content 'Edit'
    click_link 'Edit'
    expect(page).to have_content 'Editing Member Profile'
  end

  context 'Editing a member\'s information', js: true  do
    specify 'I can edit a member\'s name ' do
      start_edit
      fill_in 'member_name', with: 'Jonathan Smith'
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      within(:css, '#wrap') { expect(page).to have_content 'Jonathan Smith' }
    end

    specify 'I Can edit a member\'s job' do
      start_edit
      fill_in 'member_job', with: 'Support Officer'
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      within(:css, '#wrap') { expect(page).to have_content 'Support Officer' }
    end

    specify 'I can edit a member\'s biography' do
      start_edit
      text = 'Edited Bio'
      page.execute_script %{ $('#member_bio').data("wysihtml5").editor.setValue('#{text}') }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      within(:css, '#wrap') { expect(page).to have_content 'Edited Bio' }
    end
  end

  context 'Editing a member\'s privacy settings', js: true do
    specify 'I can edit a member\'s email privacy settings' do
      start_edit
      expect(page).to have_content 'Editing Member Profile'
      within(:css, '#modalWindow') { page.find('#member_email_privacy_id').all('option')[2].select_option }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_css('#modalWindow')
      click_link 'Edit'
      expect(page.find('select#member_email_privacy_id option[value="2"]')).to be_selected
    end

    specify 'I can edit a member\'s job privacy settings' do
      start_edit
      within(:css, '#modalWindow') { page.find('#member_job_privacy_id').all('option')[2].select_option }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_css('#modalWindow')
      click_link 'Edit'
      expect(page.find('select#member_job_privacy_id option[value="2"]')).to be_selected
    end

    specify 'I can edit a member\'s biography privacy settings' do
      start_edit
      within(:css, '#modalWindow') { page.find('#member_bio_privacy_id').all('option')[2].select_option }
      click_button 'Update Member'
      wait_for_ajax
        expect(page).not_to have_css('#modalWindow')
      click_link 'Edit'
      expect(page.find('select#member_bio_privacy_id option[value="2"]')).to be_selected
    end
  end

  context 'Deleting the member\'s Account', js: true do
    specify 'I can delete an account for any member' do
      login_as('admin@test1.ac.uk')
      sleep(1)
      User.where(email: 'jsmith@test1.ac.uk').update(last_sign_in_at: Time.now)
      visit '/members'
      click_link 'View Profile'
      expect(page).to have_content 'John Smith'
      expect(page).to have_content 'Delete Account'
      accept_confirm do
        click_link 'Delete Account'
      end
      within(:css, '.flash-messages') {expect(page).to have_content 'Member Was Successfully Deleted' }
      within(:css, '#wrap') {expect(page).to have_no_content 'John Smith' }
    end
  end

  context 'Authorising users', js: true do
    specify 'I can authorise members of any institution' do
      login_as('admin@test1.ac.uk')
      sleep(1)
      User.where(email: 'jsmith@test1.ac.uk').update(last_sign_in_at: Time.now)
      visit '/members'
      click_link 'View Profile'
      expect(page).to have_content 'John Smith'
      expect(page).to have_content 'Change Authorisation'
      click_link 'Change Authorisation'
      within(:css, '#modalWindow') { page.find('#auth_role').all('option')[2].select_option }
      click_button 'Update Authorisation Level'
      within(:css, '.flash-messages') {expect(page).to have_content 'Updated'}
      click_link 'Change Authorisation'
      expect(page.find('select#auth_role option[value="3"]')).to be_selected
    end

    specify 'I can create new university admins for an instutition' do
      login_as('admin@test1.ac.uk')
      sleep(1)
      User.where(email: 'jsmith@test1.ac.uk').update(last_sign_in_at: Time.now)
      visit '/members'
      click_link 'View Profile'
      expect(page).to have_content 'John Smith'
      expect(page).to have_content 'Change Authorisation'
      click_link 'Change Authorisation'
      within(:css, '#modalWindow') { page.find('#auth_role').all('option')[1].select_option }
      click_button 'Update Authorisation Level'
      within(:css, '.flash-messages') {expect(page).to have_content 'Updated'}
      click_link 'Change Authorisation'
      expect(page.find('select#auth_role option[value="2"]')).to be_selected
    end

    specify 'I can create new website admins' do
      login_as('admin@test1.ac.uk')
      sleep(1)
      User.where(email: 'jsmith@test1.ac.uk').update(last_sign_in_at: Time.now)
      visit '/members'
      click_link 'View Profile'
      expect(page).to have_content 'John Smith'
      expect(page).to have_content 'Change Authorisation'
      click_link 'Change Authorisation'
      within(:css, '#modalWindow') { page.find('#auth_role').all('option')[0].select_option }
      click_button 'Update Authorisation Level'
      within(:css, '.flash-messages') {expect(page).to have_content 'Updated'}
      click_link 'Change Authorisation'
      expect(page.find('select#auth_role option[value="1"]')).to be_selected
    end
  end

end
