Feature: Edit profile information



Scenario: I sign in and edit my account
  Given I am logged in
  When I edit my account information
  And I press "save changes"
  Then I should see "profile updated"