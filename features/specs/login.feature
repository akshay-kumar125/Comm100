Feature: Log in tests
  In order to verify Dashboard
  As an existing user
  I want to be able to log in

  @login
  Scenario: Log in with valid credentials
    Given I am on the homepage
    When I try to log in using valid credentials
    Then I should see "Welcome back"

  @invalidlogin
   Scenario Outline: Logging in using invalid credentials
    When I try to log in using the email "<username>" and password "<password>"
    Then I should see "Error signing into the account"
  
    Examples:
      | email                 | password        |
      | test@gmail.com        | 1235689         |
      | te123@gmail.com       |  2wsxdad        |
      | wrong_email           | 1qaz!QAZ2wsx    |
      | xifehe9794@pantabi.com| wrong_password  |
 