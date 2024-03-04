*** Settings ***
Documentation    Testing some regexp
...              //

*** Test Cases ***
Scenario: A user validates a string
    [Documentation]    https://www.w3schools.com/python/python_regex.asp
    # Declare variable
    ${my_string} =    Set Variable    Hello, world!

    # Validate that the string starts with "Hello, " and ends with an exclamation mark
    Should Match Regexp    ${my_string}    Hello, .*!

    # Should start with 'The' and end with 'Spain' string
    Should Match Regexp    The rain in Spain    ^The.*Spain$

Scenario: A user validates an email
    # Declare variable
    ${email} =    Set Variable    user@example.com

    # Using added flags
    Should Match Regexp    ${email}    user@EXAMPLE.com    flags=IGNORECASE

    # Embedded to the pattern
    Should Match Regexp    ${email}    (?i)user@EXAMPLE.com

    # Check if case sensivity
    Should Not Match Regexp    ${email}    user@EXAMPLE.com

    # Validate that the email follows a common pattern
    Should Match Regexp    ${email}    ^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$

Scenario: A user validates a name and number
    # Declare variable
    ${full_name}    Set Variable    John Doe

    # Validate that the string contains at least one word character
    Should Match Regexp    ${full_name}    (\\w+)
    
    # Validates that this string contains Foo or Bar
    Should Match Regexp    Bar: 43    (Foo|Bar): (\\d+)

    # Validates that output CONTAINS six numbers
    Should Match Regexp    12345678    \\d{6}
    Should Not Match Regexp    12345    \\d{6}

    # Validates that output is six numbers and nothing less or more
    Should Match Regexp    123456    ^\\d{6}$
    Should Not Match Regexp    12345    ^\\d{6}$
    Should Not Match Regexp    1234567    ^\\d{6}$

Scenario: A user validates the start or end of strings
    # In this case the pattern  matches the provided string
    Should Match Regexp    Hello, world!    ello

    # ^ is used to mark a beginning of a string
    Should Match Regexp    Hello, world!    ^He

    # $ is used to mark an end of a string
    Should Match Regexp    Hello, world!    d!$

    # These regexp's do the same thing
    Should Match Regexp    ello    ello
    Should Match Regexp    ello    ^ello$    