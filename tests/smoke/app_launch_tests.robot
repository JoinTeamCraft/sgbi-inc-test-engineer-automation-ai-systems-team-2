*** Settings ***
Documentation     Automate the verification of the MoRent application launch to ensure that the website is accessible and the Home page loads successfully without any errors.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown    Close All Browsers

*** Test Cases ***
SG-1 Verify Application Launch
    [Documentation]    Verify that the MoRent application launches successfully and the Home page loads without errors.
    ...    Launch the MoRent website
    ...    Wait for the page to load completely.
    ...    Verify Application Load:
    ...    Check that the website loads successfully in the browser.
    ...    Ensure no browser-level error page (404, 500, or blank page) is displayed.
    ...    Verify that the Home page main container is present.
    ...    Verify Page Readiness:
    ...    Ensure the Home page is stable and ready for further interactions.
    ...    Expected Results:
    ...    The MoRent website opens successfully.
    ...    The Home page loads without any errors.
    ...    The main Home page container is visible.
    ...    The application is ready for further automated test execution.

    [Tags]    smoke    application_launch
    Open MoRent Application
    Verify No Browser Error
    Verify Home Page Loaded Successfully