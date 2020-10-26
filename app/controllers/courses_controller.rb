# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_editability, only: [:show, :edit]


  def index
  #  @courses = Course.where(name: params[:name]).or.where(location: params[:location])
    @courses = search_courses(params).order('name ASC')
                                     .page(params[:page])
                                     .per_page(20)
  end

  def show
  end

  def edit
    if !@editable
      redirect_to '/403'
    end
  end

  def update
    course_params = get_course_params
    valid = true
    # empty course param
    if !valid_course_params
      valid = false
      render 'empty_course_param'
      return
    end
    # course length isn't integer
    if !course_params[:length].to_i.to_s.eql? course_params[:length]
      valid = false
      render 'length_not_integer'
      return
    else
      course_params[:length] = course_params[:length].to_i
    end
    # both fields have to be filled
    if !edit_fee_fields_filled
      valid = false
      render 'empty_edit_fees_field'
      return
    end
    # edit fee fields have to be valid integers
    if !edit_fee_is_integer
      valid = false
      render 'edit_fee_not_integer'
      return
    end
    # add fee fields have to be either all empty or all filled
    if !add_fee_filled_or_empty
      valid = false
      render 'add_fee_empty_field'
      return
    end
    # add fee is not an integer
    if !add_fee_is_integer
      valid = false
      render 'add_fee_not_integer'
      return
    end
    # grade can't be empty
    if !valid_edit_entry_reqs
      valid = false
      render 'edit_entry_req_empty_grade'
      return
    end
    # valid is all fields empty or incoming_qual and grade filled
    if !valid_add_entry_req
      valid = false
      render 'add_entry_req_invalid_inputs'
      return
    end

    # Set End Qualification
    if !empty_new_end_qual && valid
      new_end_qual_name = params[:end_qual][:name].strip
      new_end_qual_id = EndQualification.find_or_create_by(name: new_end_qual_name).id
      course_params = course_params.merge(end_qualification_id: new_end_qual_id)
    end

    # Set Delivery Mode
    if !empty_new_del_mode && valid
      new_del_mode_name = params[:del_mode][:name].strip
      new_del_mode_id = DeliveryMode.find_or_create_by(name: new_del_mode_name).id
      course_params = course_params.merge(delivery_mode_id: new_del_mode_id)
    end

    # Remove Widening Participations
    remove_wp = params[:remove_wps]
    if !remove_wp.nil? && valid
      remove_wp.each do |wp|
        if wp[1].to_i == 1
          @course.wps.delete(Wp.find(wp[0].to_i))
        end
      end
    end

    # Add Widening Participations
    if !params[:wp].nil? && valid
      new_wp_keys = params[:wp].keys
      new_wp_vals = params[:wp].values
      new_wp_vals.each_slice(2) do |selected, text|
        new_wp_type = ""
        if !(selected.strip.empty? && text.strip.empty?)
          if !text.strip.empty?
            new_wp_type = text.strip
          else
            new_wp_type = selected.strip
          end
          new_wp = Wp.find_or_create_by(wp_type: new_wp_type)
          if !(@course.wps.include? new_wp)
            @course.wps << new_wp
          end
        end
      end
    end

    # Editing Existing Fees
    if !params[:edit_fees].nil? && valid
      edit_fees_keys = params[:edit_fees].keys
      edit_fees_vals = params[:edit_fees].values
      edit_fees_count = 0
      edit_fees_vals.each_slice(3) do |cost, time, remove|
        # remove fee or update
        if remove.eql? "1"
          id = edit_fees_keys[edit_fees_count+1].split('time')[1].to_i
          Fee.destroy(id)
        else
          id = edit_fees_keys[edit_fees_count+1].split('time')[1].to_i
          Fee.update(id, fee: cost.to_i, time_period: time)
        end

        edit_fees_count += 3
      end
    end

    # Adding New Fees
    if !params[:add_fee].nil? && valid
      add_fee_keys = params[:add_fee].keys
      add_fee_vals = params[:add_fee].values
      add_fee_vals.each_slice(3) do |student_type, amount, time_period|
        if !student_type.empty? && !amount.empty? && !time_period.empty?
          fee = Fee.find_or_create_by(course_id: @course.id, student_type_id: student_type)
          fee.update(fee: amount.to_i, time_period: time_period)
        end
      end
    end

    # Editing Entry Requirements
    if !params[:edit_entry_req].nil? && valid
      edit_reqs_keys = params[:edit_entry_req].keys
      edit_reqs_vals = params[:edit_entry_req].values
      edit_reqs_count = 0
      edit_reqs_vals.each_slice(3) do |grade, info, remove|
        id = edit_reqs_keys[edit_reqs_count + 1].split('info')[1].to_i
        if remove.eql? "1"
          EntryRequirement.destroy(id)
        else
          EntryRequirement.update(id, grade: grade, info: info)
        end
        edit_reqs_count += 3
      end
    end

    # Adding New Entry Requirements
    if !params[:add_entry_req].nil? && valid
      add_er_keys = params[:add_entry_req].keys
      add_er_vals = params[:add_entry_req].values
      add_er_vals.each_slice(3) do |incoming_qual, grade, info|
        entry_req = EntryRequirement.find_or_create_by(course_id: @course.id,
                            incoming_qualification_id: incoming_qual.to_i)
        entry_req.update(grade: grade, info: info)
      end
    end

    # update if inputs are valid
    course_params = course_params.permit!
    if valid && @course.update(course_params)
      render 'update_success'
      return
    end

  end

  def scrape
    if user_signed_in? && (current_user.member.role.name.eql? 'Website Admin')
      CourseScraperJob.perform_now
      redirect_to root_path, notice: 'Courses Uploaded'
    else
      redirect_to '/403'
    end
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

  # course is editable if the signed in user is a University Admin
  # and belongs to the same institution as the course
  def set_editability
    @editable = user_signed_in? && (current_user.member.role.name.eql? "University Admin") &&
        current_user.member.institution.id == @course.department.institution.id
  end

  # next few methods are for updating/editing course
  def get_course_params
    course_params = params.require(:course)
    if !empty_new_end_qual
      course_params = course_params.except(:end_qualification_id)
    end
    if !empty_new_del_mode
      course_params = course_params.except(:delivery_mode_id)
    end
    return course_params.permit!
  end

  # check for empty
  def valid_course_params
    course_params = get_course_params
    if course_params[:name].empty? || course_params[:location].empty? || course_params[:length].empty? ||
            course_params[:ucas_url].empty?
      return false
    else
      return true
    end
  end

  # all existing fees have both fields filled
  def edit_fee_fields_filled
    if !params[:edit_fees].nil?
      edit_fees_vals = params[:edit_fees].values
      edit_fees_vals.each_slice(3) do |fee, time, remove|
        if fee.empty? || time.empty?
          return false
        end
      end
    end
    return true
  end

  # edit fee fields have valid integers
  def edit_fee_is_integer
    if !params[:edit_fees].nil?
      edit_fees_vals = params[:edit_fees].values
      edit_fees_vals.each_slice(3) do |fee, time, remove|
        if !(fee.to_i.to_s.eql? fee)
          return false
        end
      end
    end
    return true
  end

  # add fee fields are all filled or all empty
  def add_fee_filled_or_empty
    if !params[:add_fee].nil?
      add_fee_keys = params[:add_fee].keys
      add_fee_vals = params[:add_fee].values
      add_fee_vals.each_slice(3) do |student_type, amount, time_period|
        if !((!student_type.empty? && !amount.empty? && !time_period.empty?) ||
                (student_type.empty? && amount.empty? && time_period.empty?))
          return false
        end
      end
    end
    return true
  end

  # add fee is an integer
  def add_fee_is_integer
    if !params[:add_fee].nil?
      add_fee_vals = params[:add_fee].values
      add_fee_vals.each_slice(3) do |student_type, amount, time_period|
        if !amount.empty? && !(amount.to_i.to_s.eql? amount)
          return false
        end
      end
    end
    return true
  end

  # Grade can't be empty
  def valid_edit_entry_reqs
    if !params[:edit_entry_req].nil?
      edit_reqs_vals = params[:edit_entry_req].values
      edit_reqs_vals.each_slice(3) do |grade, info, remove|
        if grade.empty?
          return false
        end
      end
    end
    return true
  end

  # valid is all fields empty or incoming_qual and grade filled
  def valid_add_entry_req
    if !params[:add_entry_req].nil?
      add_er_vals = params[:add_entry_req].values
      add_er_vals.each_slice(3) do |incoming_qual, grade, info|
        if (!incoming_qual.empty? && grade.empty?) ||
                (incoming_qual.empty? && (!grade.empty? || !info.empty?))
          return false
        end
      end
    end
    return true
  end


  # end qualification
  def empty_new_end_qual
    params[:end_qual][:name].strip.empty?
  end

  # delivery mode
  def empty_new_del_mode
    params[:del_mode][:name].strip.empty?
  end

  def search_courses(params)
    # a-z search
    unless params[:letter].nil? || params[:letter] == ''
      return Course.where('courses.name ILIKE \'' + params[:letter] + '%\'').all
    end
    CourseSearcher.new(params).search_courses
  end

end
