*** Settings ***
Documentation     Automate the verification of step-by-step navigation in the MoRent booking flow (Next and Back) without data loss or incorrect behavior. If the app requires login before booking, add a login step or run after logging in. Locators may need to match the actual MoRent app DOM.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot    failure.png
Test Teardown    Close All Browsers

*** Test Cases ***
SG-27 Verify Booking Flow Step Progression (Next and Back Navigation)
    [Documentation]    Verify step-by-step navigation in the booking flow: Next moves forward, Back moves to previous step, and previously entered data is retained.
    ...
    ...    Steps:
    ...    1. Launch MoRent and perform valid car search; navigate to Car Details.
    ...    2. Click Rent Now to start booking.
    ...    3. Step 1 – Billing: Enter Name, Phone, Address, Town/City; click Next.
    ...    4. Verify navigation to Step 2 – Rental Information.
    ...    5. Step 2 – Rental: Enter Pick-Up/Drop-Off locations, dates, times; click Next.
    ...    6. Verify forward navigation to next step.
    ...    7. Click Back; verify back to previous step.
    ...    8. Click Back again to Step 1; validate billing data persistence.
    ...
    ...    Expected Results:
    ...    - Booking flow progresses correctly when clicking Next.
    ...    - Booking flow navigates backward correctly when clicking Back.
    ...    - Step indicators update when moving between steps.
    ...    - Previously entered data is preserved when navigating back.
    ...    - No form data lost; no unexpected reloads or errors.

    [Tags]    booking    booking_flow    step_progression    sg-27
    Open MoRent Application
    Verify No Browser Error
    Verify Home Page Loaded Successfully
    Wait For Page To Load Completely
    Perform Car Search And Navigate To Car Details
    Click Rent Now On Car Details To Start Booking
    Fill Billing Information Step1
    Click Next In Booking Flow
    Verify Booking Step Is Rental Information
    Fill Rental Information Step2
    Click Next In Booking Flow
    Verify Forward Navigation In Booking Flow
    Click Back In Booking Flow
    Verify Back To Previous Step
    Click Back In Booking Flow
    Validate Billing Data Persistence
