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

# Login (SG-28 and preconditions)
${LOGIN_LINK_OR_BUTTON}    xpath=//a[contains(text(), 'Sign in') or contains(text(), 'Login') or contains(., 'Sign in') or contains(., 'Login')] | //button[contains(text(), 'Sign in') or contains(text(), 'Login') or contains(., 'Sign in') or contains(., 'Login')]
${LOGIN_EMAIL_INPUT}    xpath=//input[@type='email' or @name='email' or @id='email' or contains(@placeholder, 'email') or contains(@placeholder, 'Email')]
${LOGIN_PASSWORD_INPUT}    xpath=//input[@type='password' or @name='password' or @id='password' or contains(@placeholder, 'password') or contains(@placeholder, 'Password')]
${LOGIN_SUBMIT_BUTTON}    xpath=//button[@type='submit' and (contains(text(), 'Sign in') or contains(text(), 'Login') or contains(., 'Sign in') or contains(., 'Login'))] | //button[@type='submit'] | //input[@type='submit'] | //*[@type='submit']
${LOGIN_OTP_INPUT}    xpath=//input[@type='text' and (contains(@placeholder, 'OTP') or contains(@placeholder, 'code') or @name='otp' or @id='otp')] | //input[contains(@placeholder, 'OTP') or contains(@placeholder, 'Code')]
${USER_MENU_OR_AVATAR}    xpath=//*[contains(@class, 'avatar') or contains(@class, 'user') or contains(@class, 'profile') or contains(@aria-label, 'user')] | //img[contains(@alt, 'user') or contains(@alt, 'avatar')]

# Add to Favourites (SG-28) – heart icon on car cards
${CAR_CARD_FAVOURITE_HEART}    xpath=(//div[contains(@class, 'car-card') or contains(@class, 'carCard') or contains(@class, 'card')])//*[local-name()='svg' and (contains(@class, 'heart') or contains(@class, 'favourite') or contains(@class, 'favorite') or contains(@class, 'like') or @aria-label='favourite' or @aria-label='Favorite' or @data-testid='favourite' or @data-testid='favorite')] | (//div[contains(@class, 'car-card') or contains(@class, 'card')])//button[.//*[local-name()='svg'] or contains(@aria-label, 'favour') or contains(@aria-label, 'favor') or contains(@aria-label, 'like')] | (//*[.//button[contains(text(), 'Rent Now')]])//*[local-name()='svg' or self::button][contains(@class, 'heart') or contains(@class, 'favour') or contains(@class, 'favor') or contains(@aria-label, 'favour') or contains(@aria-label, 'favor')]
${FAVOURITE_HEART_ICON}    xpath=//*[local-name()='svg'][contains(@class, 'heart') or contains(@class, 'favourite') or contains(@class, 'favorite') or contains(@class, 'like')] | //button[.//*[local-name()='svg']][contains(@aria-label, 'favour') or contains(@aria-label, 'favor') or contains(@aria-label, 'like')] | //*[@aria-label='Add to favourites' or @aria-label='Add to favorites' or @title='Favourite' or @title='Favorite']
${FAVOURITE_HEART_FILLED}    xpath=//*[local-name()='svg'][contains(@class, 'fill') or contains(@class, 'filled') or .//*[local-name()='path' and contains(@fill, 'currentColor')]] | //*[contains(@class, 'active') or contains(@class, 'selected')][.//*[local-name()='svg']]

# Favourites Page (SG-29)
${HEADER_FAVOURITES_ICON}    xpath=//header//*[contains(@href, 'favourites') or contains(@href, 'favorites') or contains(@aria-label, 'Favourites') or contains(@aria-label, 'Favorites') or contains(@title, 'Favourites') or contains(@title, 'Favorites')] | //header//a[.//*[local-name()='svg']][contains(@class, 'heart') or contains(@class, 'favour') or contains(@class, 'favor')] | //nav//*[contains(text(), 'Favourites') or contains(text(), 'Favorites')] | //header//*[local-name()='svg'][contains(@class, 'heart') or contains(@class, 'favour') or contains(@class, 'favor')]/ancestor::a
${FAVOURITES_PAGE_TITLE}    xpath=//*[contains(text(), 'Your Favourites') or contains(text(), 'Your Favorites') or contains(., 'Your Favourites') or contains(., 'Your Favorites') or contains(text(), 'Favourites') or contains(text(), 'Favorites')]
${FAVOURITES_PAGE_CAR_CARDS}    xpath=//main//div[contains(@class, 'car-card') or contains(@class, 'carCard') or contains(@class, 'card')] | //*[.//button[contains(text(), 'Rent Now') or contains(., 'Rent Now')]][contains(@class, 'card') or contains(@class, 'item')]
# Within a card: car type, capacity/transmission (e.g. "4 people", "Automatic")
${CAR_CARD_TYPE}    xpath=.//*[contains(@class, 'type') or contains(text(), 'SUV') or contains(text(), 'Sedan') or contains(text(), 'Hatchback') or contains(., 'people')] | .//*[contains(@class, 'category') or contains(@class, 'body-type')]
${CAR_CARD_CAPACITY_TRANSMISSION}    xpath=.//*[contains(text(), 'people') or contains(., 'people') or contains(text(), 'Automatic') or contains(text(), 'Manual') or contains(., 'transmission') or contains(@class, 'capacity') or contains(@class, 'transmission')]

# Remove from Favourites (SG-30) – heart on Favourites page to un-favourite
${FAVOURITES_PAGE_CARD_HEART}    xpath=(//main//div[contains(@class, 'card') or contains(@class, 'car-card')])//*[local-name()='svg' and (contains(@class, 'heart') or contains(@class, 'favour') or contains(@class, 'favor'))] | (//main//*[.//button[contains(text(), 'Rent Now')]])//*[local-name()='svg' or self::button][contains(@class, 'heart') or contains(@aria-label, 'favour') or contains(@aria-label, 'favor')]

# Common Locators
${LOADING_SPINNER}           xpath=//div[contains(@class, 'loading')]
${ERROR_MESSAGE}             xpath=//div[contains(@class, 'error')]
