*** Settings ***
Documentation     Automate the verification of the Header section on the MoRent Home page to ensure that all primary navigation elements are present, visible, and functional.
...    This test confirms that users can clearly see and access the main navigation options immediately after the application loads.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Setup       Open MoRent Application
Test Teardown    Close All Browsers

*** Test Cases ***
SG-2 Verify Header and Navigation Elements
    [Documentation]    Verify that the Header section of the MoRent Home page contains all expected navigation elements, and that they are visible and functional.
    ...    Launch the MoRent website
    ...    Wait for the Home page to load completely.
    ...    Verify Header Visibility:
    ...    Locate the Header section.
    ...    Ensure the Header section is visible on the page. 
    ...    Verify Header Elements:
    ...    Check that the application logo is present and visible.
    ...    Verify that the navigation menu is displayed.
    ...    Verify that the Login button is visible.
    ...    Verify that the Register / Sign Up button is visible.
    ...    Verify Navigation Clickability:
    ...    Click on each visible navigation item one by one.
    ...    Verify that clicking each item redirects to the expected page or section.
    ...    Expected Results:
    ...    The Header section is displayed on the Home page.
    ...    The application logo is visible.
    ...    All navigation menu items are visible.
    ...    Login and Register buttons are visible.
    ...    Each navigation item is clickable and routes correctly.

    [Tags]    smoke    header_and_navigation
    Wait For Page To Load Completely
    Verify Header Section Is Visible
    Verify Application Logo Is Visible
    Verify Home Page Search Bar Is Visible
    Verify Navigation Clickability Of Header Elements