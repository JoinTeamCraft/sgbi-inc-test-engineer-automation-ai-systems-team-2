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

# Common Locators
${LOADING_SPINNER}           xpath=//div[contains(@class, 'loading')]
${ERROR_MESSAGE}             xpath=//div[contains(@class, 'error')]
