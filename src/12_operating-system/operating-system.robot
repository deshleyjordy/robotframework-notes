*** Settings ***
Library         OperatingSystem

*** Variables ***
${PATH}         ${CURDIR}/example.txt

*** Test Cases ***
Scenario: System shows the current directory
    # Check the path of ${CURDIR}
    Log To Console    This is the current directory: ${CURDIR}

Scenario: Create a new file in current directory
    # Creates a new file to path with some text
    Create File          ${PATH}    Some text

    # Validates if file exist
    File Should Exist    ${PATH}

    # Makes a copy of the file and copies it to the main directory
    Copy File            ${PATH}    c:\\Users\\Deshley\\Github\\robotframework-notes