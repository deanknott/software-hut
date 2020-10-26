require "rails_helper"

RSpec.describe StoredSearchMailer, type: :mailer do
  describe 'Stored Search' do
    let(:stored_search) {StoredSearchMailer.new_subscription_email(stored_search)}

    specify 'I can save a search' do
        visit '/degree_search'
        fill_in 'Subject or Degree', with: 'Computing'
        click_button 'Save Search'
        fill_in 'Email', with: 'test@test.com'
        fill_in 'Subject', with: 'Computing'
        fill_in 'Institution', with: 'Sheffield'
        expect(page).to have_select('full_time', text: 'Full Time')
        fill_in 'Duration in Years', with: '4'
        click_button 'Save Search'
        expect(page).to have_content 'Subscription Successful'

        expect{StoredSearchMailer.new_subscription_email(stored_search).deliver_now}
    end
  end
end
