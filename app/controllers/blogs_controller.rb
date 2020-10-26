# frozen_string_literal: true

# Author:    Team 34: Luke Peacock
# Updated:   20.03.2019

# Controller class for Blog Posts
class BlogsController < ApplicationController
  before_action :set_blogs, only: [:show, :edit, :update,
                                   :destroy, :show_file, :download_file]
  # Set the blog to correct version for all actions listed above

  # new blog
  def new
    @blog = Blog.new
  end

  # create the actual blog record and save it.
  # Then redirect to blog list if success, or show message if not.
  def create
    blog = blog_params
    blog[:member_id] = current_user.member_id
    # if blog is valid (i.e. has name and content), create it
    if valid_blog(blog[:name], blog[:content], current_user)
      @blog = Blog.new(blog)
      if @blog.save
        redirect_to blogs_path, notice: 'Blog post successfully created'
        return
      end
    end
    render 'creation_failure'
  end

  # show all blogs, sort them based on user choice (default last active),
  # and then paginate and render view
  def index
    # CanCanCan authorization
    authorize! :read, :pages
    @current_nav_identifier = :blogs
    # Get all blogs if user is member, or just public ones if not signed in
    @blogs = if user_signed_in? && current_user.member.role.name != "Pending"
               Blog.all
             else
               Blog.where('privacy_id = 1')
             end
    # sort the blogs based on user choice
    @blogs = case params[:sort]
             when 'Name Alphabetical Ascending'
               @blogs.order('name ASC')
             when 'Name Alphabetical Descending'
               @blogs.order('name DESC')
             when 'Most Recent'
               @blogs.order('created_at DESC')
             else
               @blogs.order('updated_at DESC')
             end
    # paginate results
    @blogs = @blogs.page(params[:page]).per_page(10)
  end

  # show blog post
  def show; end



  # method to update an existing blog - checks parameters first
  def update
    if @blog.update(blog_params)
      render 'update_success'
    else
      render 'update_failure'
    end
  end

  # delete a blog from the database, then redirect to blog list
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: 'Blog was successfully deleted'
  end

  # download a file to the user's computer
  # all files are named 'download.extension'
  def download_file
    options = { type: @blog.file.file.content_type,
                disposition: 'attachment; filename="' + @blog.file.path.split("/").last + '"',
                url_based_filename: true }
    send_file(@blog.file.file.path, options)
  end

  # pass the blog file to the view so that it can be shown to the user
  def show_file
    options = { type: @blog.file.file.content_type,
                disposition: 'inline' }
    send_file @blog.file.path, options
  end

  private

  # function to check blog has a name and content
  def valid_blog(name, content, current_user)
    return false if current_user.member.role.name == "Pending"
    return false if name.nil? || name == ''
    return false if content.nil? || content == ''
    true
  end

  # Set the blog based on ID provided
  def set_blogs
    @blog = Blog.find(params[:id])
  end

  # Authorized blog parameters
  def blog_params
    params.require(:blog).permit(:name, :content, :file, :file_cache,
                                 :member_id, :privacy_id, :remove_file)
  end
end
