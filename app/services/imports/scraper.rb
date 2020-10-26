class Imports::Scraper

  def initialize
    @all_providers = Array.new
    @all_courses = Array.new
    @all_ucas_urls = Array.new
    @base_url = 'https://digital.ucas.com'
    @start_time = Time.new
    HTTParty::Basement.default_options.update(verify: false)
    start_scrape
  end

  # Display start and end times for that section
  def display_times
    puts "Start Time: #{@start_time}"
    puts "End Time: #{Time.new}"
  end

  # Run the Scraper
  def start_scrape
    scrape_ids
    scrape_course_ucas_urls
    scrape_course_info
    display_times
    import
  end

  # scrape pages for the IDs of the providers.
  # IDs are used in second scraping url
  def scrape_ids
    page_url = "https://digital.ucas.com/search/results?SearchText=foundation+year&SubjectText=&ProviderText=&AutoSuggestType=&SearchType=&SortOrder=ProviderAtoZ&PreviouslyAppliedFilters=SH_3_UCAS+Conservatoires__QM_2_Bachelor+degrees+(with+or+without+Honours)__QM_1_Masters+degrees__&AcademicYearId=2019&ClearingOptOut=False&vacancy-rb=rba&filters=Destination_Undergraduate&filters=QualificationMapped_Bachelor+degrees+(with+or+without+Honours)&filters=QualificationMapped_Masters+degrees&DistanceFromPostcode=1mi&RegionDistancePostcode=&CurrentView=Provider&__RequestVerificationToken=mfmFi3xLLswWlC7EMDoZrwxo5DWYxKarqcKC6Xr1gDYo6PzGVdl8SvMXQ9zVWEQfqqD5bSnZHrPLKuglkceJqhpvSVMXE_SZb4Ofwkhpjf41"
    unparsed_page = HTTParty.get(page_url)
    parsed_page = Nokogiri::HTML(unparsed_page)

    total_providers = parsed_page.css('[class="search-results__count hide-element--to-medium"]').text.split[-2].to_i
    providers_per_page = parsed_page.css('[class="accordion__label"]').count.to_f
    page = 1
    last_page = (total_providers/providers_per_page).ceil
    while page <= last_page
      page_url = "https://digital.ucas.com/search/results?SearchText=foundation+year&SubjectText=&ProviderText=&AutoSuggestType=&SearchType=&SortOrder=ProviderAtoZ&PreviouslyAppliedFilters=QM_0_Masters+degrees__&AcademicYearId=2019&ClearingOptOut=False&vacancy-rb=rba&filters=Destination_Undergraduate&SubjectText=&filters=QualificationMapped_Bachelor+degrees+%28with+or+without+Honours%29&filters=QualificationMapped_Masters+degrees&DistanceFromPostcode=1mi&RegionDistancePostcode=&CurrentView=Provider&__RequestVerificationToken=Q1dB0fS_QUi_VlSFqALLL5TDQy385UPk0J4oHL_8aCTalPfN1sctXoCPMROstOf2EbHQJlbkJHfiLisqEF1qnaMsEFMf3EdFoUPKtqWx-Nc1&pageNumber=#{page}"
      unparsed_page = HTTParty.get(page_url)
      parsed_page = Nokogiri::HTML(unparsed_page)
      page_providers = parsed_page.css('h3.accordion__label')
      page_providers.each do |page_provider|
        provider = {
          name: page_provider.children[0].text.strip,
          id: page_provider.attributes['data-provider-id'].value,
          website: '',
          number: '',
          email: '',
          courses: Array.new
        }
        @all_providers << provider
      end
      page += 1
    end
  end

  # Writes all of the provider's names and IDs to a text file
  def write_providers
    begin
      file = File.open('providers.text', 'w')

      @all_providers.each do |provider|
        file.write(provider[:name] + "\n")
        file.write(provider[:id] + "\n")
        file.write(provider[:website] + "\n")
        file.write(provider[:number] + "\n")
        file.write(provider[:email] + "\n")
        file.write("\n")
      end
    ensure
      file.close unless file.nil?
    end
  end

  # Insert IDs in the url to get a list of all foundation years offered by the provider
  def scrape_course_ucas_urls
    @all_providers.each do |provider|
      id = provider[:id]
      page_url = "https://digital.ucas.com/search/results?SearchText=foundation+year&SubjectText=&SubjectText=&ProviderText=&ProviderText=&AutoSuggestType=&SearchType=&SortOrder=ProviderAtoZ&PreviouslyAppliedFilters=QM_0_Bachelor+degrees+(with+or+without+Honours)__&AcademicYearId=2019&ClearingOptOut=False&vacancy-rb=rba&filters=Destination_Undergraduate&filters=QualificationMapped_Bachelor+degrees+(with+or+without+Honours)&filters=QualificationMapped_Masters+degrees&UcasTariffPointsMin=0&UcasTariffPointsMax=144%2b&DistanceFromPostcode=1mi&RegionDistancePostcode=&CurrentView=Provider&__RequestVerificationToken=I4o0CAJi6qu_cPwc_8yGJYYEB1xPNnzrUoNUP14zJG-pDp-DXp9nZbEb4DJxWqCkT6XyZhsyCaovoLeFlQX24enN3zaLRVkgfvT87YXQsOY1&pageNumber=3&GroupByProviderId=#{id}&GroupByDestination=Undergraduate&GroupByFrom=0&GroupBySize=5000"
      unparsed_page = HTTParty.get(page_url)
      parsed_page = Nokogiri::HTML(unparsed_page)
      tables = parsed_page.css('table.open')
      table_titles = tables.css('tr[1] > th').text
      table_text = tables.css('tr > td').text
      raw_name = tables.css('tr > th').text
      page_courses = parsed_page.css('a.course-summary')
      page_courses.each do |page_course|
        provider[:courses] << @base_url + page_course.attributes["href"].value
      end
    end
  end

  # for each course, pass the ucas url and parsed page to add_courses
  def scrape_course_info
    counter = 1
    @all_providers.each do |provider|

      provider[:courses].each do |url|
        unparsed_page = HTTParty.get(url)
        parsed_page = Nokogiri::HTML(unparsed_page)

        # try to scrape provider info from course pages
        if (provider[:website].empty? || provider[:number].empty? || provider[:email].empty?)
          provider[:website] = parsed_page.css('[id="ProviderWebsite"]').text
          if !parsed_page.css('[id="contact_Phone"]')[-1].nil?
            provider[:number] = parsed_page.css('[id="contact_Phone"]')[-1].text
          end
          if !parsed_page.css('[class="contact-email"]')[-1].nil?
            provider[:email] = parsed_page.css('[class="contact-email"]')[-1].text
          end
        end

        # pages with multiple options have to be treated differently
        options = parsed_page.css('a.academic-year-link-active').children[1].text.strip[0..1].strip

        # get each option's url, parse it, then pass the url and parsed page to add_courses
        if !(options.eql? "1")
          options = parsed_page.css("[class='course-option course-option--link']")
          option_urls = Array.new
          options.each do |option|
            option_urls << @base_url ++ option.attributes["href"].value
          end
          option_urls.each do |option_url|
            unparsed_option_page = HTTParty.get(option_url)
            parsed_option_page = Nokogiri::HTML(unparsed_option_page)
            add_courses(option_url, counter, parsed_option_page)
          end
        end

        # if only one option, pass straight to add_courses
        if (options.eql? "1")
          add_courses(url, counter, parsed_page)
        end

        counter += 1
        #if counter >10
        #  break
        #end
      end
      #if counter >10
      #  break
      #end
    end
  end

  # gets the given course's information and appends it to the array of all courses
  def add_courses(url, counter, parsed_page)
    all_paragraphs = parsed_page.xpath '//p' # all <p> on the page
    paragraph_number = 8 # The description paragraph for most pages

    # get the course's description
    course_description = ""
    while !all_paragraphs[paragraph_number].text.eql? "Qualification" do
      course_description += all_paragraphs[paragraph_number].text.strip
      course_description += "\n\n"
      paragraph_number += 1
    end
    # some pages are set up differently
    if course_description.empty?
      course_description = all_paragraphs[7].text
    end
    course_description = course_description.strip

    # if it exists, get the provider's url for the course
    provider_url = ""
    if !parsed_page.at_css('[id="ProviderCourseUrl"]').nil?
      provider_url = parsed_page.at_css('[id="ProviderCourseUrl"]').attributes["href"].value
    end

    department = ""
    if !parsed_page.css('span').css('[id="contact_Title"]')[0].nil?
      department = parsed_page.css('span').css('[id="contact_Title"]')[0].text
    end

    email = ""
    if !parsed_page.at_css('.contact-email').nil?
      #email = parsed_page.at_css('.contact-email').attributes["href"].value
      email = parsed_page.css('[class="contact-email"]')[0].text.strip
    end

    # if a contact exists then
    contact = ""
    if !parsed_page.at_css('[id="contact_Phone"]').nil?
      contact = parsed_page.at_css('[id="contact_Phone"]').text
    end

    # Entry requirements [[Exam type, Grade/Mark, Info]]
    requirements = Array.new
    requirements_section = parsed_page.at_css('[id="entry-requirements-section"]')
    requirements_rows = requirements_section.css('tr').drop(1)
    requirements_rows.each do |row|
      row_info = Array.new
      row_info << row.css('th').text.strip
      row.css('td').each do |col|
        row_info << col.text.strip
      end
      if row_info.count == 2
        row_info << ""
      end
      requirements << row_info
    end

    # extract additional entry requirements info
    requirements_info = ""
    requirements_section.css('p').each do |p|
      requirements_info += p.text.strip
      requirements_info += "\n"
    end
    requirements_info += requirements_section.css('a').text.strip
    requirements_info = requirements_info.strip

    # entry points for the course
    entry_points = Array.new
    parsed_page.at_css('[id="howToApply"]').parent.css('li').each do |row|
      entry_points << row.text.strip
    end

    # fees info [[student type, fee, fee period]]
    fees = Array.new
    empty_fees_message = "No fee information has been provided for this course"
    empty_fees_scraped_message = parsed_page.at_css('[id="feesAndFunding"]').parent.children[3].children[2].text.strip
    if !(empty_fees_scraped_message.eql? empty_fees_message)
      fees_table = parsed_page.css('[class="table-responsive table-responsive--list table-borderless table-col1-bold"]')[-1].children[1]
      fees_rows = fees_table.css('tr').count
      fees = Array.new(fees_rows){Array.new(3)}
      (0...fees_rows).each do |row_number|
        row_info = fees_table.css('tr')[row_number]
        fees[row_number][0] = row_info.css('td')[0].text
        fees[row_number][1] = row_info.css('td')[1].text.split("\u00A3")[1].split[0].tr(',','')
        fees[row_number][2] = row_info.css('td')[2].text
      end
    end

    # extract additional fees info
    fees_sections = parsed_page.at_css('[id="feesAndFunding"]').parent.css('section').drop(1)
    fees_info = ""
    fees_sections.each do |section|
      paragraph = section.css('div').text.strip
      if paragraph.empty?
        paragraph = section.css('p').text.strip
      end
      fees_info += paragraph
    end
    fees_info = fees_info.strip

    delivery = ""
    if parsed_page.css('p').text.eql? "lectures"
      delivery = parsed_page.css('p').text.strip
    end

    notes = ""
    if !parsed_page.css('[id="courseDetails"]').empty?
      notes_sections = parsed_page.at_css('[id="courseDetails"]').parent.css('section')
      notes_sections.each do |section|
        #notes += "[h3]"+section.css('h3').text.strip + "[/h3]\n\n"
        notes += section.text.strip + "\n\n"
      end
    end


    # course object with all of the scraped info
    course = {
      name: parsed_page.css('h1.search-result__result-provider').children[0].text.strip,
      qualification: all_paragraphs[paragraph_number+1].text,
      provider: parsed_page.css('h1.search-result__result-provider').children[1].text.strip,
      provider_url: provider_url,
      ucas_url: url,
      description: course_description,
      study_mode: all_paragraphs[paragraph_number+3].text.strip,
      location: all_paragraphs[paragraph_number+5].text.strip,
      start_date: all_paragraphs[paragraph_number+7].text.strip,
      duration: all_paragraphs[paragraph_number+9].text.strip,
      entry_points: entry_points,
      department: department,
      contact_number: contact,
      email: email,
      requirements: requirements,
      requirements_info: requirements_info,
      fees: fees,
      fees_info: fees_info,
      institution: parsed_page.css('td[id="institution-code"]').text,
      course_code: parsed_page.css('td[id="application-code"]').text,
      delivery: delivery,
      notes: notes
    }

    puts "Course #{counter}: #{course[:name]} #{course[:provider]}"#, delivery: #{course[:delivery]}"
    @all_courses << course
  end

  # Writes all courses to text file
  def write_courses
    begin
      file = File.open('courses.text', 'w')

      @all_courses.each do |course|
        file.write("Name: " + course[:name] + "\n")
        file.write("Qualification: " + course[:qualification] + "\n")
        file.write("Provider: " + course[:provider] + "\n")
        file.write("Provider URL: " + course[:provider_url] + "\n")
        file.write("UCAS URL: " + course[:ucas_url] + "\n")
        file.write("Description: " + course[:description] + "\n")
        file.write("Study Mode: " + course[:study_mode] + "\n")
        file.write("Location: " + course[:location] + "\n")
        file.write("Start Date: " + course[:start_date] + "\n")
        file.write("Duration " + course[:duration] + "\n")

        file.write("Entry Points: " + "\n")
        course[:entry_points].each do |row|
          file.write("              " + row + "\n")
        end

        file.write("Entry Requirements: " + "\n")
        course[:requirements].each do |row|
          file.write("                 ")
          row.each do |col|
            file.write("   " + col)
          end
          file.write("\n")
        end

        file.write("Additional Entry Requirements Info: " + course[:requirements_info] + "\n")
        file.write("Fees : " + "\n")
        course[:fees].each do |row|
          file.write("       " + row[0].to_s + "   " + row[1].to_s + "   " + row[2].to_s + "\n")
        end

        file.write("Additional Fees Info: " + course[:fees_info] + "\n")
        file.write("Institution Code " + course[:institution] + "\n")
        file.write("Course Code: " + course[:course_code] + "\n")
        file.write("Department: " + course[:department] + "\n")
        file.write("Contact number: " + course[:contact_number] + "\n")
        file.write("Email address: " + course[:email])
        file.write("\n")
      end
    ensure
      file.close unless file.nil?
    end
  end



  # Begin Importing
  def import
    importer = Imports::InstituteImporter.new
    @all_providers.each do |provider|
      importer.import_institution(provider)
    end

    display_times
    @start_time = Time.new

    importer = Imports::Importer.new
    count = @all_courses.count
    @all_courses.each do |course|
      start = Time.new
      importer.import_course(course)
      current = @all_courses.find_index(course) + 1
      puts 'Uploaded: ' + current.to_s + ' of ' +
           count.to_s + '   :::   ' + (Time.new - start).to_s + 's'
    end

    display_times
  end
end
