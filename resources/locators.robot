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

# Header Locators
${HEADER_SECTION}    xpath=//header[contains(@class,'header')]
${FAVORITE_LINK}    xpath=//a[contains(@href,'/favourites')]//button[@aria-label='Favorite Icon']
${ORDERS_LINK}    xpath=//a[contains(@href,'/orders')]//button[@aria-label='Notification Icon']
${USER_SETTINGS_BUTTON}    xpath=//button[@aria-label='User Settings']
${SIGN_IN_BUTTON}    xpath=//div[contains(@class,'user-sign')]

# Sign In Page Locators
${SIGN_UP_LINK}    xpath=//a[contains(@href,'sign-up') and text()='Sign up']

# Registration Page Locators
${REGISTRATION_FORM}    xpath=//div[contains(@class,'componentContainer')]/div[contains(@data-clerk-component,'SignUp')]
${REGISTRATION_FIRST_NAME_FIELD}    xpath=//input[@name='firstName']
${REGISTRATION_LAST_NAME_FIELD}    xpath=//input[@name='lastName']
${REGISTRATION_EMAIL_FIELD}    xpath=//input[@name='emailAddress']
${REGISTRATION_PASSWORD_FIELD}    xpath=//input[@name='password']
${REGISTRATION_CONTINUE_BUTTON}    xpath=//button[contains(@class,'formButton')]/span[text()='Continue']

# Mandatory Field Validation Locators
${REGISTRATION_EMAIL_FIELD_REQUIRED}           xpath=//input[@name='emailAddress' and @required]
${REGISTRATION_PASSWORD_FIELD_REQUIRED}    xpath=//input[@name='password' and @required]
