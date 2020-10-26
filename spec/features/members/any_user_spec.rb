require 'rails_helper'

describe 'As any user' do
  specify 'I can view a list of registered members' do
    visit '/members'
    within(:css, '.page-header') {expect(page).to have_content 'Members'}
    within(:css, '.index-list') {expect(page).to have_content 'View Profile'}
  end

  specify 'I can view the public profiles of registered members' do
    sleep(1)
    User.update('jsmith@test1.ac.uk', last_sign_in_at: Time.now)
    visit '/'
    click_link 'Members'
    click_link 'View Profile'
    within(:css, '#wrap') { expect(page).to have_no_content 'Members' }
    within(:css, '#wrap') { expect(page).to have_content 'John' }
    within(:css, '.name') { expect(page).to have_content 'Name' }
    within(:css, '.job') { expect(page).to have_content 'Position' }
    within(:css, '.institute') { expect(page).to have_content 'Institution' }
    within(:css, '.email') { expect(page).to have_content 'Email Address' }
    within(:css, '.bio') { expect(page).to have_content 'Biography' }
  end

  context 'Sorting The List of Members' do
    specify 'I can order the list of registered users by Last Active' do
      # create different last active times
      sleep(1)
      User.update('admin@test1.ac.uk', last_sign_in_at: Time.now)
      visit '/'
      click_link 'Members'
      sleep(0.5)
      name = page.all('h3')[1].text
      time1 = page.all('h6')[0].text.split[1].to_i
      time2 = page.all('h6')[1].text.split[1].to_i
      expect(name).to eq 'Website Admin'
      expect(time1).to be < time2
    end

    specify 'I can order the list of registered users alphabetically ascending' do
      visit '/'
      click_link 'Members'
      sleep(0.1)
      # asc
      page.find('select').all('option')[1].select_option
      click_button 'Search'
      name = page.all('h3')[1].text
      expect(name).to eq 'Arthur Morgan'
    end

    specify 'I can order the list of registered users alphabetically descending' do
      visit '/'
      click_link 'Members'
      sleep(0.1)
      # desc
      page.find('select').all('option')[2].select_option
      click_button 'Search'
      name = page.all('h3')[1].text
      expect(name).to eq 'Website Admin'
    end
  end

  context 'Filtering The List Of Members' do
    specify 'I can filter by institution' do
      visit '/members'
      page.find('#filter-btn').click
      sleep(0.1)
      within(:css, '#filter-options') { page.find('#institute').all('option')[1].select_option }
      within(:css, '#filter-options') { click_button 'Apply Filters' }
      name = page.all('h3')[1].text
      expect(name).to eq 'Website Admin'
    end

    specify 'I can filter by role' do
      visit '/members'
      page.find('#filter-btn').click
      sleep(0.1)
      within(:css, '#filter-options') { page.find('#role').all('option')[2].select_option }
      within(:css, '#filter-options') { click_button 'Apply Filters' }
      name = page.all('h3')[1].text
      expect(name).to eq 'Jim Milton'
    end
  end

  specify 'I can search for a specific member' do
    visit '/members'
    within(:css, '.page-header') { fill_in 'search', with: 'John Smith' }
    within(:css, '.page-header') { expect(page).to have_css '#search' }
    within(:css, '.page-header') { page.find('#search-btn').click }
    sleep(0.5)
    within(:css, '.index-list') {expect(page).to have_selector('h3', count: 1)}
    name = page.all('h3')[1].text
    expect(name).to eq 'John Smith'

  end

  context 'Registering' do
    specify 'I Can Register for an account if I  provide the correct info' do
      visit '/'
      click_link 'Login'
      expect(page).to have_content 'Sign up'
      click_link 'Sign up'
      fill_in 'user_email', with: 'Test@test1.ac.uk'
      fill_in 'user_password', with: 'Password123'
      fill_in 'user_password_confirmation', with: 'Password123'
      fill_in 'user_member_attributes_name', with: 'This is a Test'
      fill_in 'user_member_attributes_job', with: 'Tester'
      fill_in 'user_member_attributes_bio', with: 'This is a test bio'
      page.find('#user_member_attributes_bio_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_job_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_email_privacy_id')
          .all('option')[2].select_option
      click_button 'sign-up'
      visit '/members'
      within(:css, '#wrap') {expect(page).to have_content 'This is a Test'}
    end

    specify 'I cannot register for an account if I do not provide an email address' do
      visit '/'
      click_link 'Login'
      expect(page).to have_content 'Sign up'
      click_link 'Sign up'
      fill_in 'user_password', with: 'Password123'
      fill_in 'user_password_confirmation', with: 'Password123'
      fill_in 'user_member_attributes_name', with: 'This is a Test'
      fill_in 'user_member_attributes_job', with: 'Tester'
      fill_in 'user_member_attributes_bio', with: 'This is a test bio'
      page.find('#user_member_attributes_bio_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_job_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_email_privacy_id')
          .all('option')[2].select_option
      click_button 'sign-up'
      within(:css, 'body') {
          expect(page).to have_content 'Not an academic address registered on this system, Please contact the Administrator'
        }
    end

    specify 'I cannot register for an account if I do not provide a password' do
      visit '/'
      click_link 'Login'
      expect(page).to have_content 'Sign up'
      click_link 'Sign up'
      fill_in 'user_email', with: 'Test@test1.ac.uk'
      fill_in 'user_member_attributes_name', with: 'This is a Test'
      fill_in 'user_member_attributes_job', with: 'Tester'
      fill_in 'user_member_attributes_bio', with: 'This is a test bio'
      page.find('#user_member_attributes_bio_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_job_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_email_privacy_id')
          .all('option')[2].select_option
      click_button 'sign-up'
      within(:css, 'body') {
        expect(page).to have_content 'One or more fields are missing, Please try again', 'alert-notice'
      }
    end

    specify 'I cannot register for an account if I do not provide matching password' do
      visit '/'
      click_link 'Login'
      expect(page).to have_content 'Sign up'
      click_link 'Sign up'
      fill_in 'user_email', with: 'Test@test1.ac.uk'
      fill_in 'user_password', with: 'Password123'
      fill_in 'user_password_confirmation', with: 'Password12'
      fill_in 'user_member_attributes_name', with: 'This is a Test'
      fill_in 'user_member_attributes_job', with: 'Tester'
      fill_in 'user_member_attributes_bio', with: 'This is a test bio'
      page.find('#user_member_attributes_bio_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_job_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_email_privacy_id')
          .all('option')[2].select_option
      click_button 'sign-up'
      within(:css, 'body') {
        expect(page).to have_content 'An error occurred. Please try again'
      }
    end

    specify 'I Cannot Register for an account if I do not provide a name' do
      visit '/'
      click_link 'Login'
      expect(page).to have_content 'Sign up'
      click_link 'Sign up'
      fill_in 'user_email', with: 'Test@test1.ac.uk'
      fill_in 'user_password', with: 'Password123'
      fill_in 'user_password_confirmation', with: 'Password123'
      fill_in 'user_member_attributes_job', with: 'Tester'
      fill_in 'user_member_attributes_bio', with: 'This is a test bio'
      page.find('#user_member_attributes_bio_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_job_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_email_privacy_id')
          .all('option')[2].select_option
      click_button 'sign-up'
      within(:css, 'body') {
        expect(page).to have_content 'One or more fields are missing, Please try again', 'alert-notice'
      }
    end

    specify 'I cannot register for an account if i do not provide a valid email address' do
      visit '/'
      click_link 'Login'
      expect(page).to have_content 'Sign up'
      click_link 'Sign up'
      fill_in 'user_email', with: 'Testtest1.com'
      fill_in 'user_password', with: 'Password123'
      fill_in 'user_password_confirmation', with: 'Password123'
      fill_in 'user_member_attributes_name', with: 'This is a Test'
      fill_in 'user_member_attributes_job', with: 'Tester'
      fill_in 'user_member_attributes_bio', with: 'This is a test bio'
      page.find('#user_member_attributes_bio_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_job_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_email_privacy_id')
          .all('option')[2].select_option
      click_button 'sign-up'
      within(:css, 'body') {expect(page).to have_content 'Not an academic address registered on this system, Please contact the Administrator'}
    end

    specify 'I cannot register for an account if i do not provide a valid academic email address' do
      visit '/'
      click_link 'Login'
      expect(page).to have_content 'Sign up'
      click_link 'Sign up'
      fill_in 'user_email', with: 'Test@test1.com'
      fill_in 'user_password', with: 'Password123'
      fill_in 'user_password_confirmation', with: 'Password123'
      fill_in 'user_member_attributes_name', with: 'This is a Test'
      fill_in 'user_member_attributes_job', with: 'Tester'
      fill_in 'user_member_attributes_bio', with: 'This is a test bio'
      page.find('#user_member_attributes_bio_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_job_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_email_privacy_id')
          .all('option')[2].select_option
      click_button 'sign-up'
      within(:css, 'body') {expect(page).to have_content 'Not an academic address registered on this system, Please contact the Administrator'}
    end

    specify 'I cannot register for an account if i do not provide a unique academic email address' do
      visit '/'
      click_link 'Login'
      expect(page).to have_content 'Sign up'
      click_link 'Sign up'
      fill_in 'user_email', with: 'jsmith@test1.ac.uk'
      fill_in 'user_password', with: 'Password123'
      fill_in 'user_password_confirmation', with: 'Password123'
      fill_in 'user_member_attributes_name', with: 'This is a Test'
      fill_in 'user_member_attributes_job', with: 'Tester'
      fill_in 'user_member_attributes_bio', with: 'This is a test bio'
      page.find('#user_member_attributes_bio_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_job_privacy_id')
          .all('option')[2].select_option
      page.find('#user_member_attributes_email_privacy_id')
          .all('option')[2].select_option
      click_button 'sign-up'
      within(:css, 'body') {expect(page).to have_content 'This email address is already registered to an account.'}
    end
  end
end
