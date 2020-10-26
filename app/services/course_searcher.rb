# frozen_string_literal: true

# The course searcher service
class CourseSearcher
  def initialize(params)
    @params = params
  end

  def search_courses
    params = @params
    # a-z search
    unless params[:letter].nil? || params[:letter] == ''
      return Course.where('courses.name ILIKE :letter',
                          letter: params[:letter] + '%').all
    end

    # if there is a search term - then search, else return all
    name = params[:subject]
    location_name = params[:location]
    query = []
    placeholders = {}
    temp = []

    unless name.nil? || name.empty? || name ==''
      query.append('(courses.name ILIKE :name)')
      placeholders[:name] = '%' + name + '%'
    end

    unless location_name.nil? || location_name.empty? || location_name == ''
      query.append('(institutions.name ILIKE :location_name OR courses.location ILIKE :location_name)')
      placeholders[:location_name] = '%' + location_name + '%'
    end

    unless params[:institute].nil? || params[:institute] == ''
      temp.append('(institutions.name ILIKE :institute)')
      query.append(temp.join(' AND '))
      placeholders[:institute] = '%' + params[:institute] + '%'
    end

    unless params[:full_time] == '' || params[:full_time].nil?
      if params[:full_time] == '1'
        query.append('courses.full_time = \'yes\'')
      else
        query.append('courses.full_time = \'no\'')
      end
    end

    unless params[:duration] == '' || params[:duration].nil?
      query.append('courses.length = ' + params[:duration].to_s)
    end

    #unless params[:updated] == '' || params[:updated].nil?
    #  query.append('courses.updated_at > ?', params[:updated])
    #end

    if query.empty? || query.nil?
      Course.all
    else
      Course.joins(department: :institution)
            .where(query.join(' AND '), placeholders).all
    end
  end
end
