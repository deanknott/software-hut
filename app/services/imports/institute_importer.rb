# frozen_string_literal: true

# Author - Team 34
# Updated: 10/05/19

# This is the importer class
class Imports::InstituteImporter
  def new
    initialize
  end

  # Initialize instite importer
  def initialize
    @institutions = Institution.all.to_a

    @inst_id = 1
    unless Institution.order("id DESC").first.nil?
      @inst_id = Institution.order("id DESC").first.id + 1
    end
  end

  # Import the institutions. If none exists, then create one
  # Otherwise, update the existing one
  def import_institution(institution)
    # If no institute exists, then create one, else update the existing one
    if !Institution.exists?(name: institution[:name])
      new_institution(institution[:name], institution[:website],
                      institution[:number], institution[:email])
    else
      update_institution(institution[:name], institution[:website],
                         institution[:number], institution[:email])
    end
  end

  # create a new institution if needed
  # +inst_name: The name of the institute
  # +inst_site: The website address of the institute
  # +inst_number: the phone number for the institute
  # +inst_email: The email address of the institute
  # Return: Nil. Create Database Record
  def new_institution(inst_name, inst_site, inst_number, inst_email)
    Institution.transaction do
      new_institution = Institution.new(name: inst_name,
                                        website: inst_site,
                                        phone_number: inst_number,
                                        email: inst_email)
      new_institution.id = @inst_id
      @inst_id += 1 if new_institution.save!
      @institutions << new_institution
    end
  end

  # Update an exisiting institute
  # +Inst_name: the name of the Institute
  # +inst_site: the website for the institute
  # +inst_phone: the phone number for the institute
  # +inst_email: The email contact for the institute
  # Return: NIL. Updates database record.
  def update_institution(inst_name, inst_site, inst_phone, inst_email)
    old_institution = @institutions.select { |hash| hash[:name] == inst_name }.first
    if inst_name == old_institution[:name] && inst_site == old_institution[:website] &&
       inst_phone == old_institution[:phone_number] && inst_email == old_institution[:email]
      return old_institution
    else
      inst = Institution.find_by(id: old_institution[:id])
      inst.update(website: inst_site, phone_number: inst_phone,
                  email: inst_email)
      @institutions.delete_if { |hash| hash[:id] == old_institution[:id] }
      @institutions << inst
    end
  end

end
