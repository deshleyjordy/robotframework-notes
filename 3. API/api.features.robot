*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${api}        https://jsonplaceholder.typicode.com
${url}        /posts

*** Test Cases ***
Scenario: Doe een GET Request en valideer of de response '200 ok' is
    # Check status
    Create Session  mysession  ${api}
    ${response}=  GET On Session  mysession    ${url}
    Status Should Be  200    ${response}

Scenario: Doe een POST Request en valideer of de response code '201' is en of id '101' in de response body voorkomt
    # Check status
    Create Session  mysession  ${api}  verify=true
    &{body}=  Create Dictionary  title=foo  body=bar  userId=9000
    ${response}=  POST On Session  mysession  ${url}  data=${body}
    Status Should Be  201  ${response}

    # Check id met 101 in response body
    ${id}=  Get Value From Json  ${response.json()}  id
    ${idFromList}=  Get From List   ${id}  0
    ${idFromListAsString}=  Convert To String  ${idFromList}
    Should be equal As Strings  ${idFromListAsString}  101