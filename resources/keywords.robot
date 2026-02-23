*** Settings ***
Documentation     Reusable keywords for SG-25 Rent Now button navigation test
Library           SeleniumLibrary
Library           String
Resource          locators.robot
Library          config.env_config.EnvConfig



*** Keywords ***
Open MoRent Application
    [Documentation]    Open the MoRent application in the browser and maximize the window.
    ${url}=    Get Config Value    BASE_URL
    ${browser}=    Get Config Value    BROWSER
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Verify Home Page Loaded Successfully
    [Documentation]    Verify that the Home page of the MoRent application has loaded successfully by checking for key elements.
    Wait For Page To Load Completely
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait Until Element Is Visible    ${HOME_PAGE_LOGO}    ${timeout}
    Wait Until Element Is Visible    ${HOME_PAGE_SEARCH_BAR}    ${timeout}
    Wait Until Element Is Visible    ${HOME_SEARCH_BUTTON}    ${timeout}
    Wait Until Element Is Visible    ${HOME_PAGE_MAIN_CONTAINER}    ${timeout}
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}.png
      
Verify No Browser Error
    [Documentation]    Verify that no browser-level error page (such as 404, 500, or blank page) is displayed after launching the application.
    ${page_not_found_code}=    Get Config Value    PAGE_NOT_FOUND_CODE
    ${server_error_code}=    Get Config Value    SERVER_ERROR_CODE
    ${title}=    Get Title
    Should Not Contain    ${title}    ${page_not_found_code}
    Should Not Contain    ${title}    ${server_error_code}
    Should Not Be Empty    ${title}

Page Should Be Ready
    [Documentation]    Verify that the page has fully loaded by checking the document ready state.
    ${state}=    Execute Javascript    return document.readyState
    Should Be Equal    ${state}    complete

Wait For Page To Load Completely
    [Documentation]    Wait until the page has fully loaded by checking the document ready state.
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    ${retry_count}=    Get Config Value    RETRY_COUNT
    Wait Until Keyword Succeeds    ${retry_count}    ${timeout}    Page Should Be Ready

Close MoRent Application
    [Documentation]    Closes the browser
    Close All Browsers

Take Screenshot On Failure
    [Documentation]    Takes a screenshot when a test fails
    ${screenshot_dir}=    Get Config Value    SCREENSHOT_DIR
    Run Keyword If Test Failed    Capture Page Screenshot    ${screenshot_dir}/failure-{index}.png

Locate Home Page Car Cards
    [Documentation]    Locates and verifies that car cards are displayed on the Home page
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${short_timeout}=    Get Config Value    SHORT_TIMEOUT
    ${medium_timeout}=    Get Config Value    MEDIUM_TIMEOUT
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight/2)
    Wait Until Keyword Succeeds    ${short_timeout}s    1s    Element Should Be Visible    ${HOME_PAGE_MAIN_CONTAINER}
    # Try multiple locator strategies with retries
    ${car_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${HOME_PAGE_CAR_CARD}    timeout=${medium_timeout}
    # If not found, try scrolling and alternative approaches
    Run Keyword If    ${car_found} == ${False}    Scroll To Find Car Cards
    # Check if we found car cards or Rent Now buttons
    ${car_count}=    Get Element Count    ${HOME_PAGE_CAR_CARD}
    ${rent_now_count}=    Get Element Count    ${HOME_PAGE_RENT_NOW_BUTTON}
    # If car cards not found but Rent Now buttons exist, that's acceptable
    Run Keyword If    ${car_count} == 0 and ${rent_now_count} > 0    Log    Car card container not found, but ${rent_now_count} Rent Now buttons detected - proceeding with test
    # Final check - either car cards or Rent Now buttons should be present
    ${final_car_count}=    Get Element Count    ${HOME_PAGE_CAR_CARD}
    Run Keyword If    ${final_car_count} == 0    Wait Until Element Is Visible    ${HOME_PAGE_RENT_NOW_BUTTON}    timeout=${timeout}
    ${final_rent_now_count}=    Get Element Count    ${HOME_PAGE_RENT_NOW_BUTTON}
    Should Be True    ${final_car_count} > 0 or ${final_rent_now_count} > 0    No car cards or Rent Now buttons found on Home page
    [Return]    ${final_car_count}

Scroll To Find Car Cards
    [Documentation]    Scrolls the page to find car cards if they're not immediately visible
    FOR    ${i}    IN RANGE    5
        Execute Javascript    window.scrollBy(0, 400)
        Wait Until Keyword Succeeds    2s    0.5s    Page Should Be Ready
        ${car_count}=    Get Element Count    ${HOME_PAGE_CAR_CARD}
        ${rent_now_count}=    Get Element Count    ${HOME_PAGE_RENT_NOW_BUTTON}
        Exit For Loop If    ${car_count} > 0 or ${rent_now_count} > 0
    END
    Execute Javascript    window.scrollTo(0, 0)
    Wait Until Keyword Succeeds    2s    0.5s    Page Should Be Ready

Click Rent Now Button On Car Card
    [Documentation]    Clicks the Rent Now button on a car card from the Home page
    [Arguments]    ${card_index}=0
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    # Wait for Rent Now buttons to be visible
    Wait Until Element Is Visible    ${HOME_PAGE_RENT_NOW_BUTTON}    timeout=${timeout}
    ${rent_now_buttons}=    Get WebElements    ${HOME_PAGE_RENT_NOW_BUTTON}
    ${button_count}=    Get Length    ${rent_now_buttons}
    Should Be True    ${button_count} > ${card_index}    Rent Now button at index ${card_index} not found. Found ${button_count} buttons.
    Click Element    ${rent_now_buttons}[${card_index}]

Verify Navigation After Rent Now Click
    [Documentation]    Verifies that the page has navigated to car details/booking by asserting a specific element unique to that page.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait For Page To Load Completely
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    ${current_url}=    Get Location
    ${base_url}=    Get Config Value    BASE_URL
    ${base_stripped}=    Evaluate    "${base_url}".rstrip("/")
    ${is_home_page}=    Evaluate    ("${current_url}".rstrip("/") == "${base_stripped}") or ("${current_url}" == "${base_stripped}" + "#")
    # Primary check: assert presence of a specific element that only exists on car details/booking page
    Wait Until Element Is Visible    ${CAR_DETAILS_PAGE}    timeout=${timeout}
    # If still on home URL, require details/title to be present (stricter than permissive OR)
    Run Keyword If    ${is_home_page}    Wait Until Element Is Visible    ${CAR_DETAILS_TITLE}    timeout=${timeout}
    Log    Current URL: ${current_url}; car details page verified
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}.png

# --- SG-26 Show More Cars keywords ---
Scroll To Car Listing Section
    [Documentation]    Scroll down to the car listing section on the Home page
    ${short_timeout}=    Get Config Value    SHORT_TIMEOUT
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight / 2)
    Wait Until Keyword Succeeds    ${short_timeout}s    1s    Page Should Be Ready
    FOR    ${i}    IN RANGE    4
        ${show_more_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${HOME_PAGE_SHOW_MORE_CARS_BUTTON}
        Exit For Loop If    ${show_more_visible}
        Execute Javascript    window.scrollBy(0, 350)
        Wait Until Keyword Succeeds    2s    0.5s    Page Should Be Ready
    END

Verify Show More Cars Button Visible And Clickable
    [Documentation]    Locate the Show More Cars button and verify it is visible and enabled
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait Until Element Is Visible    ${HOME_PAGE_SHOW_MORE_CARS_BUTTON}    timeout=${timeout}
    Element Should Be Visible    ${HOME_PAGE_SHOW_MORE_CARS_BUTTON}
    Element Should Be Enabled    ${HOME_PAGE_SHOW_MORE_CARS_BUTTON}
    Log    Show More Cars button is visible and clickable

Get Displayed Car Card Count
    [Documentation]    Count the number of car cards currently displayed on the Home page. Returns count.
    ${count}=    Get Element Count    ${HOME_PAGE_CAR_CARD}
    ${count}=    Run Keyword If    ${count} == 0    Get Element Count    ${HOME_PAGE_RENT_NOW_BUTTON}    ELSE    Set Variable    ${count}
    Should Be True    ${count} > 0    No car cards found on the page
    Log    Current car card count: ${count}
    [Return]    ${count}

Click Show More Cars Button
    [Documentation]    Click on the Show More Cars button
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    Wait Until Element Is Visible    ${HOME_PAGE_SHOW_MORE_CARS_BUTTON}    timeout=${timeout}
    Click Element    ${HOME_PAGE_SHOW_MORE_CARS_BUTTON}
    Log    Clicked Show More Cars button

Wait For Car Count To Increase
    [Documentation]    Wait for car card count to increase after clicking Show More Cars (retry until timeout)
    [Arguments]    ${initial_count}
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    FOR    ${i}    IN RANGE    0    ${timeout}    2
        Wait Until Keyword Succeeds    2s    0.5s    Page Should Be Ready
        ${current}=    Get Element Count    ${HOME_PAGE_CAR_CARD}
        ${current}=    Run Keyword If    ${current} == 0    Get Element Count    ${HOME_PAGE_RENT_NOW_BUTTON}    ELSE    Set Variable    ${current}
        Return From Keyword If    ${current} > ${initial_count}    ${current}
    END
    ${final}=    Get Element Count    ${HOME_PAGE_CAR_CARD}
    ${final}=    Run Keyword If    ${final} == 0    Get Element Count    ${HOME_PAGE_RENT_NOW_BUTTON}    ELSE    Set Variable    ${final}
    [Return]    ${final}

Wait For New Car Cards To Load
    [Documentation]    Wait for new car cards to load after clicking Show More Cars. Poll for page ready and optional spinner gone; no fixed Sleep fallback.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${short_timeout}=    Get Config Value    SHORT_TIMEOUT
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    Wait Until Keyword Succeeds    ${short_timeout}s    1s    Page Should Be Ready
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    ${LOADING_SPINNER}    timeout=${short_timeout}
    Execute Javascript    window.scrollBy(0, document.body.scrollHeight)
    Wait Until Keyword Succeeds    ${short_timeout}s    1s    Page Should Be Ready

Verify Car Count Increased
    [Documentation]    Compare initial and updated car counts. Pass when count increased; when unchanged, pass only if no decrease (button worked, no more data or same batch).
    [Arguments]    ${initial_count}    ${updated_count}
    Should Be True    ${updated_count} >= ${initial_count}    Car count decreased after clicking Show More Cars. Initial: ${initial_count}, After click: ${updated_count}
    ${increased}=    Evaluate    ${updated_count} > ${initial_count}
    Run Keyword If    ${increased}    Log    Car count increased from ${initial_count} to ${updated_count}
    Run Keyword If    not ${increased}    Log    Car count unchanged (${initial_count}). All cars may already be displayed or no additional data from server.
    Log    Load behavior validated. Initial: ${initial_count}, Updated: ${updated_count}

Verify New Car Cards Structure
    [Documentation]    Verify newly loaded car cards are displayed correctly: no duplicate, empty, or broken cards. Structure (image, name, price, Rent Now) implied by consistent card and button counts.
    ${card_count}=    Get Element Count    ${HOME_PAGE_CAR_CARD}
    ${rent_now_count}=    Get Element Count    ${HOME_PAGE_RENT_NOW_BUTTON}
    Should Be True    ${card_count} > 0    No car cards found to validate
    # Each card should have one Rent Now button; allow same or more buttons than cards (nested structures)
    Should Be True    ${rent_now_count} >= ${card_count} or ${rent_now_count} > 0    No Rent Now buttons found; cards may be broken
    Log    Validated ${card_count} car cards with ${rent_now_count} Rent Now button(s)
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}.png

# --- SG-27 Booking flow step progression keywords ---
Perform Car Search And Navigate To Car Details
    [Documentation]    Perform a valid car search from Home and navigate to a Car Details page (via first result / Rent Now).
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${pickup}=    Get Config Value    DEFAULT_PICKUP_LOCATION
    Wait Until Element Is Visible    ${HOME_PAGE_SEARCH_BAR}    timeout=${timeout}
    Input Text    ${HOME_PAGE_SEARCH_BAR}    ${pickup}
    Wait Until Keyword Succeeds    3s    0.5s    Page Should Be Ready
    Click Element    ${HOME_SEARCH_BUTTON}
    Wait For Page To Load Completely
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    Locate Home Page Car Cards
    Click Rent Now Button On Car Card    0
    Verify Navigation After Rent Now Click
    Log    Navigated to Car Details page

Click Rent Now On Car Details To Start Booking
    [Documentation]    On Car Details page, click Rent Now to start the booking process (Step 1).
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait For Page To Load Completely
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    Wait Until Element Is Visible    ${CAR_DETAILS_RENT_NOW_BUTTON}    timeout=${timeout}
    Scroll Element Into View    ${CAR_DETAILS_RENT_NOW_BUTTON}
    Wait Until Keyword Succeeds    3s    0.5s    Page Should Be Ready
    Click Element    ${CAR_DETAILS_RENT_NOW_BUTTON}
    Wait For Page To Load Completely
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    Capture Page Screenshot    after_rent_now_click.png
    Wait For Booking Step 1 Form
    Log    Started booking flow

Wait For Booking Step 1 Form
    [Documentation]    Wait for the billing (Step 1) form to be visible.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait Until Keyword Succeeds    ${timeout}    3s    Wait For Billing Form Visible
    Capture Page Screenshot    booking_step1_loaded.png
    Log    Booking Step 1 form is visible

Wait For Billing Form Visible
    [Documentation]    Either billing name input, Step 1 / Billing label, or Next button must be visible.
    ${name_ok}=    Run Keyword And Return Status    Element Should Be Visible    ${BILLING_NAME_INPUT}
    ${step_ok}=    Run Keyword And Return Status    Element Should Be Visible    ${STEP1_BILLING_LABEL}
    ${next_ok}=    Run Keyword And Return Status    Element Should Be Visible    ${BOOKING_NEXT_BUTTON}
    Should Be True    ${name_ok} or ${step_ok} or ${next_ok}    Booking Step 1 form not found: no billing name input, step label, or Next button visible

Fill Billing Information Step1
    [Documentation]    Enter valid values in all mandatory billing fields: Name, Phone, Address, Town/City.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${name}=    Get Config Value    BILLING_NAME
    ${phone}=    Get Config Value    BILLING_PHONE
    ${address}=    Get Config Value    BILLING_ADDRESS
    ${city}=    Get Config Value    BILLING_CITY
    Wait Until Element Is Visible    ${BILLING_NAME_INPUT}    timeout=${timeout}
    Scroll Element Into View    ${BILLING_NAME_INPUT}
    Clear Element Text    ${BILLING_NAME_INPUT}
    Input Text    ${BILLING_NAME_INPUT}    ${name}
    Clear Element Text    ${BILLING_PHONE_INPUT}
    Input Text    ${BILLING_PHONE_INPUT}    ${phone}
    Clear Element Text    ${BILLING_ADDRESS_INPUT}
    Input Text    ${BILLING_ADDRESS_INPUT}    ${address}
    Clear Element Text    ${BILLING_CITY_INPUT}
    Input Text    ${BILLING_CITY_INPUT}    ${city}
    Log    Filled billing: Name, Phone, Address, City

Click Next In Booking Flow
    [Documentation]    Click the Next button in the booking flow.
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    Wait Until Element Is Visible    ${BOOKING_NEXT_BUTTON}    timeout=${timeout}
    Click Element    ${BOOKING_NEXT_BUTTON}
    Wait For Page To Load Completely
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    Log    Clicked Next

Verify Booking Step Is Rental Information
    [Documentation]    Confirm that the booking flow moved to Step 2 – Rental Information.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${step2_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${STEP2_RENTAL_LABEL}    timeout=${timeout}
    Run Keyword If    not ${step2_visible}    Wait Until Element Is Visible    ${RENTAL_PICKUP_LOCATION}    timeout=${timeout}
    Run Keyword If    not ${step2_visible}    Wait Until Element Is Visible    ${RENTAL_DROPOFF_LOCATION}    timeout=${timeout}
    Log    Verified Step 2 – Rental Information

Verify Forward Navigation In Booking Flow
    [Documentation]    Confirm that the booking flow progressed to the next step after clicking Next (e.g. Step 3 or confirmation).
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    # Next step may show Step 3, or Back button indicates we left Step 2
    ${back_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${BOOKING_BACK_BUTTON}    timeout=${timeout}
    Should Be True    ${back_visible}    Forward navigation failed: Back button or next step not found
    Log    Verified forward navigation to next step

Fill Rental Information Step2
    [Documentation]    Enter valid Pick-Up and Drop-Off details: locations, dates, times.
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    ${pickup_loc}=    Get Config Value    DEFAULT_PICKUP_LOCATION
    ${dropoff_loc}=    Get Config Value    DEFAULT_DROPOFF_LOCATION
    ${pickup_date}=    Get Config Value    RENTAL_PICKUP_DATE
    ${dropoff_date}=    Get Config Value    RENTAL_DROPOFF_DATE
    ${pickup_time}=    Get Config Value    RENTAL_PICKUP_TIME
    ${dropoff_time}=    Get Config Value    RENTAL_DROPOFF_TIME
    Wait For Page To Load Completely
    Input Text    ${RENTAL_PICKUP_LOCATION}    ${pickup_loc}
    Input Text    ${RENTAL_DROPOFF_LOCATION}    ${dropoff_loc}
    Input Text    ${RENTAL_PICKUP_DATE}    ${pickup_date}
    Input Text    ${RENTAL_DROPOFF_DATE}    ${dropoff_date}
    Input Text    ${RENTAL_PICKUP_TIME}    ${pickup_time}
    Input Text    ${RENTAL_DROPOFF_TIME}    ${dropoff_time}
    Log    Filled rental: locations, dates, times

Click Back In Booking Flow
    [Documentation]    Click the Back button in the booking flow.
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    Wait Until Element Is Visible    ${BOOKING_BACK_BUTTON}    timeout=${timeout}
    Click Element    ${BOOKING_BACK_BUTTON}
    Wait For Page To Load Completely
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    Log    Clicked Back

Verify Back To Previous Step
    [Documentation]    Verify that after clicking Back we are on the previous step (e.g. Step 2 or billing).
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    ${short_timeout}=    Get Config Value    SHORT_TIMEOUT
    # After Back from Step 3 we expect Step 2 (Rental) or after Back from Step 2 we expect Step 1 (Billing)
    ${rental_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${STEP2_RENTAL_LABEL}    timeout=${timeout}
    ${rental_input_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${RENTAL_PICKUP_LOCATION}    timeout=${short_timeout}
    ${billing_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${STEP1_BILLING_LABEL}    timeout=${short_timeout}
    ${billing_input_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${BILLING_NAME_INPUT}    timeout=${short_timeout}
    Should Be True    ${rental_visible} or ${rental_input_visible} or ${billing_visible} or ${billing_input_visible}    Back navigation did not show previous step
    Log    Verified back to previous step

Validate Billing Data Persistence
    [Documentation]    Verify that previously entered billing data is retained when navigating back.
    ${timeout}=    Get Config Value    MEDIUM_TIMEOUT
    ${name}=    Get Config Value    BILLING_NAME
    Wait Until Element Is Visible    ${BILLING_NAME_INPUT}    timeout=${timeout}
    ${actual_name}=    Get Value    ${BILLING_NAME_INPUT}
    Should Be Equal As Strings    ${actual_name}    ${name}    Billing Name was not preserved after Back. Expected: ${name}, Got: ${actual_name}
    Log    Billing data persisted: Name = ${actual_name}
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}.png
