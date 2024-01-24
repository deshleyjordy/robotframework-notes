*** Settings ***
Documentation    The special keywords for radio buttons like 'Select Radio Button' doesn't work with data-ta-id's
...              Here an example of 'normal' radio buttons to see how this works.

Library          SeleniumLibrary    run_on_failure=None
Resource         radiobuttons.setup.robot

Suite Setup      SetupRadioButtons

*** Variables ***
${groupName}    likeit

*** Test Cases ***
Scenario: De gebruiker maakt een keuze met een radio button via een id
    Given The user clicks on the option 'Radio with id'
    Then The option 'Radio with id' is selected


*** Keywords ***
The user clicks on the option 'Radio with id'
    Select Radio Button    ${groupName}    radioId

The option 'Radio with id' is selected
    Radio Button Should Be Set To    ${groupName}    No