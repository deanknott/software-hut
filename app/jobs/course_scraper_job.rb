class CourseScraperJob < ApplicationJob
  queue_as :default

  def perform
    Imports::Scraper.new
  end
end
