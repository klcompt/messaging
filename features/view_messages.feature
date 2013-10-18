Feature: Display the list of messages
  In order to manage the messages
  As an administrator
  I want to see a list of all messages

  @javascript
  Scenario: Display list of messages
    Given some messages have been created
    When I visit the application 
    Then I should see the messages
