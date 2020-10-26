# frozen_string_literal: true

# Class for the mailer to send the email
class MessageMailer < ApplicationMailer
  default from: 'FYN <no-reply@sheffield.ac.uk>'
  default to: 'mailertest172@gmail.com'

  # Contact method that adds the text at the bottom of the message,
  # then sends the email with the correct subject, and message.
  def contact(message)
    @body = message.body + "\n\n From: " + message.name +
            "\n Email Address: " + message.return_address +
            "\n\n This message was sent via a contact form "\
            'on the Foundation Year Network website: ' \
            'foundationyearnetwork.ac.uk'
    mail to: message.email, subject: message.subject,
         body: @body, cc: [message.return_address]
  end

  def reset_password_instructions(user, token)
    @user = user
    @token = token
    mail to: user.email
  end
end
