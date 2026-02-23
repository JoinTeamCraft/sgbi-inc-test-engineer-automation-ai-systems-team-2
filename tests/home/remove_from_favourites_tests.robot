*** Settings ***
Documentation     Automate the verification of removing a car from favourites from the Favourites page. Ensures the list updates correctly after removal.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown    Run Keywords    Run Keyword If Test Failed    Capture Page Screenshot    failure.png    AND    Close All Browsers

*** Test Cases ***
SG-30 Verify Remove Car from Favourites on Favourites Page
    [Documentation]    Verify that a logged-in user can remove a car from favourites on the Favourites page and that the list updates correctly.
    ...
    ...    Preconditions: User must be logged in. At least one car must exist in the Favourites list.
    ...
    ...    Steps:
    ...    1. Launch MoRent (https://morent-car.archisacademy.com/)
    ...    2. Log in using valid user credentials.
    ...    3. Navigate to the Favourites page (ensure at least one car in list).
    ...    4. Locate a favourite car card and note the current list.
    ...    5. Click the heart icon on that card to remove it from favourites.
    ...    6. Verify the Favourites page after removal.
    ...
    ...    Expected Results:
    ...    - The selected car is removed from the Favourites list.
    ...    - The car card disappears from the page (or list count decreases).
    ...    - The Favourites list updates dynamically.
    ...    - No full page refresh or error occurs.

    [Tags]    home    favourites    remove_from_favourites    sg-30
    Open MoRent Application
    Verify No Browser Error
    Verify Home Page Loaded Successfully
    Wait For Page To Load Completely
    Log In With Valid Credentials
    Add One Car To Favourites If Needed
    Navigate To Favourites Page
    ${count_before}=    Get Favourites Page Card Count
    Should Be True    ${count_before} > 0    No favourite cars to remove
    Click Heart On Favourites Page To Remove From Favourites    0
    Verify Car Removed From Favourites List    ${count_before}
    Verify No Page Refresh Or Error After Remove
