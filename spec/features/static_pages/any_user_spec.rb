require 'rails_helper'

describe' As any user' do
  specify 'I can see files attached to static pages when not logged in' do
    visit '/about/constitution'
    within(:css, '#wrap') {expect(page).to have_content 'Constitution'}
    within(:css, '#wrap') {expect(page).to have_css 'object'}
  end

  specify 'I can download files attached public blog post when not logged in' do
    visit '/about/constitution'
    within(:css, '#wrap') {expect(page).to have_content 'Constitution'}
    within(:css, '#wrap') { expect(page).to have_css 'object' }
    within(:css, 'object') { click_link 'click here' }
    expect(page.response_headers['Content-Disposition']).to include("filename=\"constitution.pdf\"")
  end

end
