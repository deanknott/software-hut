# frozen_string_literal: true

# The devise user registration controller
class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_sign_up_params, only: [:create, :new]
  # before_action :configure_account_update_params, only: [:update]

  # GET /register
  # Go to the new user page
  def new
    @privacies = Privacy.all
    super
  end

  # POST /register
  # create the actual member/user record
  def create
    member_attr = sign_up_params[:member_attributes]
    if validate_email(sign_up_params[:email])
      member_attr[:institution_id] = get_institute(sign_up_params[:email])
      member_attr[:role_id] = Role.find_by(name: 'Pending').id
      member_attr[:account_privacy_id] = 1
      member = Member.new(member_attr)
      user =
        User.new(email: sign_up_params[:email],
                 password: sign_up_params[:password],
                 password_confirmation: sign_up_params[:password_confirmation],
                 last_sign_in_at: Time.now)
      if member.valid? && !member[:name].empty?
          create_transaction(member, user)
      else
        render 'missing_fields'
        return
      end
    else
      render 'invalid_email'
      return
    end
  end

  # GET /resource/edit
  def edit
    @user_params = resource_params[:password]
    if @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [member_attributes:
                                      [:title, :name, :job,
                                       :bio, :account_privacy_id,
                                       :email_privacy_id,
                                       :bio_privacy_id,
                                       :job_privacy_id]])
  end

  # check the users email, if no record exists with this,
  # then start transaction and save member and user records
  def create_transaction(member, user)
    if !User.exists?(email: sign_up_params[:email])
      User.transaction do
        member.save!
        user[:member_id] = member[:id]
        if user.valid? && user.save!
          sign_in(user)
          flash[:notice] = 'Welcome to the Network, ' + member.title + ' ' +
                           member.name
          redirect_to root_path
        else
          render 'error'
          member.destroy
          return
        end
      end
    else
      render 'existing_email'
    end
  end

  # check if email is valid institution email
  def validate_email(email)
    domain = email.split('@').last
    return unless sign_up_params[:email].end_with?('.ac.uk')
    return unless Institution.exists?(['email ILIKE ?', "%#{domain}%"])
    true
  end

  # work out the members institute
  def get_institute(email)
    domain = email.split('@').last
    Institution.where('email ILIKE ?', "%#{domain}%").pluck(:id).first
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
