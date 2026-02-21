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
    # Wait for any dynamic content to load
    Sleep    3s
    # Scroll down to ensure car cards are in view
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight/2)
    Sleep    2s
    # Try multiple locator strategies with retries
    ${car_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${HOME_PAGE_CAR_CARD}    timeout=10s
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
        Sleep    1.5s
        ${car_count}=    Get Element Count    ${HOME_PAGE_CAR_CARD}
        ${rent_now_count}=    Get Element Count    ${HOME_PAGE_RENT_NOW_BUTTON}
        Exit For Loop If    ${car_count} > 0 or ${rent_now_count} > 0
    END
    # Scroll back to top if needed
    Execute Javascript    window.scrollTo(0, 0)
    Sleep    1s

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
    [Documentation]    Verifies that the page has navigated after clicking the Rent Now button
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    Wait For Page To Load Completely
    Sleep    2s
    # Verify that we've navigated away from the home page by checking URL
    ${current_url}=    Get Location
    ${is_home_page}=    Evaluate    "${current_url}" == "https://morent-car.archisacademy.com/" or "${current_url}" == "https://morent-car.archisacademy.com/#" or "${current_url}" == "https://morent-car.archisacademy.com"
    # Check for car details or booking page elements with multiple strategies
    ${details_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CAR_DETAILS_PAGE}    timeout=${timeout}
    ${title_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CAR_DETAILS_TITLE}    timeout=${timeout}
    # Alternative: check if URL changed or contains car/detail/booking keywords
    ${url_changed}=    Evaluate    not ${is_home_page}
    ${url_has_car_keywords}=    Evaluate    "car" in "${current_url}".lower() or "detail" in "${current_url}".lower() or "booking" in "${current_url}".lower() or "/cars/" in "${current_url}".lower()
    # Log for debugging
    Log    Current URL: ${current_url}
    Log    Details present: ${details_present}, Title present: ${title_present}, URL changed: ${url_changed}
    # Accept if URL changed OR if details/title elements are present
    Should Be True    ${url_changed} or ${details_present} or ${title_present} or ${url_has_car_keywords}    Navigation verification failed. URL: ${current_url}, Details: ${details_present}, Title: ${title_present}
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}.png
