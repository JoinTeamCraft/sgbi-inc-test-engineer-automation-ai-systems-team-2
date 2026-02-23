*** Settings ***
Documentation     Automate the verification of the User Registration (Sign Up) page navigation on the MoRent website to ensure that a user can successfully navigate from the Home page to the Registration page.
...    This test confirms that the Sign Up entry point is available and that the Registration form loads correctly.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Setup       Open MoRent Application
Test Teardown    Close All Browsers

*** Test Cases ***
SG-3 Verify User Registration (Sign Up) Page Navigation
    [Documentation]    Verify that a user can navigate from the Home page to the User Registration (Sign Up) page on the MoRent website, and that the Registration page loads successfully.
    ...    Launch the MoRent website
    ...    Wait for the Home page to load completely.
    ...    Click the Sign In link from the Home page.
    ...    Click the Sign Up link from the Sign In page.
    ...    Verify Registration Page Load:
    ...    Wait for the Registration page to load.
    ...    Verify that the Registration form is displayed.
    ...    Verify Registration Form Fields Presence:
    ...    Check that the following input fields are present and visible:
    ...    First name
    ...    Last name
    ...    Email address
    ...    Password
    ...    Verify that the Register / Sign Up Continue button is visible.
    ...    Expected Results
    ...    Clicking the Register / Sign Up button navigates to the Registration page.
    ...    The Registration page loads successfully.
    ...    The Registration form is displayed.
    ...    All required input fields are present and visible.
    ...    The Register / Sign Up Continue button is visible.

    [Tags]    smoke    user_registration_sign_up_navigation
    Wait For Page To Load Completely
    Navigate To Registration Page
    Verify Registration Page Loaded
    Verify Registration Form Fields Presence
