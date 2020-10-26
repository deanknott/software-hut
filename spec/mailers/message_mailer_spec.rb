require "rails_helper"

RSpec.describe MessageMailer, type: :mailer do

  describe 'Contact Form' do
      let(:message) {MessageMailer.contact(message)}

    specify 'can send an email to the Foundation Year Network' do
      visit '/about/contact'
      fill_in 'Name', with: 'John Doe'
      fill_in 'Return address', with: 'johndoe@example.com'
      fill_in 'Subject', with: 'Subject'
      fill_in 'Body', with: 'Body'

      click_button 'Send'

      expect{MessageMailer.contact(message).deliver_now}
      expect{(message.name).to eq('John Doe')}
      expect{(message.return_address).to eq('johndoe@example.com')}
      expect{(message.subject).to eq('Subject')}
      expect{(message.body).to eq('Body')}
    end

    specify 'cannot send an email with no content to the Foundation Year Network' do
      visit '/'
      click_link 'Contact Us'
      fill_in 'Name', with: ''
      fill_in 'Return address', with: ''
      fill_in 'Subject', with: ''
      fill_in 'Body', with: ''

      click_button 'Send'
    end
  end

  describe 'Send password reset instructions' do

    specify 'I can request to reset my password' do
      user = User.where(email: 'jsmith@test1.ac.uk').first
      # user.generate_reset_token
      # token = user[:reset_password_token]
      visit '/'
      click_link 'Login'
      click_link 'Forgot your password?'
      fill_in 'Email', with: user.email
      click_button 'Send me reset password instructions'
      puts User.where(email: 'jsmith@test1.ac.uk').first.reset_password_token
      expect{MessageMailer.reset_password_instructions(user, token).deliver_now}
    end

    specify 'I cannot request a password reset email if the email address does not exist' do
      visit '/'
      click_link 'Login'
      click_link 'Forgot your password?'
      fill_in 'Email', with: 'no@email.uk'
      click_button 'Send me reset password instructions'
      within(:css, 'body') { expect(page).to have_content 'Please enter a valid email' }
    end
  end

end
