*** Settings ***
Documentation    Testing some keywords from the BuiltIn Library
...              //
...              No need to install, it exists within RF

Library          SeleniumLibrary

*** Test Cases ***
Scenario: System logs all available and hidden variables
    [Documentation]    Hidden variables are also shown by this keywords
    ...                Check the logs
    Log Variables

Scenario: System logs the current Robot Framework version to the console
    ${version} =  Evaluate    robot.__version__
    Log To Console    ${version}

Scernario: Evaluating expressions
    Set Test Variable    ${result}    3.14
    ${status} =  Evaluate    0 < ${result} < 10
    Log To Console    ${status}