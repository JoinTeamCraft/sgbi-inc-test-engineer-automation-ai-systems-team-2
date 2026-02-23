*** Settings ***
Documentation     Automate the verification of Rent Now button functionality on car cards displayed on the Home page. This test ensures that clicking the Rent Now button from a Home page car card correctly navigates the user to the selected car's details or booking flow.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown    Close All Browsers

*** Test Cases ***
SG-25 Verify Rent Now Button Navigation from Home Page Car Card
    [Documentation]    Verify that clicking the Rent Now button on a car card from the Home page correctly navigates to the car details or booking flow.
    ...    
    ...    Steps:
    ...    1. Launch the MoRent website (https://morent-car.archisacademy.com/)
    ...    2. Wait for the Home page to load completely.
    ...    3. Locate the car cards displayed on the Home page.
    ...    4. Select a Car Card: Click on the Rent Now button of any visible car card.
    ...    5. Verify Navigation: Observe the page navigation after clicking the button.
    ...
    ...    Expected Results:
    ...    - The MoRent website opens successfully.
    ...    - The Home page loads completely and displays car cards.
    ...    - Car cards are visible on the Home page.
    ...    - Clicking the Rent Now button on a car card successfully navigates to the selected car's details page or booking flow.
    ...    - The navigation is successful and the new page loads correctly.

    [Tags]    home    navigation    rent_now
    Open MoRent Application
    Verify No Browser Error
    Verify Home Page Loaded Successfully
    Wait For Page To Load Completely
    Locate Home Page Car Cards
    Click Rent Now Button On Car Card    0
    Verify Navigation After Rent Now Click

SG-25 Verify Rent Now From First Middle And Last Car Card
    [Documentation]    Verify Rent Now navigation from first, middle, and last car card to improve coverage.
    [Tags]    home    navigation    rent_now    parameterized
    Open MoRent Application
    Verify No Browser Error
    Verify Home Page Loaded Successfully
    Wait For Page To Load Completely
    ${count}=    Locate Home Page Car Cards
    Should Be True    ${count} >= 1    Need at least one car card to run parameterized Rent Now test
    ${middle}=    Evaluate    ${count} // 2
    ${last}=    Evaluate    ${count} - 1
    FOR    ${idx}    IN    0    ${middle}    ${last}
        Run Keyword If    ${idx} > 0    Go Back
        Run Keyword If    ${idx} > 0    Wait For Page To Load Completely
        Run Keyword If    ${idx} > 0    Locate Home Page Car Cards
        Click Rent Now Button On Car Card    ${idx}
        Verify Navigation After Rent Now Click
    END
