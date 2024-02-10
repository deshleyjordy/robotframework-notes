*** Settings ***
Documentation    Idee om de keyword "Switch Browsers" te testen, om via Chrome te chatten met een Firefox browser EN wellicht Edge erbij?
...              Zie URL onder variables waarbij dit gemakkelijk getest kan worden.
...              Ook interessant om eens te kijken naar de webdrivers en de webdrivermanager zoals beschrijven staat op de SeleniumLibrary Github:
...              https://github.com/robotframework/SeleniumLibrary#browser-drivers
...              //
...              https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Switch%20Browser
...              //
...              https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Open%20Browser

Library          SeleniumLibrary    run_on_failure=None
Library          Dialogs

Test Teardown   Close All Browsers

*** Variables ***
${url}        https://otr.to

*** Test Cases ***
Scenario: Opens a browser in Chrome with an alias and a browser in Firefox with an alias
    [Documentation]    Opens two browsers next to each other on a 24 inch monitor
    # Opens first browser in chrome in incognito
    Open Browser    about:blank    chrome    alias=browser1    options=add_argument("--incognito")

    # Set appropiate windows size and position
    Set Window Size    950    1000
    Set Window Position    0    0

    # Navigate somewhere
    Go To    https://www.w3.org/

    # Opens second browser in Firefox in private window
    Open Browser    about:blank    firefox    alias=browser2    options=add_argument("--private-window")

    # Set appropiate windows size and position next to the first one
    Set Window Size    950    1000
    Set Window Position    950    0

    # Navigate somewhere
    Go To    http://www.telegraaf.nl

    # Switch to previous browser and do something
    Switch Browser    browser1
    Click Element    //*[@id="main"]/div[2]/div/a