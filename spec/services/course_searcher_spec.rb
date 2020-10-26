require 'rails_helper'

describe CourseSearcher do

  describe "#search_courses" do

    specify 'returns all courses when no search terms provided' do
      visit 'degree_search/advanced'
      click_button 'Search'
      within(:css, '.page_info') {expect(page).to have_content 'all'}
    end

    specify 'returns no results if no result is matched' do
    end

    specify 'searches by course name' do
      visit 'degree_search/advanced'
      fill_in 'Subject or Degree', with: 'Computer Science'
      click_button 'Search'
      # within(:css, 'table') {expect(page).to have_content 'Computer Science'}
    end


    specify 'searches exclusively by institution' do
        visit 'degree_search/advanced'
        expect(page).to have_select('institute', text: 'Aberystwyth University')
        click_button 'Search'
        within(:css, 'table') {expect(page).to have_content 'Aberystwyth University'}
    end

    specify 'filters by mode of delivery' do
      visit 'degree_search/advanced'
      expect(page).to have_select('full_time', text: 'Full Time')
      click_button 'Search'
      within(:css, 'table') {expect(page).to have_content 'Full Time'}
    end

    specify 'filters by course length' do
      visit 'degree_search/advanced'
        expect(page).to have_select('duration', text: '4')
        click_button 'Search'
        within(:css, 'table') {expect(page).to have_content '4'}
    end

  end

end
