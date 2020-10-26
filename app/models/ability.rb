# frozen_string_literal: true

# CanCanCan ability file
class Ability
  include CanCan::Ability

  # Give user appropriate permissions
  def initialize(user)
    # if user not signed in, give them new user record but dont save it to db
    user ||= User.new
    # Temporary solution??? manage means read and do all functions
    # - worth noting there are only read functions in the pages controller
    can :read, [:pages, StaticPage, Blog]
    # If user is not temp, then get their member and role id
    return unless user != User.new
    role = user.member.role.name
    # Go to the admin permissions function if user is admin
    admin_permissions(role) if role.include?('Admin')
  end
  # See the wiki for details:
  # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities


  # general admin permissions
  def admin_permissions(role)
    # If user is the overall web admin, give them the appropriate permissions,
    # Same for univerity admin
    if role == 'Website Admin'
      web_admin_permissions
    elsif role == 'University Admin'
      uni_admin_permissions
    end
  end

  # website admin permissions
  def web_admin_permissions
    can :update_static_pages, StaticPage
    can :update, Member
    can :upload_courses, :uploads
    can :validate, Member
  end

  # University admin permissions
  def uni_admin_permissions

  end
end
