# frozen_string_literal: true

# Author:    Team 34: Luke Peacock
# Updated:   10.03.2019

# controller class for members
class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy,
                                    :validate_member, :validate_send, :contact]
  # Set member record to correct member for all actions listed above

  # Search all member records using the search params, then paginate the results
  # and sort them based on user choice (default last active)
  def index
    @current_nav_identifier = :members
    members = search(params)
    members = case params[:sort]
              when 'Name Alphabetical Ascending'
                members.order('name ASC')
              when 'Name Alphabetical Descending'
                members.order('name DESC')
              else
                members.joins(:user).order('users.last_sign_in_at DESC')
              end
    @members = members.page(params[:page]).per_page(10)
  end

  # show individual member profile
  def show; end

  # delete a member and associated user from the database
  def destroy
    destroy_blogs(@member.id)
    @member.user.destroy
    @member.destroy
    redirect_to members_url, notice: 'Member Was Successfully Deleted.'
  end

  # method to view form to validate a member
  def validate_member
    render layout: false
  end

  # method to actually change authorisation level
  def validate_send
    if @member.update(role_id: params[:auth][:role])
      render 'update_success'
    else
      render 'update_failure'
    end
  end

  # render view for the form to edit the member profile
  # layout not rendered since form is displayed as modal
  def edit
    render layout: false
  end

  # Method to save the update to the member record
  def update
    if name_exists(params[:member][:name])
      if @member.update(member_params)
        render 'update_success'
        return
      end
    end
    render 'update_failure'
  end

  # Render view for form to send an email
  # layout is not rendered since contact form is displayed as modal
  def contact
    render layout: false
  end

  private

  # Private function for getting a specific members record
  def set_member
    @member = Member.find(params[:id])
  end

  # Valid member parameters
  def member_params
    params.require(:member).permit(:title, :name, :job, :bio,
                                   :account_privacy_id, :email_privacy_id,
                                   :bio_privacy_id, :job_privacy_id)
  end

  # Check is the member's name exists when updating
  def name_exists(name)
    return false if name.nil? || name == ''

    true
  end

  # Move all blogs posted by an account to the admin account
  # +member_id: the ID of the member begin deleted
  def destroy_blogs(member_id)
    blogs = Blog.where(member_id: member_id)
    admin = Member.where(name: 'Website Admin').first
    blogs.each do |b|
      Blog.where(id: b.id).update(member_id: admin.id)
    end
  end

  # Search method, search name, job, bio, and institute name
  # +params: these are the parameters from the search form, they include
  # search, role, and institue
  # Returns: a subset of Members table matching search criteria
  def search(params)
    # pull out search term, institute, and role
    search = params[:search]
    institute = params[:institute]
    role = params[:role]

    # initialise query string and placeholder hash
    query = []
    placeholders = {}

    # if a search term is present, append query for name, institution name,
    # bio, and job search like search term. Add search term to placeholder hash
    unless search.nil? || search == ''
      query.append('(members.name ILIKE :s OR institutions.name ILIKE :s OR ' \
                   'job ILIKE :s OR bio ILIKE :s)')
      placeholders[:s] = '%' + search + '%'
    end

    # If filtering by institute too, append the query string and add institute
    # to placeholder hash
    unless institute == '' || institute.nil?
      query.append('institution_id = :institute')
      placeholders[:institute] = institute
    end

    # if filtering by role, append the query string an add role to placeholder
    # hash
    unless role == '' || role.nil?
      query.append('role_id = :role')
      placeholders[:role] = role
    end

    # Apply query, with placeholders, and return result
    Member.joins(:institution).references(:institution).joins(:user)
          .references(:user).where(query.join(' AND '), placeholders).all
  end
end
