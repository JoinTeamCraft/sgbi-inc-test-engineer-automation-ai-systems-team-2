*** Settings ***
Documentation     Automate the verification of the Show More Cars button on the MoRent Home page: visible, clickable, and loads additional car cards correctly.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown    Close All Browsers

*** Test Cases ***
SG-26 Verify Show More Cars Button on Home Page
    [Documentation]    Verify the Show More Cars button is visible, clickable, and loads additional car cards. Validates initial count, click, updated count increase, and correct structure of loaded cards.
    ...
    ...    Steps:
    ...    1. Launch the MoRent website (https://morent-car.archisacademy.com/)
    ...    2. Wait for the Home page to load completely.
    ...    3. Scroll down to the car listing section.
    ...    4. Verify Show More Cars button is visible and clickable.
    ...    5. Capture initial car card count.
    ...    6. Click Show More Cars button.
    ...    7. Wait for new car cards to load and count total cards.
    ...    8. Validate count increased and new cards have correct structure.
    ...
    ...    Expected Results:
    ...    - Show More Cars button is visible and enabled.
    ...    - Clicking loads additional car cards; total displayed cars increases.
    ...    - New cards display correctly (image, name, price, Rent Now); no duplicate/empty/broken cards.

    [Tags]    home    show_more_cars    sg-26
    Open MoRent Application
    Verify No Browser Error
    Verify Home Page Loaded Successfully
    Wait For Page To Load Completely
    Scroll To Car Listing Section
    Verify Show More Cars Button Visible And Clickable
    ${initial_count}=    Get Displayed Car Card Count
    Click Show More Cars Button
    Wait For New Car Cards To Load
    ${updated_count}=    Wait For Car Count To Increase    ${initial_count}
    Verify Car Count Increased    ${initial_count}    ${updated_count}
    Verify New Car Cards Structure
