*** Settings ***
Documentation    Cookie information
...              name:      session-username
...              value:     standard_user
...              domain:    www.saucedemo.com
...              path:	    /
...              expires:   Thu, 25 Jan 2024 19:08:45 GMT
...              secure:    false
...              //
...              https://www.geeksforgeeks.org/software-testing-cookie-testing/
...              //
...              $ pip install robotframework-seleniumlibrary

Library          SeleniumLibrary    run_on_failure=None
Resource         cookies.setup.robot

Test Setup      Setup Cookies
Test Teardown   Close All Browsers

*** Variables ***
${deeplink}        https://www.saucedemo.com/inventory.html

*** Test Cases ***
Scenario: The user adds a new cookie
    # Adds cookie with correct username
    Add Cookie    session-username    standard_user

    # Returns cookie information as an object/attributes and store it in a variable
    ${cookie} =    Get Cookie    session-username
    Log    ${cookie}
    Log    ${cookie.name}
    Log    ${cookie.value}
    Log    ${cookie.domain}
    Log    ${cookie.secure}
    Log    ${cookie.httpOnly}
    Log    ${cookie.expiry}

    # Just for example purposes of errors: Get a non existent attribute
    Run Keyword And Expect Error    STARTS: Resolving variable   Log    ${cookie.chocolate}
    
    # Validate cookie information
    Should Be Equal    ${cookie.name}    session-username
    Should Be Equal    ${cookie.value}    standard_user
    Should Be Equal    ${cookie.domain}    www.saucedemo.com
    Should Be Equal    ${cookie.secure}    ${True}
    Should Be Equal    ${cookie.httpOnly}    ${False}
    Should Be Equal    ${cookie.expiry}    ${None}

Scenario: The user visits a protected deeplink without logging in, but with adding a secret cookie
    # Visit deeplink without logging in
    Go To    ${deeplink}
    Wait Until Element Is Visible    //h3[contains(@data-test, 'error')]
    Element Should Not Be Visible    id:inventory_container

    # Add the secret cookie and try again
    Add Cookie    session-username    standard_user
    Go To    ${deeplink}

    # Validate log in
    Wait Until Element Is Visible    id:inventory_container

Scenario: The user logs in and a new cookie is created
    # Check if cookie does not exist
    Run Keyword And Expect Error    Cookie with name 'session-username' not found.    Get Cookie    session-username
    
    # Log in to the system
    Wait Until Element Is Visible    id:user-name
    Input Text    id:user-name    standard_user

    Wait Until Element Is Visible    id:password
    Input Password    id:password    secret_sauce
    
    Click Button    id:login-button
    Wait Until Element Is Visible    id:inventory_container

    # Check if cookie exist and validate information
    ${cookie} =    Get Cookie    session-username
    Should Be Equal    ${cookie.name}    session-username
    Should Be Equal    ${cookie.value}    standard_user
    Should Be Equal    ${cookie.domain}    www.saucedemo.com
    
Scenario: The user logs out of the system and the cookies get deleted correctly
    # Log in to the system
    Wait Until Element Is Visible    id:user-name
    Input Text    id:user-name    standard_user

    Wait Until Element Is Visible    id:password
    Input Password    id:password    secret_sauce
    
    Click Button    id:login-button
    Wait Until Element Is Visible    id:inventory_container

    # Check if cookie exist and validate information
    ${cookie} =    Get Cookie    session-username
    Should Be Equal    ${cookie.name}    session-username
    Should Be Equal    ${cookie.value}    standard_user
    Should Be Equal    ${cookie.domain}    www.saucedemo.com

    # Log out of the system
    Wait Until Element Is Visible    id:react-burger-menu-btn
    Click Element    id:react-burger-menu-btn

    Wait Until Element Is Visible    id:logout_sidebar_link
    Click Element    id:logout_sidebar_link
    Wait Until Element Is Visible    login_button_container
    
    # Checks if cookie is deleted
    Run Keyword And Expect Error    Cookie with name 'session-username' not found.    Get Cookie    session-username

Scenario: The user deletes a cookie while logged in and tries to continue browsing the website
    [Documentation]    The user is expected to be logged out of the system
    # Log in to the system
    Wait Until Element Is Visible    id:user-name
    Input Text    id:user-name    standard_user

    Wait Until Element Is Visible    id:password
    Input Password    id:password    secret_sauce
    
    Click Button    id:login-button
    Wait Until Element Is Visible    id:inventory_container

    # Check if cookie exist and validate information
    ${cookie} =    Get Cookie    session-username
    Should Be Equal    ${cookie.name}    session-username
    Should Be Equal    ${cookie.value}    standard_user
    Should Be Equal    ${cookie.domain}    www.saucedemo.com

    # Delete the cookie and verify if deleted
    Delete Cookie    session-username
    Run Keyword And Expect Error    Cookie with name 'session-username' not found.    Get Cookie    session-username

    # The user should not be able to navigate to an other page and will be logged out
    Wait Until Element Is Visible    id:item_4_title_link
    Click Element    id:item_4_title_link

    Page Should Not Contain    Sauce Labs Backpack
    Wait Until Element Is Visible    //h3[contains(@data-test, 'error')]

Scenario: The user adds multiple new cookies with valid log in information
    [Documentation]    This is not even possible. The 'new' cookie will get the same name of 'session-username',
    ...                meaning the 'old' cookie with the same name will automatically be deleted. It will overwrite.
    No Operation

Scenario: The user adds multiple new cookies and uses the keyword 'Get cookies'
    # Adds cookie with correct username
    Add Cookie    session-username    standard_user
    Add Cookie    sample-name    sample-value

    # Get cookies and log as a string
    ${cookies} =  Get Cookies
    Log    ${cookies}

    # Get cookies and log as a Robot Framework dictionary
    ${cookies} =  Get Cookies    as_dict=true
    Log    ${cookies}