# frozen_string_literal: true

# This is the importer class
class Imports::StoredSearch
  def new
    initialize
  end

  def initialize
    @institutions = Institution.all.to_a

    @inst_id = 1
    unless Institution.order('id DESC').first.nil?
      @inst_id = Institution.order('id DESC').first.id + 1
    end
  end

  # The stored search function
  def stored_search
    success_search = []
    StoredSearch.all.each do |ss|
      search_params = { email: ss.email, subject: ss.name,
                        institution: ss.institution, full_time: ss.full_time,
                        duration: ss.length, distance: ss.distance,
                        location: ss.location,
                        updated: ss.updated_at} #The last time this ss checked for courses.
      ss.update()
      c = CourseSearcher.new(search_params).search_courses
      if !c.nil?
        success_search.append(ss)
      end
    end
    #Need to email for allll of the searches done.
    #StoredSearchMailer.new_courses_email(search).deliver
    success_search.each_slice(50) do |search|
      StoredSearchMailer.new_courses_email(search).deliver
    end
  end
end
