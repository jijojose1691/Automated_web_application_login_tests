*** Settings ***
Documentation     A resource file with reusable keywords and variables.

Library           Selenium2Library

*** Variables ***
${BASE_URL}         http://testing-ground.scraping.pro
${BROWSER}        chrome
${LOGIN URL}      ${BASE_URL}/login
${WELCOME URL}    ${BASE_URL}/login?mode=welcome
${PAGE_TITLE}    Web Scraper Testing Ground
${DEFAULT_SUITE_SETUP_TIMEOUT}    5 minutes
${OUTPUT_TEXT_ELEMENT}    case_login
${VALID_USERNAME}    admin
${INVALID_USERNAME}    invalidadmin
${VALID_PASSWORD}    12345
${INVALID_PASSWORD}    invalidpassword

*** Keywords ***

Default Suite Setup
    [Documentation]    The keyword contains the Default Setup steps for running the Functional Tests
    [Timeout]    ${DEFAULT_SUITE_SETUP_TIMEOUT}
    Open Browser To Login Page    ${LOGIN URL}

Default Suite Teardown
    [Documentation]    The keyword contains the Default Teardown steps for the Functional Tests
    Close Browser

Open Browser To Login Page
    [Arguments]    ${url}
    [Documentation]    The keyword opens the login page and verify the login page is opened
    Open Browser    ${url}    browser=${BROWSER}
    Maximize Browser Window
    Login Page Should Be Open

Login Page Should Be Open
    [Documentation]    The keyword verifies that login page is opened
    Location Should Contain    ${LOGIN URL}
    Title Should Be    ${PAGE_TITLE}

I enter valid username and password
    [Documentation]    The keyword enter valid username and password on the given input fields
    user "${VALID_USERNAME}" logs in with password "${VALID_PASSWORD}"

I enter valid username and empty password
    [Documentation]    The keyword enter valid username and empty password on the given input fields
    user "${VALID_USERNAME}" logs in with password ""

I enter empty username and empty password
    [Documentation]    The keyword enter an empty username and an empty password on the given input fields
    user "" logs in with password ""

I enter empty username and valid password
    [Documentation]    The keyword enter an empty username and valid password on the given input fields
    user "" logs in with password "${VALID_PASSWORD}"

I enter invalid username and invalid password
    [Documentation]    The keyword enter an invalid username and an invalid password on the given input fields
    user "${INVALID_USERNAME}" logs in with password "${INVALID_PASSWORD}"

I enter valid username and invalid password
    [Documentation]    The keyword enter valid username and an invalid password on the given input fields
    user "${VALID_USERNAME}" logs in with password "${INVALID_PASSWORD}"

I enter invalid username and valid password
    [Documentation]    The keyword enter an invalid username and valid password on the given input fields
    user "${INVALID_USERNAME}" logs in with password "${VALID_PASSWORD}"

I submit credentials
    [Documentation]    The keyword will submit credentials to the controller
    Submit Credentials

Input Username
    [Documentation]    The keyword will inpurt given username to inout field with id usr
    [Arguments]    ${username}
    Input Text    usr    ${username}

Input Password
    [Documentation]    The keyword will inpurt given password to input field with id pwd
    [Arguments]    ${password}
    Input Text    pwd    ${password}

Submit Credentials
    [Documentation]    The keyword will submit credentials to the controller by clicking the Login button
    Click Button    Login

Welcome Page Should Be Open
    [Documentation]    The keyword verifies that the welcome page is opened
    Location Should Be    ${WELCOME URL}
    Title Should Be    ${PAGE_TITLE}

Welcome Page Should not Open
    [Documentation]    The keyword verifies that the welcome page is not opened
    ${status}  run keyword and return status   Location Should Be    ${WELCOME URL}
    should not be true  ${status}
    Title Should Be    ${PAGE_TITLE}

User "${username}" logs in with password "${password}"
    [Documentation]    The keyword will fill the input text field with given username and password
    Input username    ${username}
    Input password    ${password}

verify that the user credentials were sent
    [Documentation]    The keyword verifies that page contains text WELCOME and not contains any other values
    verify that the page does not contain    ${OUTPUT_TEXT_ELEMENT}    ACCESS DENIED!     Failed to send user credentials properly. Access is denied
    verify that the page does not contain    ${OUTPUT_TEXT_ELEMENT}     THE SESSION COOKIE IS MISSING OR HAS A WRONG VALUE!    User credentials were properly sent but the session cookie was not properly passed
    verify that the page does not contain    ${OUTPUT_TEXT_ELEMENT}     REDIRECTING...    User credentials were properly sent but HTTP redirection was not processed
    verify that the page contain    ${OUTPUT_TEXT_ELEMENT}     WELCOME :)     Failed to send user credentials

verify that the user credentials were not sent
    [Documentation]    The keyword verifies that page contains text ACCESS DENIED and not contains any other values
    verify that the page does not contain    ${OUTPUT_TEXT_ELEMENT}     WELCOME :)     Able to login page with invalid credentials
    verify that the page does not contain    ${OUTPUT_TEXT_ELEMENT}     THE SESSION COOKIE IS MISSING OR HAS A WRONG VALUE!    User credentials were properly sent but the session cookie was not properly passed
    verify that the page does not contain    ${OUTPUT_TEXT_ELEMENT}     REDIRECTING...    User credentials were properly sent but HTTP redirection was not processed
    verify that the page contain    ${OUTPUT_TEXT_ELEMENT}     ACCESS DENIED!     Failed to login scenario with invalid credentials


verify that the page contain
    [Documentation]    The keyword verifes that given element contains given text
    [Arguments]    ${element}    ${value}    ${error_message}
    Element Should Contain    ${element}    ${value}    ${error_message}

verify that the page does not contain
    [Documentation]    The keyword verifes that given element doent not contains given text
    [Arguments]    ${element}    ${value}    ${error_message}
    Element Should Not Contain    ${element}    ${value}    ${error_message}

Go to the homepage
    [Documentation]    The keyword verifes that page is redirecting to home page whiel clicking on Go back button
    Wait Until Element Is Visible   xpath=//*[@id="case_login"]/a      10
    Click Element    xpath=//*[@id="case_login"]/a
    Login Page Should Be Open