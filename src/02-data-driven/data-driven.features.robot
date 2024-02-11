*** Settings ***
Documentation    Data-driven testing
...              User logs in with multiple invalid data
...              //
...              $ pip install robotframework-seleniumlibrary

Library     SeleniumLibrary
Resource    data-driven.setup.resource

Suite Setup  Setup Data-driven
Suite Teardown  Close All Browsers

Test Template  Login with invalid credentials should fail

*** Variables ***
# Locators
${inputUsername}          id:user-name
${inputPassword}          id:password
${buttonLogin}            id:login-button
${buttonError}            class:error-button
${validation}             css:[data-test="error"]

# Testdata
${validUsername}          standard_user
${validPassword}          secret_sauce


*** Test Cases ***                USERNAME             PASSWORD
Invalid User Name                 invalid              ${validPassword}
Invalid Password                  ${validUsername}     invalid
Invalid User Name and Password    invalid              invalid
Empty User Name                   ${EMPTY}             ${validPassword}
Empty User Name and Password      ${EMPTY}             ${EMPTY}


*** Keywords ***
Login with invalid credentials should fail
    [Arguments]    ${username}    ${password}

    # Validate if input fields are visible
    Wait Until Element Is Visible    ${inputUsername}
    Wait Until Element Is Visible    ${inputPassword}
    Wait Until Element Is Visible    ${buttonLogin}

    # Input user data
    Input Text    ${inputUsername}    ${username}
    Input Text    ${inputPassword}    ${password}
    Click Element    ${buttonLogin}

    # Validate error message
    Page Should Contain Element    ${validation}

    # Clean up validation for the next test
    Wait Until Element Is Visible    ${buttonError}
    Click Button    ${buttonError}
    Wait Until Element Is Not Visible    ${buttonError}

    # Clean up input from previous test
    Clear Element Text    ${inputUsername}
    Clear Element Text    ${inputPassword}
    Element Text Should Be    ${inputUsername}    ${EMPTY}
    Element Text Should Be    ${inputPassword}    ${EMPTY}