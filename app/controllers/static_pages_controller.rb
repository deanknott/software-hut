# frozen_string_literal: true

# Author:    Team 34: Luke Peacock
# Updated:   10.03.2019

# Static pages controller
class StaticPagesController < ApplicationController
  # Before any action in this controller, ensure user is logged in for
  # also set the current page
  before_action :authenticate_user!, only: [:update_static_page]
  before_action :set_page, only: [:show, :home, :about, :edit, :update,
                                  :show_file, :download_file]

  # render the static page contents
  def show
    @current_nav_identifier = @static_page[:name]
  end

  # renderthe home page (since this page is different)
  def home
    @current_nav_identifier = :home
    params[:name] = @current_nav_identifier
    set_page
  end

  # render about page since this page contains a different route
  def about
    @current_nav_identifier = :about
    params[:name] = @current_nav_identifier
    set_page
    render 'show'
  end


  # method to save the updated record and return a mesage
  def update
    static = @static_page
    static.assign_attributes(contents: get_contents(params),
                             custom_file: get_file(params))
    if remove_file?(params)
      static.remove_custom_file!
    end
    if static.save!
      render 'update_success'
    else
      render 'update_failure'
    end
  end

  # method to download a file to the user's computer
  # all files are named 'download.extension'
  def download_file
    send_file(@static_page.custom_file.path,
              disposition: 'attachment; filename="' + @static_page.custom_file.file.filename + '"',
              type: @static_page.custom_file.file.content_type,
              url_based_filename: true)
  end

  # method to send the file to the view to be shown to the user
  def show_file
    options = { type: @static_page.custom_file.file.content_type,
                disposition: 'inline' }
    send_file @static_page.custom_file.path, options
  end

  private
  def remove_file?(params)
    if params[:name] == 'conference'
      if params[:conference][:remove_custom_file] == '1'
        true
      end
    end
  end

  # get the page contents when saving a page
  # if page is conference, then join fields, else @contents = content field
  # +params: the parameters from the update form
  def get_contents(params)
    conference = params[:conference]
    if params[:name] == 'conference'
      conference[:date] + '±' + conference[:location] + '±' +
        conference[:conf_name] + '±' + conference[:content]
    else
      params[:static_page][:contents]
    end
  end

  # Get the page file when updating if if one exists
  # +params: contains the parameters from the update form.
  # Returns the file if present
  def get_file(params)
    if params[:name] == 'conference'
      params[:conference][:custom_file]
    else
      params[:static_page][:custom_file]
    end
  end

  # parameters for a static_page
  def static_params
    params.require(:static_page).permit(:name, :contents,
                                        :custom_file,
                                        :custom_file_cache​)
  end

  # Set page by name of page
  def set_page
    @static_page = StaticPage.find_by name: params[:name]
  end
end
