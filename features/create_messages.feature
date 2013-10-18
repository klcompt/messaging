Feature: Create a new messages
  In order to manage the messages
  As an administrator
  I want to be able to add a new message for callers to hear

  @javascript
  Scenario: Create a new message
    Given some messages have been created
    When I visit the application
    And I create a new message
    Then I should see the new message as the last message in the list
