Feature: Generate timesheet

  Scenario: Worked all days in month, no holidays or public holidays
    Given I am on the 'generate timesheet' page
    And I choose the month 'June' and year '2015'
    When I click 'Generate Timesheet'
    Then I should see 'The month is June and the year is 2015'
    Then I should see 'Total number of days: 30'
    And I should see 'The number of weekends are 8'
    And I should see 'Total number of working days: 22'

