require 'rails_helper'

describe 'As the site admin', js: true do
  before(:each) do
    visit '/'
    click_link 'Login'
    fill_in 'user_email', with: 'admin@test1.ac.uk'
    fill_in 'user_password', with: 'Password123'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
    expect(page).to have_content 'Website Admin'
  end
  context 'Trying to Edit Static Pages' do


    specify 'I can edit The Home Page' do
      # Home Page
      visit '/'
      within(:css, '#wrap') { click_button 'edit-btn' }
      sleep(0.5)
      text = 'Home Page Edited.'
      page.execute_script %Q{ $('#static_page_contents').data("wysihtml5").editor.setValue('#{text}') }
      within(:css, '.modal-footer') {click_button 'Update Static page'}
      sleep(1)
      within(:css, '.page-contents') {expect(page).to have_content 'Home Page Edited.'}
    end

    specify 'I can edit the About Page' do
      # About Page
      visit '/about'
      expect(page).to have_content 'Edit'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'About page edited.'
      page.execute_script %Q{ $('#static_page_contents').data("wysihtml5").editor.setValue('#{text}') }
      click_button 'Update Static page'
      sleep(1)
      within(:css, '.box') {expect(page).to have_content 'About page edited.'}
    end

    specify 'I can edit the conference page' do
      # Conference Page
      visit '/about/conference'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'Conference page edited.'
      page.execute_script %Q{ $('#conference_content').data("wysihtml5").editor.setValue('#{text}') }
      within(:css, '.modal-footer') { click_button 'submit-btn' }
      sleep(1)
      within(:css, '.box') {expect(page).to have_content 'Conference page edited.'}
    end

    specify 'I can edit the constitution page' do
      # Constitution Page
      visit '/about/constitution'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'Constitution page edited.'
      page.execute_script %Q{ $('#static_page_contents').data("wysihtml5").editor.setValue('#{text}') }
      within(:css, '.modal-footer') {click_button 'Update Static page'}
      sleep(1)
      within(:css, '.box') {expect(page).to have_content 'Constitution page edited.' }
    end

    specify 'I can edit the contact page' do
      # Contact Page
      visit '/about/contact'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'Contact page edited.'
      page.execute_script %Q{ $('#static_page_contents').data("wysihtml5").editor.setValue('#{text}') }
      within(:css, '.modal-footer') { click_button 'Update Static page' }
      sleep(1)
      within(:css, '.box') {expect(page).to have_content 'Contact page edited.'}
    end

    specify 'I can edit the get involved page' do
      # Get Involved Page
      visit '/about/get_involved'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'Get Involved page edited.'
      page.execute_script %Q{ $('#static_page_contents').data("wysihtml5").editor.setValue('#{text}') }
      within(:css, '.modal-footer') {click_button 'Update Static page'}
      sleep(1)
      within(:css, '.box') {expect(page).to have_content 'Get Involved page edited.'}
    end

    specify 'I can edit the help page' do
      # Help Page
      visit '/about/help'
      click_button 'edit-btn'
      sleep(0.5)
      text ='Help page edited.'
      page.execute_script %Q{ $('#static_page_contents').data("wysihtml5").editor.setValue('#{text}') }
      within(:css, '.modal-footer') {click_button 'Update Static page'}
      sleep(1)
      within(:css, '.box') {expect(page).to have_content 'Help page edited.'}
    end

    specify 'I can edit the privacy policy page' do
      # Privacy Policy Page
      visit '/about/privacy_policy'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'Privacy Policy page edited.'
      page.execute_script %Q{ $('#static_page_contents').data("wysihtml5").editor.setValue('#{text}') }
      within(:css, '.modal-footer') {click_button 'Update Static page'}
      sleep(1)
      within(:css, '.box') {expect(page).to have_content 'Privacy Policy page edited.'}
    end
  end

  context 'File management', js: true do
    specify 'I can add a file to the home page' do
      visit '/'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'Home Page Edited.'
      page.execute_script %Q{ $('#static_page_contents').data("wysihtml5").editor.setValue('#{text}') }
      attach_file('static_page_custom_file', File.join(Rails.root, '/spec/assets/test.png'))
      within(:css, '.modal-footer') {click_button 'Update Static page'}
      sleep(5)
      within(:css, '#wrap') { expect(page).to have_css 'img' }
    end

    specify 'I can remove a file from the home page' do
      visit '/'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'Home Page Edited.'
      page.execute_script %Q{ $('#static_page_contents').data("wysihtml5").editor.setValue('#{text}') }
      attach_file('static_page_custom_file', File.join(Rails.root, '/spec/assets/test.png'))
      within(:css, '.modal-footer') {click_button 'Update Static page'}
      sleep(5)
      within(:css, '#wrap') { expect(page).to have_css 'img' }
      click_button 'edit-btn'
      find(:css, '#static_page_remove_custom_file').set(true)
      within(:css, '.modal-footer') {click_button 'Update Static page'}
      sleep(10)
      within(:css, '.page-contents') { expect(page).to have_no_css 'img' }
    end

    specify 'I can add a file to the conference page' do
      visit '/about/conference'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'Conference page edited.'
      page.execute_script %Q{ $('#conference_content').data("wysihtml5").editor.setValue('#{text}') }
      attach_file('conference_custom_file', File.join(Rails.root, '/spec/assets/test.png'))
      within(:css, '.modal-footer') {click_button 'submit-btn'}
      sleep(5)
      within(:css, '#wrap') { expect(page).to have_css 'img' }
    end

    specify 'I can remove a file from the conference page' do
      visit '/about/conference'
      click_button 'edit-btn'
      sleep(0.5)
      text = 'Conference page edited.'
      page.execute_script %Q{ $('#conference_content').data("wysihtml5").editor.setValue('#{text}') }
      attach_file('conference_custom_file', File.join(Rails.root, '/spec/assets/test.png'))
      within(:css, '.modal-footer') {click_button 'submit-btn'}
      sleep(5)
      within(:css, '#wrap') { expect(page).to have_css 'img' }
      click_button 'edit-btn'
      find(:css, '#conference_remove_custom_file').set(true)
      within(:css, '.modal-footer') {click_button 'submit-btn'}
      sleep(5)
      within(:css, '#wrap') { expect(page).to have_no_css 'img' }
    end
  end
end
