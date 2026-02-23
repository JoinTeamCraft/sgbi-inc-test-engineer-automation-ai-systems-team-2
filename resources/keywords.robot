*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
# ============ Sign In Keywords ============
Click Sign In Button
    [Documentation]    Click the Sign in button on the home page
    Wait Until Element Is Visible    //button[text()='Sign in']    timeout=10s
    Sleep    1s
    Click Element    //button[text()='Sign in']
    Wait Until Page Contains    Sign in to Morent    timeout=10s
    Sleep    2s

Click Sign Up Link
    [Documentation]    Click the Sign up link on sign in page
    Wait Until Element Is Visible    //a[contains(text(),'Sign up')]    timeout=10s
    Sleep    1s
    Click Element    //a[contains(text(),'Sign up')]
    Wait Until Page Contains    Create your account    timeout=15s
    Sleep    3s

# ============ Account Creation Keywords ============
Enter First Name
    [Arguments]    ${first_name}
    [Documentation]    Enter first name in account creation form
    Wait Until Element Is Visible    //input[@id='firstName-field']    timeout=10s
    Sleep    1s
    Click Element    //input[@id='firstName-field']
    Sleep    0.5s
    Input Text    //input[@id='firstName-field']    ${first_name}
    Sleep    1s

Enter Last Name
    [Arguments]    ${last_name}
    [Documentation]    Enter last name in account creation form
    Wait Until Element Is Visible    //input[@id='lastName-field']    timeout=10s
    Sleep    1s
    Click Element    //input[@id='lastName-field']
    Sleep    0.5s
    Input Text    //input[@id='lastName-field']    ${last_name}
    Sleep    1s

Enter Email For Account Creation
    [Arguments]    ${email}
    [Documentation]    Enter email address in account creation form
    Wait Until Element Is Visible    //input[@id='emailAddress-field']    timeout=10s
    Sleep    1s
    Click Element    //input[@id='emailAddress-field']
    Sleep    0.5s
    Input Text    //input[@id='emailAddress-field']    ${email}
    Sleep    1s

Enter Password
    [Arguments]    ${password}
    [Documentation]    Enter password in account creation form
    Wait Until Element Is Visible    //input[@id='password-field']    timeout=10s
    Sleep    1s
    Click Element    //input[@id='password-field']
    Sleep    0.5s
    Input Text    //input[@id='password-field']    ${password}
    Sleep    1s

Click Create Account Continue Button
    [Documentation]    Click Continue button on account creation page
    Wait Until Element Is Visible    //button[.//span[text()='Continue']]    timeout=10s
    Sleep    2s
    Click Element    //button[.//span[text()='Continue']]
    Sleep    3s

# ============ Email Verification Keywords ============
Verify Email Verification Page Is Displayed
    [Documentation]    Verify that the email verification page is displayed
    Wait Until Page Contains    Verify your email    timeout=15s
    Wait Until Element Is Visible    //h1[contains(text(), 'Verify your email')]    timeout=10s
    Page Should Contain Element    //h1[contains(text(), 'Verify your email')]
    Sleep    2s

Verify Email Verification Modal Elements
    [Documentation]    Verify the presence of verification code input fields
    Wait Until Element Is Visible    //input[@maxlength='1']    timeout=15s
    Element Should Be Visible    //input[@maxlength='1']
    Wait Until Page Contains Element    //button[.//span[text()='Continue']]    timeout=10s
    Page Should Contain Element    //button[.//span[text()='Continue']]
    Log    Email verification modal with code input fields is visible    INFO

# ============ Profile/Account Settings Keywords ============
Navigate To Account Settings
    [Documentation]    Navigate to Account Settings from the profile menu
    Wait Until Element Is Visible    //button[contains(@aria-label, 'Account')]    timeout=10s
    Sleep    1s
    Click Element    //button[contains(@aria-label, 'Account')]
    Sleep    2s
    Wait Until Element Is Visible    //a[contains(text(), 'Settings')]    timeout=10s
    Click Element    //a[contains(text(), 'Settings')]
    Wait Until Page Contains    Settings    timeout=10s
    Sleep    2s

Click Add Email Button
    [Documentation]    Click on Add email button in account settings
    Wait Until Element Is Visible    //button[contains(text(), 'Add email')]    timeout=10s
    Sleep    1s
    Click Element    //button[contains(text(), 'Add email')]
    Wait Until Page Contains    Add email address    timeout=10s
    Sleep    2s

Enter New Email Address
    [Arguments]    ${email}
    [Documentation]    Enter new email address to be added
    Wait Until Element Is Visible    //input[@placeholder='Enter new email address']    timeout=10s
    Sleep    1s
    Click Element    //input[@placeholder='Enter new email address']
    Sleep    0.5s
    Input Text    //input[@placeholder='Enter new email address']    ${email}
    Sleep    1s

Click Add Email Submit Button
    [Documentation]    Click the Add button to submit new email
    Wait Until Element Is Visible    //button[.//span[text()='Add']]    timeout=10s
    Sleep    1s
    Click Element    //button[.//span[text()='Add']]
    Sleep    3s

Wait Until Page Load Is Complete
    [Documentation]    Wait for page to load completely
    Wait Until Element Is Visible    //body    timeout=10s
    Sleep    2s
