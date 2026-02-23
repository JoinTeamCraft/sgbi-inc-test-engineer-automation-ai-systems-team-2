*** Settings ***
Documentation     Automate the verification of mandatory field validations on the User Registration (Sign Up) form of the MoRent website.
...    This test ensures that the application correctly prevents form submission when required fields are left empty and displays appropriate validation messages to the user.
Resource          ../../resources/keywords.robot
Resource          ../../resources/locators.robot
Test Setup       Open MoRent Application
Test Teardown    Close All Browsers

*** Test Cases ***
SG-4 Verify Mandatory Field Validation on Registration Form
    [Documentation]    Verify that the User Registration (Sign Up) form on the MoRent website enforces mandatory field validations by displaying appropriate error messages when required fields are left empty.
    ...    Launch the MoRent website
    ...    Wait for the Home page to load completely.
    ...    Click the Sign In link from the Home page.
    ...    Navigate to the Registration page from Sign In page.
    ...    Wait for the Registration page to load completely.
    ...    Clear all input fields on the Registration form to ensure they are empty.
    ...    Click the Continue button to attempt form submission with empty fields.
    ...    Verify that validation behavior is triggered for required fields (Email address and Password).    
    ...    Verify that the user remains on the Registration page after the validation is triggered
    ...    Expected Results:
    ...    validation triggered for each required field when left empty.
    ...    The user is not able to proceed to the next step and remains on the Registration page

    [Tags]    smoke    user_registration_mandatory_validation
    Wait For Page To Load Completely
    Navigate To Registration Page
    Verify Registration Page Loaded
    Clear Registration Form Fields
    Verify Mandatory Field Validation Messages
