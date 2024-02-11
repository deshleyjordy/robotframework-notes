*** Settings ***
Library   SeleniumLibrary    run_on_failure=None

*** Variables ***
# Navigation
${browser}    chrome
${url}        http://test.rubywatir.com/radios.php

# Variables
${validation}    	Radio button test page

*** Keywords ***
Setup RadioButtons
     Open Browser    ${url}    ${browser}    options=add_argument("--incognito")
     Maximize Browser Window
     Wait Until Page Contains    ${validation}    timeout=10s