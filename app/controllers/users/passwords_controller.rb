# frozen_string_literal: true
class Users::PasswordsController < Devise::PasswordsController

  # # GET /resource/password/new
  # def new
  #   super
  # end


  def create
    email = resource_params[:email]
    user = User.where(email: email).first
    if user.nil?
      redirect_to '/forgotten_password', notice: 'Please enter a valid email'
    else
      user.generate_reset_token
      token = user[:reset_password_token]
      resource_found = resource_class.find_by_email(email)
      if resource_found
        MessageMailer.reset_password_instructions(user, token).deliver
        respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name)) and return
      end
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end



  # # PUT /resource/password
  def update
    token = params[:user][:reset_password_token]
    user = User.where(reset_password_token: token).first
    if user.nil?
      redirect_to edit_user_password_url(reset_password_token: token), notice: 'Invalid Reset Token'
    else
      if params[:user][:password] == params[:user][:password_confirmation]
        user.update(password: params[:user][:password],
                    password_confirmation: params[:user][:password_confirmation])
        user.save!
        sign_in(user)
        flash[:notice] = 'Password Successfully Updated. You are now Signed in'
        redirect_to root_path
      else
        redirect_to edit_user_password_url(reset_password_token: token), notice: 'Passwords do not match'
      end
    end
  end



  # protected
  #
  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end
  #
  # # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
