class ErrorsController < ApplicationController

  skip_before_action :ie_warning
  skip_before_action :verify_authenticity_token, only: [:error_422]
  skip_authorization_check

  def error_403
    @current_nav_identifier = '403'
  end

  def error_404
    @current_nav_identifier = '404'
  end

  def error_422
    @current_nav_identifier = '422'
  end

  def error_500
    @current_nav_identifier = '500'
    begin
      render
    rescue
      render layout: 'plain_error'
    end
  end

  def ie_warning
    @current_nav_identifier = 'ie_warning'
  end

  def javascript_warning
    @current_nav_identifier = 'js_warning'
  end

end
