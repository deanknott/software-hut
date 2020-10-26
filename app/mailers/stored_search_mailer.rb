class StoredSearchMailer < ActionMailer::Base
  default from: 'FYN Update <no-reply@sheffield.ac.uk>'

  def new_subscription_email(stored_search)
    @stored_search = stored_search

    @unsubscribe = "https://team34.demo5.hut.shefcompsci.org.uk/delete-search?utf8=✓&id=#{stored_search.id}"

    mail(to: stored_search.email, subject: 'New Subscription Made')

  end

  def new_courses_email(stored_search)

    @stored_search = stored_search

    #This is hard coded and not sure how to make it work better.
    url = "https://team34.demo5.hut.shefcompsci.org.uk/courses?utf8=%E2%9C%93&"
    url += "subject=#{stored_search.name}&"
    url += "institute=#{stored_search.institution}&"
    url += "duration=#{stored_search.length}&"
    url += "full_time=#{stored_search.full_time}"
    #The url that is sent in the email
    @url = url

    @unsubscribe = "https://team34.demo5.hut.shefcompsci.org.uk/delete-search?utf8=✓&id=#{stored_search.id}"

    mail(to: stored_search.email, subject: 'New courses matching your search')
  end
end
