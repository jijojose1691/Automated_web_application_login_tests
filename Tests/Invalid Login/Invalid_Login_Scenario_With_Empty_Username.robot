*** Settings ***
Suite Setup       Default Suite Setup
Suite Teardown    Default Suite Teardown
Test Teardown    Go to the homepage
Resource          ../../Keywords/keywords.robot

*** Test Cases ***
Invalid_Login_Scenario_With_Empty_Username
    [Documentation]    The test to verify invalid login scenario.
    ...  It will verify that page is showing error properly if the user enters an empty username
    [Tags]    invalidLogin
    Given I enter empty username and valid password
    When I submit credentials
    Then Welcome Page Should not Open
    And verify that the user credentials were not sent