*** Settings ***
Documentation    Cookie information
...              name:      session-username
...              value:     standard_user
...              domain:    www.saucedemo.com
...              path:	    /
...              expires:   Thu, 25 Jan 2024 19:08:45 GMT
...              secure:    false

Library          SeleniumLibrary    run_on_failure=None
Resource         cookies.setup.robot

Test Setup      SetupCookies
Test Teardown   Close All Browsers

*** Variables ***
${deeplink}        https://www.saucedemo.com/inventory.html

*** Test Cases ***
Scenario: The user adds a new cookie
    # Adds cookie with correct username
    Add Cookie    session-username    standard_user

    # Returns cookie information as an object/attributes and store it in a variable
    ${cookie}=    Get Cookie    session-username
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

    # Add the secret cookie and try again
    Add Cookie    session-username    standard_user
    Go To    ${deeplink}

    # Validate log in
    Wait Until Element Is Visible    id:inventory_container

Scenario: The user logs in and a new cookie is created
    # Log in to the system
    Wait Until Element Is Visible    id:user-name
    Input Text    id:user-name    standard_user

    Wait Until Element Is Visible    id:password
    Input Password    id:password    secret_sauce
    
    Click Button    id:login-button
    Wait Until Element Is Visible    id:inventory_container

    # Check if cookie exist and validate information
    ${cookie}=    Get Cookie    session-username
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
    ${cookie}=    Get Cookie    session-username
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
Scenario: The user adds multiple new cookies with valid log in information
Scenario: The user adds multiple new cookies and uses the keyword 'Get cookies'
Scenario: The user logs in with a valid account, then 'change' the cookie with an invalid account