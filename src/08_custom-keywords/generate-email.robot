*** Settings ***
Documentation    Creating customized keywords in Python to use in Robot Framework
...              https://medium.com/swlh/robot-framework-creating-custom-keywords-78786caa6f89

Library    ../../lib/CustomLibrary.py

*** Variables ***
${test}

*** Test Cases ***
Scenario: Log a random email with the custom keyword
   ${randomEmail} =  Generate Random Emails    ${10}
   Log To Console    ${randomEmail}