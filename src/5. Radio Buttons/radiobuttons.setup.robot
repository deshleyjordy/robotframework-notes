*** Settings ***
Library   SeleniumLibrary    run_on_failure=None

*** Variables ***
# Navigation
${browser}    chrome
${url}        http://test.rubywatir.com/radios.php

# Variables
${validatie}    	Radio button test page

*** Keywords ***
SetupRadioButtons
     Open Browser    ${url}    ${browser}    options=add_argument("--incognito")
     Maximize Browser Window
     Wait Until Page Contains    ${validatie}    timeout=10s