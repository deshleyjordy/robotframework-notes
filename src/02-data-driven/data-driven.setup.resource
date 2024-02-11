*** Settings ***
Library   SeleniumLibrary

*** Variables ***
${browser}    chrome
${url}        https://www.saucedemo.com/

*** Keywords ***
Setup Data-driven
     Open Browser    ${url}    ${browser}    options=add_argument("--incognito")
     Maximize Browser Window