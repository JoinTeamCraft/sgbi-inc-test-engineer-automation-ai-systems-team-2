*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Resource          locators.robot
Library    config.env_config.EnvConfig



*** Keywords ***
# Add your common keywords here
Example Keyword
    [Documentation]    Placeholder for a keyword
    No Operation

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
    Capture Page Screenshot    ${TEST NAME}.png
      
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