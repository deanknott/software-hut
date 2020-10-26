# This file contains the seed for the 'help' page
StaticPage.where(name: 'help').first_or_create(contents:
  '<p>This page contains a link to a PDF help document. This document covers '\
  'topics such as: registering for an account, editing your profile, creating '\
  'a blog post, editing or deleting your own blog post, and most importantly, '\
  'searching for a degree with a foundation year.</p>', custom_file:
  Rails.root.join('app/assets/files/User_Guide.pdf').open)
