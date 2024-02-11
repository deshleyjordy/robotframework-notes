*** Settings ***
Documentation    The special keywords for radio buttons like 'Select Radio Button' doesn't work with data-ta-id's
...              Here an example of 'normal' radio buttons to see how this works.
...              //
...              'Radio Button Should Be Set To' only takes a value as argument
...              //
...              'Select Radio Button' takes a value or id as argument
...              //
...              'Radio Button Should Not Be Selected' takes the group name as argument, but a functionality that uses radio buttons has the first option always selected.
...              So this keyword actually never works? Unless executed with some JavaScript in Scenario 4.
...              //
...              $ pip install robotframework-seleniumlibrary

Library          SeleniumLibrary    run_on_failure=None
Resource         radio-buttons.setup.robot

Suite Setup      Setup RadioButtons
Suite Teardown   Close All Browsers

*** Variables ***
${groupName}        likeit
${tempId}           radio5
${option5}          //*[@id="content"]/div/div/div[2]/p/input[5]

*** Test Cases ***
Scenario 1: The user makes a choice by radio button with an id
    Given The user clicks on the option 'Radio with id'
    Then The option 'Radio with id' is selected

Scenario 2: The user makes a choice by radio button with a value
    Given The user clicks on the option 'Radio6'
    Then The option 'Radio6' is selected

Scenario 3: The user clicks for the option 'Radio5' by id
    [Documentation]  The options 'Radio with name' and 'Radio5' have exactly the same attributes with NO specific id's
    Given The user clicks on the option 'Radio5'
    Then The option 'Radio5' is selected

Scenario 4: The user checks an option and tries to uncheck this option
    [Documentation]  This scenario could never happen in production?
    Given The user clicks on the option 'Radio with id'
    When The user executes JavaScript to uncheck this radio button
    Then The user has no options selected

*** Keywords ***
The user clicks on the option 'Radio5'
    Assign Id To Element    ${option5}    ${tempId}
    Select Radio Button    ${groupName}    ${tempId}

The user clicks on the option 'Radio6'
    Select Radio Button    ${groupName}    Not sure

The user clicks on the option 'Radio with id'
    Select Radio Button    ${groupName}    radioId

The option 'Radio5' is selected
    Radio Button Should Be Set To    ${groupName}    No

The option 'Radio6' is selected
    Radio Button Should Be Set To    ${groupName}    Not sure

The option 'Radio with id' is selected
    Radio Button Should Be Set To    ${groupName}    No

The user executes JavaScript to uncheck this radio button
    Execute Javascript    document.getElementById('radioId').checked = false;

The user has no options selected
    Radio Button Should Not Be Selected    ${groupName}