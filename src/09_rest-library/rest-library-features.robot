*** Settings ***
Documentation    Send a simple HTTP request using the RESTinstance library
...              //
...              https://asyrjasalo.github.io/RESTinstance/
...              //
...              $ pip install -U RESTinstance

Library          Collections
Library          REST    https://api.github.com/

*** Test Cases ***
Get Request
    GET         users/deshleyjordy
    Output      response
    Integer     response status    200

    String      response body name    Deshley
    String     response body location    Utrecht

    ${body}=    Output    response body
    Dictionary Should Not Contain Value    ${body}    Deshley