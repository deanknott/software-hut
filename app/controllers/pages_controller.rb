# frozen_string_literal: true

# Page controller
class PagesController < ApplicationController

  def degree_search
    authorize! :read, :pages
    @current_nav_identifier = :degree_search
    render 'degree_search/degree_search'
  end

  def advanced_search
    authorize! :read, :pages
    @current_nav_identifier = :advanced_search
    @degrees = Course.all
    @institutions = Institution.all
    render 'degree_search/advanced_search'
  end
end
