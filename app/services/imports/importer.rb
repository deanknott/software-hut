# frozen_string_literal: true

# Author:    Team 34: Luke Peacock, Seth Faulkner, Dean Knott,
#                     Luke Markie, Matthew Prestwich
# Updated:   03.05.2019

# This is the importer class for importing courses to the database
class Imports::Importer
  # This class is used to import the courses after the Imports::Scraper service
  # has finished getting the course information. This class imports the data
  # into the database by either creating new records or updating existing ones


  # method for creating a new importer instance, calls initialize method
  def new
    initialize
  end

  # Method to initialze the importer.
  # converts the database tables to arrays to limit the number of queries
  # then initialises the course id.
  def initialize
    records_to_arrays

    @course_id = 1
    unless Course.order('id DESC').first.nil?
      @course_id = Course.order('id DESC').first.id + 1
    end

    stored_search = Imports::StoredSearch.new
  end

  # This method converts the database tables into arrays
  # This reduces the number of database queries while updating records
  def records_to_arrays
    @institutions = Institution.all.to_a
    @end_quals = EndQualification.all.to_a
    @entry_reqs = EntryRequirement.all.to_a
    @incoming_quals = IncomingQualification.all.to_a
    @student_types = StudentType.all.to_a
    @departments = Department.all.to_a
    @courses = Course.all.to_a
    @fees = Fee.all.to_a
  end

  # This method decides whether to update a course, or create a new one
  # +new_course: the course parameters being checked
  # returns nill, either updates course or adds new one to database
  def import_course(new_course)
    unless @courses.nil?
      course = @courses.find { |hash| hash[:ucas_url] == new_course[:ucas_url] }
    end
    # if no course can be found that matches the new parameters
    # then create a new course, else update an existing one
    if course.nil?
      new_course(new_course)
    else
      update_course(new_course, course)
    end
  end

  # This method is used to create a new course record in the database
  # +course: the parameters of the new course being added
  # Return: adds records to database
  def new_course(course)
    # Begin transaction to allow rollback in case of error
    Course.transaction do
      # find the course institution
      course_inst = @institutions.find { |hash| hash[:name].eql? course[:provider] }
      # create the new course
      new_course = Course
                   .new(name: course[:name],
                        end_qualification: end_qual_check(course),
                        description: course[:description],
                        institute_url: course[:provider_url],
                        ucas_url: course[:ucas_url],
                        full_time: full_time_check(course[:study_mode]),
                        location: course[:location],
                        start_date: course[:start_date],
                        length: extract_length(course[:duration]),
                        department_id: department_check(course, course_inst[:id])[:id],
                        entry_requirements_info: course[:requirements_info],
                        fees_info: course[:fees_info],
                        code: course[:course_code],
                        id: @course_id, notes: course[:notes])
      # save if valid and then store the requirements and fees
      new_course.save!
      store_reqs_and_fees(course[:requirements], course[:fees], new_course)

      @course_id += 1
    end
  end

  # store the course requirements and fees as necessary
  # +requirements: the entry requirements for the course
  # +fees: the fees for the course
  # +new_course: the new course record
  # Return: adds records to the database
  def store_reqs_and_fees(requirements, fees, new_course)
    # For each requirement call appropriate method
    requirements.each do |entry_requirement|
      create_incoming_qual_link(entry_requirement, new_course)
    end

    # for each fee, call appropriate method
    fees.each do |fee|
      create_fee_link(fee, new_course)
    end
  end

  # Create the link for incoming qualifications
  # +entry_requirement: one of the entry requirements for the course
  # +course: the course parameters
  # Return: Add record to database
  def create_incoming_qual_link(entry_requirement, course)
    unless @incoming_quals.nil?
      qual = @incoming_quals.find{|hash| hash[:name] == entry_requirement[0]}
    end
    # If no incoming qualification exists with the name provided
    # Then create one and add it to the incoming_quals array
    if qual.nil?
      qual = IncomingQualification.create(name: entry_requirement[0])
      @incoming_quals << qual
    end
    # Create the entry requirement for the course
    EntryRequirement.create(course: course,
                            incoming_qualification: qual,
                            grade: entry_requirement[1],
                            info: entry_requirement[2])
  end

  # Create link for fees
  # +fee: one of the fees for the course
  # +course: the parameters of the course
  # Return: adds record to database
  def create_fee_link(fee, course)
    unless @student_types.nil?
      student = @student_types.find { |h| h[:name] == fee[0].strip }
    end
    # If there is no student type matching name on fee
    # Create one and add it to student types array
    if student.nil?
      student = StudentType.create(name: fee[0].strip)
      @student_types << student
    end

    # create a new fee and add it to the fees array
    Fee.create(course: course, student_type: student,
               fee: fee[1], time_period: fee[2])
  end

  # This method it used to update an existing course if necessary
  # +course: the parameters of the course being checked
  # +old_course: the old course being updated
  # Return: Update existing database records
  def update_course(course, old_course)
    course_inst = @institutions.find { |hash| hash[:name] == course[:provider] }
    # Call the update record method
    update_record(course, old_course, course_inst)

    # For each of the course requirements, update the records
    course[:requirements].each do |entry_requirement|
      update_entry_reqs(entry_requirement, old_course[:id])
    end

    # For each of the course fees, update the records
    course[:fees].each do |fee|
      update_fees(fee, old_course[:id])
    end
  end

  # Method to update existing entry requirements for a course
  # +entry_requirement: One of the entry_requirements for the course
  # +old_course_id: The ID of the course being updated
  # Return: add/update database records for entry requirements
  def update_entry_reqs(entry_requirement, old_course_id)
    # Find incoming qualification based on entry_req
    # If none exists, then create it and add it to the array
    qual = @incoming_quals.find{ |hash| hash[:name] == entry_requirement[0] }
    if qual.nil?
      qual = IncomingQualification.create(name: entry_requirement[0])
      @incoming_quals << qual
    end

    # Find the entry_requirement based on course and incoming qualification
    entry_req = @entry_reqs.find { |h| h[:course_id] == old_course_id && h[:incoming_qualification_id] == qual[:id]}
    # If an entry requirement exists, then update if necessary
    # Else create a new one
    if !entry_req.nil?
      @entry_reqs.delete_if { |hash| hash[:id] == entry_req[:id] }
      if entry_req[:grade] != entry_requirement[1] ||
         entry_req[:info] != entry_requirement[2]
        new = EntryRequirement.find_by(id: entry_req[:id])
        new.update(grade: entry_requirement[1], info: entry_requirement[2])
        # Update entry_reqs array be deleting old and adding new entry_req
      else
        entry_req
      end
    else
      # Create new entry_requirement and add to entry_reqs array
      EntryRequirement.create(course_id: old_course_id,
                              incoming_qualification: qual,
                              grade: entry_requirement[1],
                              info: entry_requirement[2])
    end
  end

  # Method to update fees for an existing course
  # +fee: the fee being checked
  # +course_id: the ID of the course the fee is associated with
  # Return: Add records to database or update existing
  def update_fees(fee, course_id)
    # Check student type, if none exists then create it and add to student array
    student = @student_types.find{ |hash| hash[:name] == fee[0] }
    if student.nil?
      student = StudentType.create(name: fee[0])
      @student_types << student
    end

    # Find fee from array of fees
    f = @fees.find { |hash| hash[:course_id] == course_id && hash[:student_type_id] == student[:id] }
    # If one exists, then update it, else create a new one and add to fee array
    if !f.nil?
      vals = {id: f[:id], fee: f[:fee], time_period: f[:time_period]}
      update_fee(vals, fee[1], fee[2])
    else
      Fee.create(course: old_course, student_type: student,
                 fee: fee[1], time_period: fee[2])
    end
  end

  # Method to update an existing course record if necessary
  # +course: the new course being added
  # +old_course: the old course being checked
  # +course_inst: The institute of the courses
  # Returns nothing if no update necessary, or returns new course if updated
  def update_record(course, old_course, course_inst)
    # Get end_qualification, full_time, length, and department fields
    end_qual = end_qual_check(course)
    full_time = full_time_check(course[:study_mode])
    length = extract_length(course[:duration])
    department = department_check(course, course_inst[:id])
    # If any field of the new course does not match the old course
    # then update the old course
    if old_course[:name] != course[:name] ||
       old_course[:end_qualification_id] != end_qual[:id] ||
       old_course[:institute_url] != course[:provider_url] ||
       old_course[:description] != course[:description] ||
       old_course[:full_time] != full_time ||
       old_course[:location] != course[:location] ||
       old_course[:start_date] != course[:start_date] ||
       old_course[:length] !=  length ||
       old_course[:department_id] != department[:id] ||
       old_course[:entry_requirements_info] != course[:requirements_info] ||
       old_course[:notes] != course[:notes] ||
       old_course[:fees_info] != course[:fees_info] ||
       old_course[:code] != course[:course_code]
      # find the record and updated it
      record = Course.find_by(id: old_course)
      record.update(name: course[:name],
                    end_qualification_id: end_qual[:id],
                    institute_url: course[:provider_url],
                    description: course[:description],
                    full_time: full_time,
                    location: course[:location],
                    start_date: course[:start_date],
                    length: length,
                    department_id: department[:id],
                    entry_requirements_info: course[:requirements_info],
                    notes: course[:notes],
                    fees_info: course[:fees_info],
                    code: course[:course_code])
      # Update the courses array by removing the old course and adding the new
    end
    @courses.delete_if { |hash| hash[:id] == old_course[:id] }
  end

  # This method will update an existing fee is necessary
  # +fee: the old fee parameters
  # +fee_val: the new fee value
  # +time: the new fee duration
  # returns either existing fee, or updated fee
  def update_fee(fee, fee_val, time)
    # If fee does not match new parameters, then update. Else return existing
    @fees.delete_if { |hash| hash[:id] == fee[:id] }
    if fee[:fee].to_s != fee_val || fee[:time_period] != time
      updated = Fee.find_by(id: fee[:id])
      updated.update(fee: fee_val, time_period: time)
      # append fees array by removing old fee and adding new fee
    else
      fee
    end
  end

  # Extract the length of the course in years
  # +course_d: The course duration field
  # Return course duration in years
  def extract_length(course_d)
    # downcase duration, split on spaces, take first value and convert to float
    duration = course_d.downcase
    years = duration.split(' ')[0].to_f
    # Divide by 12 if duration includes the word 'months'
    years /= 12 if duration.include? 'months'
    # Then round to an integer and return
    years.round.to_i
  end

  # Check if the course is full or part time
  # +course_s: the course study mode text
  # returns either 'false' or 'full' depending on study mode
  def full_time_check(course_s)
    # if no study mode provided, return false
    return true if course_s.nil?

    # else return boolean if course_s contains the word 'full'
    !course_s.downcase.include? 'part'
  end

  # Get the end qualification of the course.
  # +course: the course being checked
  # Will either return existing, or create a new end qualification
  def end_qual_check(course)
    end_qual = @end_quals.find { |hash| hash[:name] == course[:qualification] }
    return end_qual unless end_qual.nil?

    new_qualification = EndQualification.new(name: course[:qualification])
    # add new qualification to 'end_quals' array
    @end_quals << new_qualification
    return new_qualification if new_qualification.save!
  end

  # Check the department of the course
  # This will return either a new department, updated department, or existing
  # department.
  # +course: the course being checked
  # +course_institution: The institution associated with that courses
  # These parameters are used in conjunction to find the department or create
  # a new one.
  # Return department information
  def department_check(course, course_institution)
    # get department name or create proxy one
    dep_name = course[:department]
    if course[:department].nil? || course[:department] == ''
      dep_name = course[:provider] + 'ProxyDepartment'
    end
    # check if department exists
    course_dep = @departments.find do |hash|
      hash[:name] == dep_name &&
        hash[:institution_id] == course_institution
    end

    # if department does not exist, then create it. Else update it
    if course_dep.nil?
      new_dep = new_department(course, dep_name, course_institution)
      # add new department to department array
      @departments << new_dep
      return new_dep
    else
      # store course params in a hash to speed up process
      vals = { phone_number: course_dep[:phone_number],
               email: course_dep[:email],
               id: course_dep[:id],
               name: course_dep[:name] }
      # Update the department and return it once done
      update = update_department(vals, course[:contact_number],
                                 course[:email])
      return update
    end
  end

  # Update a department if necessary.
  def update_department(course_dep, contact, email)
    # check if the department is actually different. If so, update, else return
    # existing department
    if course_dep[:phone_number] == contact && course_dep[:email] == email
      course_dep
    else
      dep = Department.find_by(id: course_dep[:id])
      dep.update(phone_number: contact, email: email)
      # Update the departments array by removing old one and appending new one
      @departments.delete_if { |hash| hash[:id] == course_dep }
      @departments << dep
      dep
    end
  end

  # Create a new department. If a name exists, then add relevant fields.
  # if no department name exists, then create proxy department
  def new_department(course, dep_name, institution)
    if !course[:department].nil?
      new_department = Department.new(name: dep_name,
                                      phone_number: course[:contact_number],
                                      email: course[:email],
                                      institution_id: institution)

    else
      new_department = Department.new(name: dep_name,
                                      institution_id: institution)
    end

    return new_department if new_department.save!
  end
end
