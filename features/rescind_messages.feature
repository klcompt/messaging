Feature: Rescind a message
  In order to manage the messages
  As an administrator
  I want to be able to rescind a message

  @javascript
  Scenario: Rescind a message
    Given some messages have been created
    When I visit the application
    And I rescind the last message
    Then I should see the message is rescinded
