*** Settings ***
Documentation     Template for common locators
Library           SeleniumLibrary

*** Variables ***
# Prefer stable attributes (e.g. data-testid) from the frontend when available; complex XPath is brittle.
# Prioritise working with the frontend team to add stable identifiers (e.g. data-testid) and replace these locators.
# Add your application locators here
# ${EXAMPLE_LOCATOR}    id=example

# Home Page Locators
${HOME_SEARCH_BUTTON}    xpath=//button/span[text()='Search']
${HOME_PAGE_LOGO}    xpath=//a/span[text()='MORENT']
${HOME_PAGE_MAIN_CONTAINER}    xpath=//main[contains(@class,'container')]
${HOME_PAGE_SEARCH_BAR}    xpath=//input[@type='search' and @placeholder='Search something here']
${HOME_PAGE_CAR_CARD}    xpath=//div[contains(@class, 'car-card') or contains(@class, 'carCard') or contains(@class, 'car_card')] | //div[contains(@class, 'card') and .//button[contains(text(), 'Rent Now')]] | //*[.//button[contains(text(), 'Rent Now') or contains(., 'Rent Now')]][contains(@class, 'card') or contains(@class, 'item') or contains(@class, 'product')]
${HOME_PAGE_RENT_NOW_BUTTON}    xpath=(//div[contains(@class, 'car-card') or contains(@class, 'carCard') or contains(@class, 'car_card')] | //div[contains(@class, 'card')])//button[contains(text(), 'Rent Now') or contains(., 'Rent Now')]
${CAR_DETAILS_PAGE}    xpath=//div[contains(@class, 'car-details') or contains(@class, 'booking') or contains(@class, 'detail')] | //main[contains(@class, 'detail')] | //section[contains(@class, 'car')]
${CAR_DETAILS_TITLE}    xpath=//h1[contains(@class, 'car-title') or contains(@class, 'title')] | //h2[contains(@class, 'car-title') or contains(@class, 'title')] | //h1 | //h2[contains(text(), 'Car') or contains(text(), 'Rent')]

# Show More Cars (SG-26)
${HOME_PAGE_SHOW_MORE_CARS_BUTTON}    xpath=//button[contains(text(), 'Show More Cars') or contains(., 'Show More Cars')] | //a[contains(text(), 'Show More Cars') or contains(., 'Show More Cars')] | //*[contains(text(), 'Show More Cars') or contains(., 'Show More Cars')][self::button or self::a or (contains(@class, 'button') or contains(@role, 'button'))]
# Car card structure (within a card: image, name, price, Rent Now)
${CAR_CARD_IMAGE}    xpath=.//img[contains(@class, 'car') or contains(@alt, 'car') or contains(@src, 'car') or contains(@src, 'image')] | .//*[contains(@class, 'image') or contains(@class, 'img')]//img
${CAR_CARD_NAME}    xpath=.//h3 | .//h4 | .//*[contains(@class, 'name') or contains(@class, 'title')][self::h3 or self::h4 or self::div or self::span]
${CAR_CARD_PRICE}    xpath=.//*[contains(text(), '$') or contains(., '$') or contains(@class, 'price')]
${CAR_CARD_RENT_NOW}    xpath=.//button[contains(text(), 'Rent Now') or contains(., 'Rent Now')]

# Booking Flow (SG-27) - Step progression
${CAR_DETAILS_RENT_NOW_BUTTON}    xpath=//button[contains(text(), 'Rent Now') or contains(., 'Rent Now')] | //a[contains(text(), 'Rent Now') or contains(., 'Rent Now')] | //button[contains(text(), 'Book') or contains(., 'Book')] | //*[contains(text(), 'Rent Now') and (self::button or self::a)]
# Step 1 – Billing Information (flexible for different DOMs)
${BOOKING_STEP_INDICATOR}    xpath=//*[contains(text(), 'Step') and (contains(text(), 'of') or contains(., 'of'))] | //*[contains(@class, 'step')]
${BILLING_NAME_INPUT}    xpath=//input[@name='name' or @id='name' or @placeholder='Name' or contains(@placeholder, 'name') or contains(@placeholder, 'Name')] | (//form//input[@type='text'])[1] | //label[contains(., 'Name')]/following::input[1] | //input[contains(@aria-label, 'name') or contains(@aria-label, 'Name')]
${BILLING_PHONE_INPUT}    xpath=//input[@name='phone' or @id='phone' or @type='tel' or contains(@placeholder, 'Phone') or contains(@placeholder, 'phone')] | (//form//input[@type='tel'])[1] | //label[contains(., 'Phone')]/following::input[1]
${BILLING_ADDRESS_INPUT}    xpath=//input[@name='address' or @id='address' or contains(@placeholder, 'Address') or contains(@placeholder, 'address')] | (//form//input[contains(@name, 'address') or contains(@placeholder, 'address')])[1] | //label[contains(., 'Address')]/following::input[1]
${BILLING_CITY_INPUT}    xpath=//input[@name='city' or @id='city' or contains(@placeholder, 'City') or contains(@placeholder, 'Town') or contains(@placeholder, 'town')] | (//form//input[contains(@name, 'city') or contains(@placeholder, 'city')])[1] | //label[contains(., 'City') or contains(., 'Town')]/following::input[1]
${BOOKING_NEXT_BUTTON}    xpath=//button[contains(text(), 'Next') or contains(., 'Next')] | //a[contains(text(), 'Next') or contains(., 'Next')] | //*[@type='submit' and (contains(text(), 'Next') or contains(., 'Next'))]
${BOOKING_BACK_BUTTON}    xpath=//button[contains(text(), 'Back') or contains(., 'Back')] | //a[contains(text(), 'Back') or contains(., 'Back')]
# Step 2 – Rental Information (Pick-Up / Drop-Off)
${RENTAL_PICKUP_LOCATION}    xpath=//input[contains(@placeholder, 'Pick') or contains(@placeholder, 'pick') or contains(@name, 'pickup')] | //label[contains(text(), 'Pick') or contains(text(), 'Pick-Up')]/following::input[1] | //*[contains(@id, 'pickup')]//input
${RENTAL_DROPOFF_LOCATION}    xpath=//input[contains(@placeholder, 'Drop') or contains(@placeholder, 'drop') or contains(@name, 'dropoff')] | //label[contains(text(), 'Drop') or contains(text(), 'Drop-Off')]/following::input[1] | //*[contains(@id, 'dropoff')]//input
${RENTAL_PICKUP_DATE}    xpath=//input[@type='date' or contains(@placeholder, 'date') or contains(@name, 'date')][1] | //*[contains(@id, 'pickup') or contains(@name, 'pickup')]//input[@type='date' or contains(@placeholder, 'Date')]
${RENTAL_DROPOFF_DATE}    xpath=//input[@type='date' or contains(@placeholder, 'date') or contains(@name, 'date')][2] | //*[contains(@id, 'dropoff') or contains(@name, 'dropoff')]//input[@type='date' or contains(@placeholder, 'Date')]
${RENTAL_PICKUP_TIME}    xpath=//input[@type='time' or contains(@placeholder, 'time') or contains(@name, 'time')][1]
${RENTAL_DROPOFF_TIME}    xpath=//input[@type='time' or contains(@placeholder, 'time') or contains(@name, 'time')][2]
# Step labels for verification
${STEP1_BILLING_LABEL}    xpath=//*[contains(text(), 'Billing') or contains(text(), 'billing') or contains(., 'Step 1')]
${STEP2_RENTAL_LABEL}    xpath=//*[contains(text(), 'Rental Information') or contains(text(), 'Rental') or contains(., 'Step 2')]

# Common Locators
${LOADING_SPINNER}           xpath=//div[contains(@class, 'loading')]
${ERROR_MESSAGE}             xpath=//div[contains(@class, 'error')]
