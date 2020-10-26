# frozen_string_literal: true

# This file contains the seed for the 'Constitution' page
StaticPage.where(name: 'constitution').first_or_create(contents:
  'Anyone with an interest in Foundation Year provision is invited to become '\
  'a member of the Foundation Year Network. If you would like to get '\
  'involved, please read the full Foundation Year Network constitution to '\
  'ensure that you are able to support and further the ambitions of the '\
  'network.', custom_file:
  Rails.root.join('app/assets/files/constitution.pdf').open)
