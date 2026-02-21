*** Settings ***
Documentation     Template for reusable keywords
Library           SeleniumLibrary
Library           String
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

Verify Header Section Is Visible
    [Documentation]    Verify that the Header section is visible on the Home page.
    Element Should Be Visible    ${HEADER_SECTION}
    ${header_sec}=    Get Config Value    HEADER_SECTION_SCREENSHOT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Capture Page Screenshot    ${screenshot_name}_${header_sec}
    
Verify Application Logo Is Visible
    [Documentation]    Verify that the application logo is visible in the Header section.
    Element Should Be Visible    ${HOME_PAGE_LOGO}

Verify Home Page Search Bar Is Visible
    [Documentation]    Verify that the search bar is visible on the Home page.
    Element Should Be Visible    ${HOME_PAGE_SEARCH_BAR}

Verify Favorite Icon Is Visible
    [Documentation]    Verify that the Favorite icon is visible in the Header section.
    Element Should Be Visible    ${FAVORITE_LINK}

Verify Orders Icon Is Visible
    [Documentation]    Verify that the Orders icon is visible in the Header section.
    Element Should Be Visible    ${ORDERS_LINK}

Verify Settings Button Is Visible
    [Documentation]    Verify that the User Settings button is visible in the Header section.
    Element Should Be Visible    ${USER_SETTINGS_BUTTON}

Verify Sign In Button Is Visible
    [Documentation]    Verify that the Sign In button is visible in the Header section.
    Element Should Be Visible    ${SIGN_IN_BUTTON}

Verify Navigation Clickability
    [Documentation]    Click each navigation item and verify URL redirection
    
    # Sign In
    Verify SignIn Navigation
    Go Back
    Wait For Page To Load Completely

    # Favorites
    Verify Favorites Navigation
    Go Back
    Wait For Page To Load Completely

    # Orders
    Verify Orders Navigation 
    Go Back
    Wait For Page To Load Completely

    # Settings
    Verify Settings Clickability
    Go Back
    Wait For Page To Load Completely

Verify Favorites Navigation
    [Documentation]    Click the Favorite icon and verify that it navigates to the Favorites page.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Wait Until Element Is Visible    ${FAVORITE_LINK}    ${timeout}
    Wait Until Element Is Enabled    ${FAVORITE_LINK}    ${timeout}
    Click Element    ${FAVORITE_LINK}
    ${fav_url}=    Get Config Value    FAVORITES_URL
    Wait Until Location Contains    ${fav_url}    ${timeout}
    ${fav_screenshot}=    Get Config Value    FAVOURITE_NAVIGATION_SCREENSHOT
    Capture Page Screenshot    ${screenshot_name}_${fav_screenshot}

Verify Orders Navigation
    [Documentation]    Click the Orders icon and verify that it navigates to the Orders page.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Wait Until Element Is Visible    ${ORDERS_LINK}    ${timeout}
    Wait Until Element Is Enabled    ${ORDERS_LINK}    ${timeout}
    Click Element    ${ORDERS_LINK}
    ${orders_url}=    Get Config Value    ORDERS_URL
    Wait Until Location Contains    ${orders_url}    ${timeout}
    ${orders_screenshot}=    Get Config Value    ORDERS_NAVIGATION_SCREENSHOT
    Capture Page Screenshot    ${screenshot_name}_${orders_screenshot}

Verify SignIn Navigation
    [Documentation]    Click the Sign In button and verify that it navigates to the Sign In page.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Wait Until Element Is Visible    ${SIGN_IN_BUTTON}    ${timeout}
    Wait Until Element Is Enabled    ${SIGN_IN_BUTTON}    ${timeout}
    Click Element    ${SIGN_IN_BUTTON}
    ${sign_in_text}=    Get Config Value    SIGN_IN_PAGE_TEXT
    Wait Until Page Contains    ${sign_in_text}    ${timeout}
    ${sign_in_page_title}=    Get Config Value    SIGN_IN_PAGE_TITLE
    Title Should Be    ${sign_in_page_title}
    ${sign_in_screenshot}=    Get Config Value    SIGN_IN_NAVIGATION_SCREENSHOT
    Capture Page Screenshot    ${screenshot_name}_${sign_in_screenshot}

Verify Settings Clickability
    [Documentation]    Click the User Settings button and verify that it navigates to the Settings page.
    ${timeout}=    Get Config Value    LONG_TIMEOUT
    ${screenshot_name}=    Replace String    ${TEST NAME}    ${SPACE}    _
    Wait Until Element Is Visible    ${USER_SETTINGS_BUTTON}    ${timeout}
    Wait Until Element Is Enabled    ${USER_SETTINGS_BUTTON}    ${timeout}
    Click Element    ${USER_SETTINGS_BUTTON}
    ${settings_screenshot}=    Get Config Value    SETTINGS_NAVIGATION_SCREENSHOT
    Capture Page Screenshot    ${screenshot_name}_${settings_screenshot}