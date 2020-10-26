Feature: Handles Compressed Responses

  In order to save bandwidth
  As a developer
  I want to uncompress compressed responses

  Scenario: Supports deflate encoding
    Given a remote deflate service
    And the response from the service has a body of '<h1>Some HTML</h1>'
    And that service is accessed at the path '/deflate_service.html'
    When I call HTTParty#get with '/deflate_service.html'
    Then the return value should match '<h1>Some HTML</h1>'

  Scenario: Supports gzip encoding
    Given a remote gzip service
    And the response from the service has a body of '<h1>Some HTML</h1>'
    And that service is accessed at the path '/gzip_service.html'
    When I call HTTParty#get with '/gzip_service.html'
    Then the return value should match '<h1>Some HTML</h1>'

  Scenario: Supports HEAD request with gzip encoding
    Given a remote gzip service
    And that service is accessed at the path '/gzip_head.gz.js'
    When I call HTTParty#head with '/gzip_head.gz.js'
    Then it should return a response with a 200 response code
    Then it should return a response with a gzip content-encoding
    Then it should return a response with a blank body
