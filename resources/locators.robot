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

# ============ Home Page ============

${SIGN_IN_BUTTON}                 xpath=//button[text()='Sign in']

# ============ Sign In Page ============

${SIGN_IN_EMAIL_INPUT}            xpath=//input[@placeholder='Enter your email address']
${PASSWORD_FIELD}                 xpath=//input[@id='password-field']
${CONTINUE_BUTTON}                xpath=//button[.//span[text()='Continue']]

# ============ OTP ============
${OTP_INPUT_FIELD}    xpath=//input[@data-input-otp='true']
${OTP_CONTINUE_BUTTON}    xpath=//button[.//span[normalize-space()='Continue']]

# ============ User Menu ============
${USER_PROFILE_ICON}    xpath=//button[@data-clerk-component='UserButton']
${MANAGE_ACCOUNT_BUTTON}          xpath=//button[contains(@class,'manageAccount') or contains(text(),'Manage account')]

# ============ Add Email Flow ============

${ADD_EMAIL_BUTTON}        xpath=//button[contains(@class,'cl-profileSectionPrimaryButton')]
${NEW_EMAIL_INPUT}         xpath=//input[@placeholder='Enter your email address']
${ADD_EMAIL_SUBMIT_BUTTON}      xpath=//button[@data-localization-key="userProfile.formButtonPrimary__add"]

# ============ Verification Modal ============
${VERIFICATION_MODAL_TEXT}      xpath=//*[contains(text(),"Verify email address")]