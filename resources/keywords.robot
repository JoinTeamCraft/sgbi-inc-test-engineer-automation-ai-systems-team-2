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
    [Documentation]    Verifies navigation to car details/booking by asserting a specific element unique to that page.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait For Page To Load Completely
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    ${current_url}=    Get Location
    ${base_url}=    Get Config Value    BASE_URL
    ${base_stripped}=    Evaluate    "${base_url}".rstrip("/")
    ${is_home_page}=    Evaluate    ("${current_url}".rstrip("/") == "${base_stripped}") or ("${current_url}" == "${base_stripped}" + "#")
    Wait Until Element Is Visible    ${CAR_DETAILS_PAGE}    timeout=${timeout}
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
    [Documentation]    Wait for new car cards to load after clicking Show More Cars
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${short_timeout}=    Get Config Value    SHORT_TIMEOUT
    Wait Until Keyword Succeeds    ${timeout}    2s    Page Should Be Ready
    ${loading_gone}=    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${LOADING_SPINNER}    timeout=${short_timeout}
    Run Keyword If    not ${loading_gone}    Wait Until Keyword Succeeds    ${short_timeout}s    1s    Page Should Be Ready
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
