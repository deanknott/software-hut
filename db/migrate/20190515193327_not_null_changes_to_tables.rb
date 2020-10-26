class NotNullChangesToTables < ActiveRecord::Migration[5.2]
  def change
    # account privacy table
    change_column_null :account_privacies, :privacy_level, false

    # blogs table
    change_column_null :blogs, :name, false
    change_column_null :blogs, :content, false
    change_column_null :blogs, :member_id, false
    change_column_null :blogs, :privacy_id, false

    # courses table
    change_column_null :courses, :code, false
    change_column_null :courses, :name, false

    # departments Table
    change_column_null :departments, :name, false

     # deliver mode table
     change_column_null :delivery_modes, :name, false
    # eligibility requirements table
    change_column_null :eligibility_requirements, :name, false

    # end qualification table
    change_column_null :end_qualifications, :name, false

    # entry requirements table
    change_column_null :entry_requirements, :grade, false
    change_column_null :entry_requirements, :course_id, false
    change_column_null :entry_requirements, :incoming_qualification_id, false

    # fees table
    change_column_null :fees, :fee, false
    change_column_null :fees, :student_type_id, false
    change_column_null :fees, :course_id, false

    # incoming qualifications table
    change_column_null :incoming_qualifications, :name, false

    # institutions table
    change_column_null :institutions, :name, false

    # members table
    change_column_null :members, :account_privacy_id , false
    change_column_null :members, :bio_privacy_id, false
    change_column_null :members, :email_privacy_id, false
    change_column_null :members, :institution_id, false
    change_column_null :members, :job_privacy_id, false
    change_column_null :members, :role_id, false

    # privacies table
    change_column_null :privacies, :level, false
    # roles table
    change_column_null :roles, :name, false

    # static pages table
    change_column_null :static_pages, :name, false
    change_column_null :static_pages, :contents, false

    #stored search table
    change_column_null :stored_searches, :email, false

    # student type table
    change_column_null :student_types, :name, false

    # users table
    change_column_null :users, :member_id, false
    # widening participation table
    change_column_null :wps, :wp_type, false
  end
end
