class StoredSearchesController < ApplicationController
  def new
    @stored_search = StoredSearch.new
  end

  def create
    stored_search_params = params.require(:stored_search).permit(:email, :subject, :institution, :full_time, :duration, :distance, :location)
    @stored_search = StoredSearch.new(stored_search_params)

    @stored_search.save
  end

  def create_search
    #manual testing
  end

  def save_search
    ###Can get the params that are passed in. But institution is a really not great thing
    if check_input(params)
      new_search(params)
      redirect_to '/courses', notice: "Subscription Successful"
    else
      redirect_to '/create-search', notice: "Please enter search values and an Email address"
    end
    #This page won't do much. The bigger one is the actual save page: triggered by a button
  end


  def new_search(params)
    search = StoredSearch.new
    search.email = params[:email]
    search.name = params[:subject] #This is super annoying. Subject is a much better name
    search.institution = params[:institution]
    search.length = params[:duration]
    search.delivery_mode = nil
    search.full_time = params[:full_time]
    search.distance = params[:distance]
    search.location = params[:location]

    if search.save!
      StoredSearchMailer.new_subscription_email(search).deliver
    end
  end

  def delete_search
    StoredSearch.delete(params[:id])
    redirect_to '/courses',notice: "UnSubscription Successful"
  end

  def check_input(ins)
    if ins[:email].nil? || ins[:email].chomp == ''
      return false
    end
    if ins[:subject].nil? || ins[:subject].chomp == ''
      return false
    elsif ins[:institution].nil? || ins[:institution].chomp == ''
      return false
    end
    return true
  end
end
