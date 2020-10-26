require 'rails_helper'

describe 'Contact Form' do

  specify 'can send an email to the Foundation Year Network' do
    visit '/about/contact'
    fill_in 'Name', with: 'John Doe'
    fill_in 'Return address', with: 'johndoe@example.com'
    fill_in 'Subject', with: 'Subject'
    fill_in 'Body', with: 'Body'

    click_button 'Send'

    # post page.should render_template("/views/messages/email_sucess.js.haml")
    # post page.should have_css("div.alert", :text => 'Message received, thanks!')
    expect(page).to have_content('Message received, thanks!')
  end

  specify 'cannot send an email with no content to the Foundation Year Network' do
    visit '/'
    click_link 'Contact Us'
    fill_in 'Name', with: ''
    fill_in 'Return address', with: ''
    fill_in 'Subject', with: ''
    fill_in 'Body', with: ''

    click_button 'Send'

    # page.should render_template("messages/email_sucess.js.haml")
    # expect(page).to have_content('Message received, thanks!')
  end
end
