require 'rails_helper'

describe 'As a university Admin' do
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
    sleep(1)
    User.where(email: 'jsmith@test1.ac.uk').update(last_sign_in_at: Time.now)
    visit '/members'
    click_link 'View Profile'
    expect(page).to have_content 'John Smith'
    expect(page).to have_content 'Edit'
    click_link 'Edit'
    sleep(0.25)
    expect(page).to have_content 'Editing Member Profile'
  end

  context 'Editing a member of my institution', js: true  do
    specify 'I can edit the member\'s name ' do
      start_edit
      fill_in 'member_name', with: 'Jonathan Smith'
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      within(:css, '#wrap') { expect(page).to have_content 'Jonathan Smith' }
    end

    specify 'I Can edit the member\'s job' do
      start_edit
      fill_in 'member_job', with: 'Support Officer'
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      within(:css, '#wrap') { expect(page).to have_content 'Support Officer' }
    end

    specify 'I can edit the member\'s biography' do
      start_edit
      text = 'Edited Bio'
      page.execute_script %{ $('#member_bio').data("wysihtml5").editor.setValue('#{text}') }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      within(:css, '#wrap') { expect(page).to have_content 'Edited Bio' }
    end
  end

  context 'Editing the member\'s privacy settings', js: true do
    specify 'I can edit the member\'s email privacy settings' do
      start_edit
      within(:css, '#modalWindow') { page.find('#member_email_privacy_id').all('option')[2].select_option }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      expect(page).to have_content 'Edit'
      click_link 'Edit'
      within(:css, '#modalWindow') {expect(page.find('select#member_email_privacy_id option[value="2"]')).to be_selected}
    end

    specify 'I can edit the member\'s job privacy settings' do
      start_edit
      within(:css, '#modalWindow') { page.find('#member_job_privacy_id').all('option')[2].select_option }
      click_button 'Update Member'
      wait_for_ajax
      expect(page).not_to have_content('Editing')
      expect(page).to have_content 'Edit'
      click_link 'Edit'
      expect(page.find('select#member_job_privacy_id option[value="2"]')).to be_selected
    end

    specify 'I can edit the member\'s biography privacy settings' do
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

  context 'Trying to edit a member not from my own institution' do
    specify 'I cannot edit a member of a different institution' do
      login_as('AMorgan@test1.ac.uk')
      sleep(1)
      User.where(email: 'jdoe@test2.ac.uk').update(last_sign_in_at: Time.now)
      visit '/members'
      click_link 'View Profile'
      expect(page).to have_content 'Jane Doe'
      expect(page).to have_no_content 'Edit'
    end

    specify 'I cannot edit the overall website admin account' do
      login_as('AMorgan@test1.ac.uk')
      sleep(1)
      User.where(email: 'admin@test1.ac.uk').update(last_sign_in_at: Time.now)
      visit '/members'
      click_link 'View Profile'
      expect(page).to have_content 'Website Admin'
      expect(page).to have_no_content 'Edit'
    end
  end

  context 'Deleting the member\'s Account' do
    specify 'I can delete an account for a member of my own institution', js:true do
      login_as('AMorgan@test1.ac.uk')
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

    specify 'I cannot delete an account for a member of a different institution' do
      login_as('AMorgan@test1.ac.uk')
      sleep(1)
      User.where(email: 'jdoe@test2.ac.uk').update(last_sign_in_at: Time.now)
      visit '/members'
      click_link 'View Profile'
      expect(page).to have_content 'Jane Doe'
      expect(page).to have_no_content 'Delete Account'
    end
  end

  context 'Authorising users' do
    specify 'I can authorise members of my institution', js: true do
      login_as('AMorgan@test1.ac.uk')
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
      expect(page.find('select#auth_role option[value="3"]')).to be_selected
    end

    specify 'I can create new university admins for my instutition', js: true do
      login_as('AMorgan@test1.ac.uk')
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
      expect(page.find('select#auth_role option[value="2"]')).to be_selected
    end

    specify 'I cannot change the authorisation level of members from other institutions' do
      login_as('AMorgan@test1.ac.uk')
      sleep(1)
      User.where(email: 'jdoe@test2.ac.uk').update(last_sign_in_at: Time.now)
      visit '/members'
      click_link 'View Profile'
      expect(page).to have_content 'Jane Doe'
      expect(page).to have_no_content 'Change Authorisation'
    end
  end

end
