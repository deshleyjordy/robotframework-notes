*** Settings ***
Library   SeleniumLibrary

*** Variables ***
${browser}    chrome
${url}        https://www.saucedemo.com/

*** Keywords ***
SetupDataDriven
     Open Browser    ${url}    ${browser}    options=add_argument("--incognito")
     Maximize Browser Window