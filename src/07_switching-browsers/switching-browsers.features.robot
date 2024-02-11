*** Settings ***
Documentation    https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Switch%20Browser
...              //
...              https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Open%20Browser

Library          SeleniumLibrary    run_on_failure=None
Resource         switching-browsers.setup.robot

Suite Setup      Setup Switching Browsers
Suite Teardown   Close All Browsers

*** Variables ***
${url}                  https://otr.to

${buttonSendMessage}    //*[@class="button is-primary"]
${inputChatroom}        //*[@class="input"]
${inputTextfield}       //*[@name="userInput"]
${validateConnection}   //*[@class="messages"]

*** Test Cases ***
Scenario: Two browsers will open in Chrome and Firefox and try to communicate with each other
    # Navigate to url in first browser
    Go To    ${url}
    Wait Until Element Is Visible    ${inputChatroom}
    
    # Store url for the chatroom
    ${urlChatroom} =  Get Value    ${inputChatroom}

    # Switch to second browser and open the chatroom
    Switch Browser    browser-2
    Go To    ${urlChatroom}
    Wait Until Element Is Visible    ${validateConnection}
    Page Should Contain    Connected to Peer

    # Switch back to first browser to validate that the chat has opened
    Switch Browser    browser-1
    Wait Until Element Is Visible    ${validateConnection}
    Page Should Contain    Connected to Peer

    # First browser says something in chat
    Wait Until Element Is Visible    ${inputTextfield}
    Input Text    ${inputTextfield}    Hi there, I am the Chrome Browser. Who am I speaking to?
    Click Button    ${buttonSendMessage}

    # Switch second browser and respond
    Switch Browser    browser-2
    Page Should Contain    Hi there, I am the Chrome Browser. Who am I speaking to?
    Wait Until Element Is Visible    ${inputTextfield}
    Input Text    ${inputTextfield}    Hey there, I am the Firefox Browser. Do you copy?
    Click Button    ${buttonSendMessage}

    # Switch back to first browser and verify message
    Switch Browser    browser-1
    Page Should Contain    Hey there, I am the Firefox Browser. Do you copy?