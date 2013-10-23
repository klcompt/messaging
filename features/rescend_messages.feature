Feature: Rescend a message
  In order to manage the messages
  As an administrator
  I want to be able to rescend a message

  @javascript
  Scenario: Rescend a message
    Given some messages have been created
    When I visit the application
    And I rescend the last message
    Then I should see the message is rescended
