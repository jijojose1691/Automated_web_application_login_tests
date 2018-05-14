*** Settings ***
Suite Setup       Default Suite Setup
Suite Teardown    Default Suite Teardown
Test Teardown    Go to the homepage
Resource          ../../Keywords/keywords.robot

*** Test Cases ***
Valid_Login_Scenario
    [Documentation]    The test to verify valid login scenario. It will verify that page is
    ...  redirecting properly if the user enters valid credentials
    [Tags]    validLogin
    Given I enter valid username and password
    When I submit credentials
    Then welcome page should be open
    And verify that the user credentials were sent