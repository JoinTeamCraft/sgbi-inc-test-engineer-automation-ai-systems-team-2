*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords.robot
Resource    ../../resources/locators.robot

*** Variables ***
${BASE_URL}    https://morent-car.archisacademy.com/
${BROWSER}     chrome

*** Test Cases ***
Verify Add Email Address Flow Until Verification Trigger
    [Documentation]    Verify user can add a new email from account settings and verification modal appears
    [Tags]    SG-43    add-email

    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window

    Click Sign In Button
    Enter Email And Continue
    Enter Password And Login
    Enter OTP And Continue
    Click User Profile Icon
    Click Manage Account
    Click Add Email Button
    Enter New Email Address
    Submit New Email
    Verify Verification Modal Appears