*** Settings ***
Documentation    Setup for doing things in two browsers at the same time
Library          SeleniumLibrary    run_on_failure=None

*** Keywords ***
Setup Switching Browsers
    [Documentation]    Settings for a 24 inch monitor
    # Opens first browser in chrome in incognito
    Open Browser    about:blank    chrome    alias=browser-1    options=add_argument("--incognito")

    # Set appropiate windows size and position
    Set Window Size    950    1000
    Set Window Position    0    0

    # Opens second browser in Firefox in private window
    Open Browser    about:blank    firefox    alias=browser-2    options=add_argument("--private-window")

    # Set appropiate windows size and position next to the first one
    Set Window Size    950    1000
    Set Window Position    950    0

    # Switch to previous browser
    Switch Browser    browser-1