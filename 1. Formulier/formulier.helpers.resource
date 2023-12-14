*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# Navigation
${browser}            chrome
${url}                https://testpages.eviltester.com/styled/validation/input-validation.html

# Locators
${title}                  css:h2
${inputFirstName}         id:firstname
${inputLastName}          id:surname
${inputAge}               id:age
${dropdownCountry}        id:country
${inputNotes}             id:notes
${buttonVerzenden}        css:[type='submit']
${alertValidation}        id:valid-input-value
${validerenFirstName}     id:firstname-value
${validerenLastName}      id:surname-value
${validerenAge}           id:age-value
${validerenCountry}       id:country-value
${validerenNotes}         id:notes-value

*** Keywords ***
navigerenFormulier
    Open Browser    ${url}    ${browser}    options=add_argument("--incognito")
    Maximize Browser Window

validerenFormulier
    [Arguments]    ${_value}
    Element Should Contain    ${title}    ${_value}

invoerenGegevens
    [Arguments]    ${_firstName}    ${_lastName}    ${_age}    ${_country}    ${_note}
    Wait Until Element Is Visible    ${inputFirstName}
    Input Text    ${inputFirstName}    ${_firstName}
    Wait Until Element Is Visible    ${inputLastName}
    Input Text    ${inputLastName}    ${_lastName}
    Wait Until Element Is Visible    ${inputAge}
    Input Text    ${inputAge}    ${_age}
    Wait Until Element Is Visible    ${dropdownCountry}
    Select From List By Value   ${dropdownCountry}    ${_country}
    Wait Until Element Is Visible    ${inputNotes}
    Input Text    ${inputNotes}    ${_note}

klikkenVerzenden
    Wait Until Element Is Visible    ${buttonVerzenden}
    Click Button    ${buttonVerzenden}

validerenRapport
    [Arguments]    ${_validation}
    Wait Until Element Is Visible    ${alertValidation}
    Element Should Contain    ${alertValidation}    ${_validation}

validerenGegevens
    [Arguments]    ${_firstName}    ${_lastName}    ${_age}    ${_country}    ${_notes}
    Wait Until Element Is Visible    ${validerenFirstName}
    Element Should Contain    ${validerenFirstName}    ${_firstName}
    Wait Until Element Is Visible    ${validerenLastName}
    Element Should Contain    ${validerenLastName}    ${_lastName}
    Wait Until Element Is Visible    ${validerenAge}
    Element Should Contain    ${validerenAge}    ${_age}
    Wait Until Element Is Visible    ${validerenCountry}
    Element Should Contain    ${validerenCountry}    ${_country}
    Wait Until Element Is Visible    ${validerenNotes}
    Element Should Contain    ${validerenNotes}    ${_notes}