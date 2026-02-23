*** Settings ***
Documentation     Automate the verification of Add to Favourites from car cards on the MoRent website. A logged-in user can add a car to favourites using the heart icon; the action is reflected correctly.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown    Run Keywords    Run Keyword If Test Failed    Capture Page Screenshot    failure.png    AND    Close All Browsers

*** Test Cases ***
SG-28 Verify Add to Favourites from Car Card
    [Documentation]    Verify that a logged-in user can add a car to favourites via the heart icon on a car card; heart state updates and no reload/error occurs.
    ...
    ...    Preconditions: User must be logged in with valid credentials.
    ...
    ...    Steps:
    ...    1. Launch MoRent (https://morent-car.archisacademy.com/)
    ...    2. Log in using valid user credentials.
    ...    3. Navigate to Home where car cards are displayed.
    ...    4. Select a car card not currently marked as favourite; locate the heart icon.
    ...    5. Click the heart icon to add to favourites.
    ...    6. Verify the heart icon state after clicking (visually indicates favourite).
    ...
    ...    Expected Results:
    ...    - The heart icon is clickable on the car card.
    ...    - Clicking the heart icon marks the car as favourite.
    ...    - The heart icon visually changes to indicate favourite status.
    ...    - No page reload or error occurs during the action.

    [Tags]    home    favourites    add_to_favourites    sg-28
    Open MoRent Application
    Verify No Browser Error
    Verify Home Page Loaded Successfully
    Wait For Page To Load Completely
    Log In With Valid Credentials
    Navigate To Home With Car Cards
    Click Favourite Heart On Car Card    0
    Verify Favourite Heart State After Click
    Verify No Page Reload Or Error On Favourite Action
