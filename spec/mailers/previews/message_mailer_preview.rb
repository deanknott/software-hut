# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    user = User.new(email: 'test@no.com', member_id: 1,
                    password: 'password', password_confirmation: 'password')
    if user.nil?
      redirect_to root_path, alert: 'This email does not exist'
    else
      user.generate_reset_token
      token = user[:reset_password_token]
      MessageMailer.reset_password_instructions(user, token)
    end 
  end
end
