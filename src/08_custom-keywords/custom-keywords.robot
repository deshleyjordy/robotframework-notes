*** Settings ***
Documentation    Creating customized keywords in Python to use in Robot Framework
...              https://medium.com/swlh/robot-framework-creating-custom-keywords-78786caa6f89

Library    ../../lib/CustomLibrary.py

*** Test Cases ***
Scenario: Log a random email to the console
   ${randomEmail} =  Generate Random Emails    ${10}
   Log To Console    ${randomEmail}

Scenario: Log a random full name to the console
    ${randomName} =  Generate Random Name
    Log To Console    ${randomName}