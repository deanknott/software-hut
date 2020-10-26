# frozen_string_literal: true

# This function will run and seed all data contained in the subfolders
# of the 'seeds' directory.
Dir[File.join(Rails.root, 'db', 'seeds/*', '*.rb')].sort.each do |seed|
  load seed
end



web_admin_r = Role.where(name: 'Website Admin').first_or_create
uni_admin_r = Role.where(name: 'University Admin').first_or_create
member_r = Role.where(name: 'Member').first_or_create
pending_r = Role.where(name: 'Pending').first_or_create

everyone = Privacy.where(level: 'Everyone').first_or_create
member_only = Privacy.where(level: 'Members Only').first_or_create
only_me = Privacy.where(level: 'Only Me').first_or_create


e_acc = AccountPrivacy.where(privacy_level: 'Everyone').first_or_create



# Widening Participations
wp1 = Wp.where(wp_type: 'Low Income Background').first_or_create
wp2 = Wp.where(wp_type: 'Black, Asian, and Minority Ethnic (BAME)').first_or_create
wp3 = Wp.where(wp_type: 'Other').first_or_create

# Student Types
st1 = StudentType.where(name: 'England').first_or_create
st2 = StudentType.where(name: 'Wales').first_or_create
st3 = StudentType.where(name: 'Scotland').first_or_create
st4 = StudentType.where(name: 'Northern Ireland').first_or_create
st5 = StudentType.where(name: 'Channel Islands').first_or_create
st6 = StudentType.where(name: 'EU').first_or_create
st7 = StudentType.where(name: 'International').first_or_create

# Incoming Qualifications
iq1 = IncomingQualification.where(name: 'GCSE/National 4/National 5').first_or_create
iq2 = IncomingQualification.where(name: 'UCAS Tariff').first_or_create
iq3 = IncomingQualification.where(name: 'A level').first_or_create
iq4 = IncomingQualification.where(name: 'Scottish Higher').first_or_create

# End Qualifications
eq1 = EndQualification.where(name: 'Master of Mathematics - MMath').first_or_create
eq2 = EndQualification.where(name: 'Bachelor of Law - LLB').first_or_create
eq3 = EndQualification.where(name: 'Bachelor of Science (with Honours) - BSc (Hons)').first_or_create
eq4 = EndQualification.where(name: 'Bachelor of Midwifery (with Honours) - BMid (Hon)').first_or_create
eq5 = EndQualification.where(name: 'Master of Pharmacy - MPharm').first_or_create

# Delivery Modes
dm1 = DeliveryMode.where(name: 'Online').first_or_create
dm2 = DeliveryMode.where(name: 'One to One').first_or_create
dm3 = DeliveryMode.where(name: 'Lectures').first_or_create

# Example insitututions
test_inst1 = Institution.where(name: 'Test Institution 1')
                        .first_or_create(website: 'www.example.example',
                                         phone_number: '11111111111',
                                         email: 'test@test1.ac.uk')
test_inst2 = Institution.where(name: 'Test Institution 2')
                        .first_or_create(website: 'www.example.example',
                                         phone_number: '22222222222',
                                         email: 'test@test2.ac.uk')

# A regular member for institute 1
reg_member1 = Member.where(name: 'John Smith')
                    .first_or_create(title: 'Mr', name: 'John Smith',
                                     job: 'lecturer', bio: 'test bio',
                                     institution_id: test_inst1.id,
                                     role_id: member_r.id,
                                     account_privacy_id: e_acc.id,
                                     bio_privacy_id: everyone.id,
                                     job_privacy_id: everyone.id,
                                     email_privacy_id: everyone.id)
User.where(email: 'jsmith@test1.ac.uk')
    .first_or_create(password: 'Password123',
                     password_confirmation: 'Password123',
                     last_sign_in_at: Time.now, member_id: reg_member1.id)

# A regular member with their privacy set to members only
reg_member2 = Member.where(name: 'Jane Doe')
                    .first_or_create(title: 'Mrs', name: 'Jane Doe',
                                     job: 'philosophy lecturer',
                                     bio: 'This is an example <b>biography</b>',
                                     institution_id: test_inst2.id,
                                     role_id: member_r.id,
                                     account_privacy_id: e_acc.id,
                                     bio_privacy_id: member_only.id,
                                     job_privacy_id: member_only.id,
                                     email_privacy_id: member_only.id)
User.where(email: 'jdoe@test2.ac.uk')
    .first_or_create(password: 'Password123',
                     password_confirmation: 'Password123',
                     last_sign_in_at: Time.now, member_id: reg_member2.id)

# A university admin for institue 1
uni_admin1 = Member.where(name: 'Arthur Morgan')
                   .first_or_create(title: 'Mr', name: 'Arthur Morgan',
                                    job: 'admissions officer',
                                    bio: 'This is an example <b>biography</b>',
                                    institution_id: test_inst1.id,
                                    role_id: uni_admin_r.id,
                                    account_privacy_id: e_acc.id,
                                    bio_privacy_id: everyone.id,
                                    job_privacy_id: everyone.id,
                                    email_privacy_id: everyone.id)
User.where(email: 'AMorgan@test1.ac.uk')
    .first_or_create(password: 'Password123',
                     password_confirmation: 'Password123',
                     last_sign_in_at: Time.now, member_id: uni_admin1.id)

# A university Admin for institute 2
uni_admin2 = Member.where(name: 'Jim Milton')
                   .first_or_create(title: 'Mr', name: 'Jim Milton',
                                    job: 'Head of Urban Planning',
                                    bio: 'This is an example <b>biography</b>',
                                    institution_id: test_inst2.id,
                                    role_id: uni_admin_r.id,
                                    account_privacy_id: e_acc.id,
                                    bio_privacy_id: everyone.id,
                                    job_privacy_id: everyone.id,
                                    email_privacy_id: everyone.id)
  User.where(email: 'JMilton@test2.ac.uk')
      .first_or_create(password: 'Password123',
                       password_confirmation: 'Password123',
                       last_sign_in_at: Time.now, member_id: uni_admin2.id)

# The overall web admin account
web_admin = Member.where(name: 'Website Admin')
                  .first_or_create(title: 'Mr', name: 'Website Admin',
                                   job: 'Website Admin',
                                   bio: 'This is the website admin',
                                   institution_id: test_inst1.id,
                                   role_id: web_admin_r.id,
                                   account_privacy_id: e_acc.id,
                                   bio_privacy_id: only_me.id,
                                   job_privacy_id: only_me.id,
                                   email_privacy_id: only_me.id)

User.where(email: 'admin@test1.ac.uk')
    .first_or_create(password: 'Password123',
                     password_confirmation: 'Password123',
                     last_sign_in_at: Time.now, member_id: web_admin.id)

if Rails.env == 'test'
Blog.where(name: 'A Test Blog', content: 'Test Content',
           member_id: reg_member1.id, privacy_id: everyone.id,
           created_at: DateTime.now.midnight,
           updated_at: DateTime.now.midnight + 1.hour).first_or_create
Blog.where(name: 'Z Test Blog', content: 'Test',
           member_id: reg_member1.id, privacy_id: everyone.id,
           created_at: DateTime.now.midnight + 1.day,
           updated_at: DateTime.now.midnight + 1.hour).first_or_create
Blog.where(name: 'Member Only Blog', content: 'Member Only Blog',
           member_id: reg_member1.id, privacy_id: member_only.id,
           created_at: DateTime.now.midnight,
           updated_at: DateTime.now.midnight + 1.hour).first_or_create
# Institutions
inst1 = Institution.where(name: 'Aberystwyth University',
                          website: 'https://www.aber.ac.uk',
                          phone_number: '01970 622021',
                          email: 'ug-admissions@aber.ac.uk').first_or_create

inst2 = Institution.where(name: 'University of Hull',
                          website: '',
                          phone_number: '',
                          email: '').first_or_create

# Departments
dep1 = Department.where(name: 'Department of Mathematics (undergraduate enquiries)',
                        phone_number: '+44 (0)1970 622802',
                        email: 'maths@aber.ac.uk',
                        url: 'maths@aber.ac.uk',
                        institution_id: inst1.id).first_or_create

dep2 = Department.where(name: 'Main Contact',
                        phone_number: 'Main Contact',
                        email: '',
                        url: nil,
                        institution_id: inst2.id).first_or_create

# Courses - create course first, then create entries in courses_wps, entry_requirements, fees
course1 = Course.where(name: 'Mathematics (includes foundation year)',
                       department_id: dep1.id,
                       description: 'Our Mathematics degree helps you to discover a subject that is fundamentally important to modern society.',
                       delivery_mode_id: dm3.id,
                       full_time: true,
                       location: 'Main Site (Aberystwyth)',
                       length: 4,
                       ucas_url: 'https://digital.ucas.com/courses/details?coursePrimaryId=dbf392f4-386e-e565-d4d2-12f956fb8287&academicYearId=2019',
                       notes: '',
                       end_qualification_id: eq1.id,
                       created_at: DateTime.now.midnight,
                       updated_at: DateTime.now.midnight + 1.hour,
                       institute_url: 'https://courses.aber.ac.uk/undergraduate/mathematics-degree-with-foundation-year/',
                       start_date: '23 September 2019',
                       code: 'G10F',
                       entry_requirements_info: 'This course, which includes a foundation year, is specifically designed to provide an alternative route into higher education',
                       fees_info: 'Based on the latest information available to us').first_or_create

c1wp1 = CoursesWp.where(course_id: course1.id,
                        wp_id: wp2).first_or_create

c1er1 = EntryRequirement.where(course_id: course1.id,
                               incoming_qualification_id: iq1.id,
                               grade: 'A minimum grade C or grade 4 pass is a',
                               info: '').first_or_create

c1er2 = EntryRequirement.where(course_id: course1.id,
                               incoming_qualification_id: iq3.id,
                               grade: 'AAA',
                               info: 'We may consider those with lower results.').first_or_create

c1f1 = Fee.where(course_id: course1.id,
                 student_type_id: st1.id,
                 fee: 9000,
                 time_period: 'Year 1').first_or_create

c1f2 = Fee.where(course_id: course1.id,
                 student_type_id: st2.id,
                 fee: 9000,
                 time_period: 'Year 1').first_or_create

c1f3 = Fee.where(course_id: course1.id,
                 student_type_id: st3.id,
                 fee: 9000,
                 time_period: 'Year 1').first_or_create

c1f4 = Fee.where(course_id: course1.id,
                 student_type_id: st6.id,
                 fee: 13600,
                 time_period: 'Year 1').first_or_create

course2 = Course.where(name: 'Midwifery with Foundation Year',
                       department_id: dep2.id,
                       description: '.',
                       delivery_mode_id: dm1.id,
                       full_time: false,
                       location: 'Manchester Study Centre',
                       length: 5,
                       ucas_url: 'https://digital.ucas.com/courses/details?CoursePrimaryId=0dbaf152-9ff5-4052-8d5c-541ec273f988&CourseOptionId=106a7548-35f0-46ee-bbdf-0ff985952b9f',
                       notes: 'Modules\nThe modules you will',
                       end_qualification_id: eq5.id,
                       created_at: DateTime.now.midnight,
                       updated_at: DateTime.now.midnight + 1.hour,
                       institute_url: 'https://arden.ac.uk/our-courses/blended-learning/undergraduate/business-degree/ba-hons-business?utm_source=UCAS&utm_medium=Email&utm_campaign=UCAS18&utm_content=UCAS18',
                       start_date: 'October 2019',
                       code: 'N401',
                       entry_requirements_info: '',
                       fees_info: 'Whole course: £27,000').first_or_create

# A university admin for Aber...
uni_admin_aber = Member.where(name: 'Robert Robertson')
                   .first_or_create(title: 'Mr', name: 'Robert Robertson',
                                    job: 'admissions officer',
                                    bio: 'This is an example <b>biography</b>',
                                    institution_id: inst1.id,
                                    role_id: uni_admin_r.id,
                                    account_privacy_id: e_acc.id,
                                    bio_privacy_id: everyone.id,
                                    job_privacy_id: everyone.id,
                                    email_privacy_id: everyone.id)
User.where(email: 'RRobertson@test1.ac.uk')
    .first_or_create(password: 'Password123',
                     password_confirmation: 'Password123',
                     last_sign_in_at: Time.now, member_id: uni_admin_aber.id)
end
