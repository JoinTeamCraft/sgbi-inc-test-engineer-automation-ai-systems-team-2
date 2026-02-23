*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource    ../../resources/keywords.robot
Resource    ../../resources/locators.robot

*** Variables ***
${BASE_URL}              https://morent-car.archisacademy.com/
${BROWSER}               chrome

*** Test Cases ***
Test Complete Sign In And Email Verification Flow
    [Documentation]    Test sign in, account creation, and email verification up to the verification step
    [Tags]    email-verification    account-creation    signin

    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Load Is Complete
    Sleep    2s

    Click Sign In Button
    Sleep    2s
    Click Sign Up Link
    Sleep    2s

    # Account Creation Flow
    Enter First Name    Shaik
    Enter Last Name    Shaheem
    Enter Email For Account Creation    8344295707shaik@gmail.com
    Enter Password    Shaheem@2001
    Click Create Account Continue Button

    # Wait for CAPTCHA and let user manually complete it
    Wait For Manual Captcha Completion

    # Email Verification Flow
    Verify Email Verification Page Is Displayed
    Verify Email Verification Modal Elements

    Log    Email verification page successfully displayed with code input fields

    [Teardown]    Close Browser


*** Keywords ***
Wait For Manual Captcha Completion
    [Documentation]    Wait for user to manually complete Cloudflare CAPTCHA
    Log    CAPTCHA DETECTED! Please complete the "Verify you are human" checkbox in the browser window.    WARN

    # Check if CAPTCHA checkbox is visible
    ${captcha_visible}=    Run Keyword And Return Status    Element Should Be Visible    //input[@type='checkbox']    timeout=5s

    Run Keyword If    ${captcha_visible}
    ...    Log    Step 1: Look for the checkbox labeled "Verify you are human" with Cloudflare logo    WARN

    Run Keyword If    ${captcha_visible}
    ...    Log    Step 2: Click on the checkbox to complete the verification    WARN

    Run Keyword If    ${captcha_visible}
    ...    Log    Step 3: Wait for verification to complete (usually 3-10 seconds)    WARN

    Run Keyword If    ${captcha_visible}
    ...    Log    After clicking CAPTCHA, the page will automatically proceed...    WARN

    # Wait up to 60 seconds for page to change after CAPTCHA is clicked
    Wait Until Page Contains    Verify your email    timeout=60s

    Log    CAPTCHA completed successfully! Proceeding with test...    INFO