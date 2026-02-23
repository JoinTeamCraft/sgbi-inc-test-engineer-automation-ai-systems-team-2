*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
# Add your application locators here
# ${EXAMPLE_LOCATOR}    id=example

# Home Page Locators
${HOME_SEARCH_BUTTON}    xpath=//button/span[text()='Search']
${HOME_PAGE_LOGO}    xpath=//a/span[text()='MORENT']
${HOME_PAGE_MAIN_CONTAINER}    xpath=//main[contains(@class,'container')]
${HOME_PAGE_SEARCH_BAR}    xpath=//input[@type='search' and @placeholder='Search something here']

*** Variables ***
# Sign In Page Locators
${SIGN_IN_BUTTON}                   //button[text()='Sign in']
${SIGN_UP_LINK}                     //a[contains(text(),'Sign up')]

# Account Creation Page Locators
${FIRST_NAME_FIELD}                 //input[@id='firstName-field']
${LAST_NAME_FIELD}                  //input[@id='lastName-field']
${EMAIL_ADDRESS_FIELD}              //input[@id='emailAddress-field']
${PASSWORD_FIELD}                   //input[@id='password-field']
${CREATE_ACCOUNT_CONTINUE_BUTTON}    //button[.//span[text()='Continue']]

# CAPTCHA Locators
${CLOUDFLARE_CAPTCHA_CHECKBOX}      //input[@type='checkbox'][@aria-label='Verify you are human']
${CAPTCHA_FRAME}                    //iframe[contains(@src, 'challenges.cloudflare.com')]

# Email Verification Page Locators
${EMAIL_VERIFICATION_TITLE}         //h1[contains(text(), 'Verify your email')]
${VERIFICATION_CODE_INPUTS}         //input[@maxlength='1']
${VERIFICATION_CONTINUE_BUTTON}     //button[.//span[text()='Continue']]

# Account Settings/Profile Locators
${ACCOUNT_MENU}                     //button[contains(@aria-label, 'Account')]
${SETTINGS_LINK}                    //a[contains(text(), 'Settings')]

# Add Email Address Locators
${ADD_EMAIL_BUTTON}                 //button[contains(text(), 'Add email')]
${NEW_EMAIL_INPUT}                  //input[@placeholder='Enter new email address']
${ADD_EMAIL_SUBMIT_BUTTON}          //button[.//span[text()='Add']]
