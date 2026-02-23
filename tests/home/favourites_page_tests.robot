*** Settings ***
Documentation     Automate the verification of the Favourites page: cars added to favourites are displayed correctly as cards with complete information.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown    Run Keywords    Run Keyword If Test Failed    Capture Page Screenshot    failure.png    AND    Close All Browsers

*** Test Cases ***
SG-29 Verify Favourites Page Displays Saved Cars Correctly
    [Documentation]    Verify the Favourites page loads and displays favourited cars as cards with complete info (image, name, type, capacity/transmission, price, Rent Now, heart).
    ...
    ...    Preconditions: User must be logged in. At least one car must be added to favourites.
    ...
    ...    Steps:
    ...    1. Launch MoRent (https://morent-car.archisacademy.com/)
    ...    2. Log in using valid user credentials.
    ...    3. Ensure at least one car is in favourites (add one from Home if needed).
    ...    4. Click the Favourites icon in the header.
    ...    5. Verify Favourites page load: "Your Favourites" title/section visible.
    ...    6. Verify one or more favourite car cards are displayed.
    ...    7. For each card verify: car image, name, type, capacity/transmission, price per day, Rent Now button, heart icon.
    ...
    ...    Expected Results:
    ...    - The Favourites page loads successfully.
    ...    - All favourited cars are displayed as cards.
    ...    - Each card displays complete and correct information.
    ...    - No non-favourited cars appear on this page.

    [Tags]    home    favourites    favourites_page    sg-29
    Open MoRent Application
    Verify No Browser Error
    Verify Home Page Loaded Successfully
    Wait For Page To Load Completely
    Log In With Valid Credentials
    Navigate To Home With Car Cards
    Add One Car To Favourites If Needed
    Click Favourites Icon In Header
    Verify Favourites Page Loaded
    Verify Favourite Car Cards Displayed
    Verify Each Favourite Card Has Required Elements
