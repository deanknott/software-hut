require 'rails_helper'

# ActiveRecord::Base.connection_config - gives db info
# Rails.application.load_seed - ruby to load seed data into test db
# rake db:seed RAILS_ENV=test - load seed data into test db via command line

# Need to load seed or StaticPages breaks it
# Doesn't check all users, assumes a logged out user is counts as any user.

describe 'Editing Courses' do

  before(:each) do
    login_as('RRobertson@test1.ac.uk')
  end

  def login_as(username)
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: username
    fill_in 'Password', with: 'Password123'
    click_button 'Log in'
  end

  specify 'I can see the edit course button on a course which belongs to my institution' do
    visit '/courses/1'
    within(:css, '.header-buttons') { expect(page).to have_content 'Edit Course' }
  end

  specify 'I can not see the edit course button on a course which does not belong to my institution' do
    visit '/courses/2'
    within(:css, '.header-buttons') { expect(page).not_to have_content 'Edit Course' }
  end

  specify 'I can not directly visit the edit page of a course that does not belong to my institution' do
    visit '/courses/2/edit'
    expect(page.current_url.split('com')[1]).to eq '/403'
  end

  specify 'I can visit the edit course page of a course which belongs to my institution' do
    visit '/courses/1'
    within(:css, '.header-buttons') { click_link 'Edit Course' }
    expect(page.current_url.split('com')[1]).to eq '/courses/1/edit'
  end

  context 'Editing a course with invalid inputs', skip: false, js: true do

    specify 'Course does not update if name is empty' do
      visit '/courses/1/edit'
      within(:css, '.course_name') {fill_in 'course_name', with: ''}
      click_button 'Update Course'
      within(:css, '#feedback-msg1') {expect(page).to have_content 'ERROR!'}
    end

    specify 'Course does not update if location is empty' do
      visit '/courses/1/edit'
      within(:css, '.course_location') {fill_in 'course_location', with: ''}
      click_button 'Update Course'
      within(:css, '#feedback-msg1') {expect(page).to have_content 'ERROR!'}
    end

    specify 'Course does not update if course duration is empty' do
      visit '/courses/1/edit'
      within(:css, '.course_length') {fill_in 'course_length', with: ''}
      click_button 'Update Course'
      within(:css, '#feedback-msg1') {expect(page).to have_content 'ERROR!'}
    end

    specify 'Course does not update if ucas url is empty' do
      visit '/courses/1/edit'
      within(:css, '.course_ucas_url') {fill_in 'course_ucas_url', with: ''}
      click_button 'Update Course'
      within(:css, '#feedback-msg1') {expect(page).to have_content 'ERROR!'}
    end

    specify 'Course does not update if course duration is not an integer' do
      visit '/courses/1/edit'
      within(:css, '.course_length') {fill_in 'course_length', with: '3f'}
      click_button 'Update Course'
      within(:css, '#feedback-msg1') {expect(page).to have_content 'ERROR!'}
    end

    specify 'Course does not update if a fee field is empty when editing fees' do
      visit '/courses/1/edit'
      within(:css, '#fee-section') {fill_in 'edit_fees_amount1', with: ''}
      click_button 'Update Course'
      within(:css, '#feedback-msg2') {expect(page).to have_content 'ERROR! No fields can be empty'}
    end

    specify 'Course does not update if a time period field is empty when editing fees' do
      visit '/courses/1/edit'
      within(:css, '#fee-section') {fill_in 'edit_fees_time1', with: ''}
      click_button 'Update Course'
      within(:css, '#feedback-msg2') {expect(page).to have_content 'ERROR! No fields can be empty'}
    end

    specify 'Course does not update if a fee field is not an integer when editing fees' do
      visit '/courses/1/edit'
      within(:css, '#fee-section') {fill_in 'edit_fees_amount1', with: '2h'}
      click_button 'Update Course'
      within(:css, '#feedback-msg2') {expect(page).to have_content 'ERROR! Fee has to be an integer'}
    end

    specify 'Course does not update if all fields are not empty or filled when adding a fee' do
      visit '/courses/1/edit'
      within(:css, '#fee-section') {fill_in 'add_fee_fee1', with: '500'}
      click_button 'Update Course'
      within(:css, '#feedback-msg2') {expect(page).to have_content 'ERROR! All fields need to be filled'}
    end

    specify 'Course does not update if fee amount is not an integer when adding a fee' do
      visit '/courses/1/edit'
      within(:css, '#fee-section') {page.select 'England', from: 'add_fee_stu1'}
      within(:css, '#fee-section') {fill_in 'add_fee_fee1', with: '500g'}
      within(:css, '#fee-section') {fill_in 'add_fee_time1', with: 'Year 1'}
      click_button 'Update Course'
      within(:css, '#feedback-msg2') {expect(page).to have_content 'ERROR! Fee needs to be an integer'}
    end

    specify 'Course does not update if grade is empty when editing an entry requirement' do
      visit '/courses/1/edit'
      within(:css, '#er-section') {fill_in 'edit_entry_req_grade1', with: ''}
      click_button 'Update Course'
      within(:css, '#feedback-msg3') {expect(page).to have_content 'ERROR! Grade can\'t be empty'}
    end

    specify 'Course does not update if grade is empty when adding an entry requirement' do
      visit '/courses/1/edit'
      within(:css, '#er-section') {fill_in 'add_entry_req_info1', with: 'wfwf'}
      click_button 'Update Course'
      within(:css, '#feedback-msg3') {expect(page).to have_content 'ERROR! Either leave all'}
    end

  end

  context 'Editing a course with valid inputs', js: true do

    specify 'Course updates if I do not change anything' do
      visit '/courses/1/edit'
      click_button 'Update Course'
      within(:css, '#feedback-msg') {expect(page).to have_content 'SUCCESS!'}
    end

    specify 'Course updates if I add a new Qualification Type' do
      visit '/courses/1/edit'
      fill_in 'end_qual_name', with: 'Master of Maths - MMath'
      click_button 'Update Course'
      within(:css, '#feedback-msg') {expect(page).to have_content 'SUCCESS!'}
    end

    specify 'Course updates if I add a new Delivery Mode' do
      visit '/courses/1/edit'
      fill_in 'del_mode_name', with: 'Master of Maths - MMath'
      click_button 'Update Course'
      within(:css, '#feedback-msg') {expect(page).to have_content 'SUCCESS!'}
    end

    specify 'Course updates if I remove a criteria for widening participations' do
      visit '/courses/1/edit'
      find(:css, "#remove_wps_2").set(true)
      click_button 'Update Course'
      within(:css, '#feedback-msg') {expect(page).to have_content 'SUCCESS!'}
    end

    specify 'Course updates if I select a criteria for widening participations' do
      visit '/courses/1/edit'
      page.select 'Other', from: 'wp_sel_wp1'
      click_button 'Update Course'
      within(:css, '#feedback-msg') {expect(page).to have_content 'SUCCESS!'}
    end

    specify 'Course updates if I enter a criteria for widening participations' do
      visit '/courses/1/edit'
      fill_in 'wp_new_wp1', with: 'Otherer'
      click_button 'Update Course'
      within(:css, '#feedback-msg') {expect(page).to have_content 'SUCCESS!'}
    end

    specify 'Course updates if I remove a fee for a student type' do
      visit '/courses/1/edit'
      find(:css, "#edit_fees_remove_1").set(true)
      click_button 'Update Course'
      within(:css, '#feedback-msg') {expect(page).to have_content 'SUCCESS!'}
    end

    specify 'Course updates if fee fields are all correct' do
      visit '/courses/1/edit'
      within(:css, '#fee-section') {page.select 'Northern Ireland', from: 'add_fee_stu1'}
      within(:css, '#fee-section') {fill_in 'add_fee_fee1', with: '9250'}
      within(:css, '#fee-section') {fill_in 'add_fee_time1', with: 'Year 1'}
      click_button 'Update Course'
      within(:css, '#feedback-msg') {expect(page).to have_content 'SUCCESS!'}
    end

    specify 'Course updates if I remove an entry requirement' do
      visit '/courses/1/edit'
      find(:css, "#edit_entry_req_remove_1").set(true)
      click_button 'Update Course'
      within(:css, '#feedback-msg') {expect(page).to have_content 'SUCCESS!'}
    end

  end

end
