*** Settings ***
Library    SeleniumLibrary
Resource   locators.robot

*** Keywords ***
# ============ Sign In Flow ============

Click Sign In Button
    [Documentation]    Click the Sign in button on home page
    Wait Until Element Is Visible    ${SIGN_IN_BUTTON}    timeout=10s
    Click Element    ${SIGN_IN_BUTTON}

Enter Email And Continue
    [Documentation]    Enter email in sign in page and click continue
    Wait Until Element Is Visible    ${SIGN_IN_EMAIL_INPUT}    timeout=10s
    Input Text    ${SIGN_IN_EMAIL_INPUT}    hamee+clerk_test@example.com
    Click Element    ${CONTINUE_BUTTON}
    Sleep    2s

Enter Password And Login
    [Documentation]    Enter password and complete login
    Wait Until Element Is Visible    ${PASSWORD_FIELD}    timeout=10s
    Input Text    ${PASSWORD_FIELD}    Shaheem@2001
    Click Element    ${CONTINUE_BUTTON}
    Sleep    3s

Enter OTP And Continue
    Wait Until Element Is Visible    ${OTP_INPUT_FIELD}    timeout=25s
    Input Text    ${OTP_INPUT_FIELD}    424242

    # Wait for Continue button to become visible and enabled
    Wait Until Element Is Visible    ${OTP_CONTINUE_BUTTON}    timeout=15s
    Wait Until Element Is Enabled    ${OTP_CONTINUE_BUTTON}    timeout=15s

    Click Element    ${OTP_CONTINUE_BUTTON}

    # Wait for login redirect
    Wait Until Location Contains    morent-car.archisacademy.com    timeout=30s
    Wait Until Element Is Visible    ${USER_PROFILE_ICON}    timeout=25s

Click User Profile Icon
    Wait Until Element Is Visible    ${USER_PROFILE_ICON}    timeout=20s
    Wait Until Keyword Succeeds    20s    2s
    ...    Click Element    ${USER_PROFILE_ICON}

Open Manage Account
    Wait Until Element Is Visible    ${USER_PROFILE_BUTTON}    timeout=15s
    Click Element    ${USER_PROFILE_BUTTON}
    Sleep    1s
    Wait Until Element Is Visible    ${MANAGE_ACCOUNT_BUTTON}    timeout=10s
    Click Element    ${MANAGE_ACCOUNT_BUTTON}
    Sleep    2s

Click Add Email Button
    Wait Until Element Is Visible    ${ADD_EMAIL_BUTTON}    timeout=10s
    Click Element    ${ADD_EMAIL_BUTTON}
    Sleep    1s

Enter New Email Address
    Wait Until Element Is Visible    ${NEW_EMAIL_INPUT}    timeout=10s
    Input Text    ${NEW_EMAIL_INPUT}    doen+clerk_test@example.com

Submit New Email
    Wait Until Element Is Visible    ${ADD_EMAIL_SUBMIT_BUTTON}    timeout=10s
    Click Element    ${ADD_EMAIL_SUBMIT_BUTTON}
    Sleep    2s

Verify Verification Modal Appears
    Wait Until Element Is Visible    ${VERIFICATION_MODAL_TEXT}    timeout=15s
    Page Should Contain    Verify email address