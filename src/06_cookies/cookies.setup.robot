*** Settings ***
Library   SeleniumLibrary    run_on_failure=None

*** Variables ***
# Navigation
${browser}    chrome
${url}        https://www.saucedemo.com/

# Variables
${validatie}    id:login_button_container

*** Keywords ***
Setup Cookies
     Open Browser    ${url}    ${browser}    options=add_argument("--incognito")
     Maximize Browser Window
     Wait Until Element Is Visible    ${validatie}    timeout=10s