*** Settings ***
Library    SeleniumLibrary
Resource   formulier.helpers.resource

*** Variables ***
# Testdata
${_value}          The Input Form
${_firstName}      Teampje
${_lastName}       Barbados Bridgetown
${_age}            23
${_country}        Madagascar
${_notes}          This is a text for a note
${_validation}     Your Input passed validation

*** Keywords ***
De gebruiker navigeert naar de website
    navigerenFormulier
    validerenFormulier    ${_value}

De gebruiker vult het formulier in en kiest voor verzenden
    invoerenGegevens    ${_firstName}    ${_lastName}    ${_age}    ${_country}    ${_notes}
    klikkenVerzenden

De gebruiker ziet een rapport en valideert dat de gegevens correct zijn doorgevoerd
    validerenRapport    ${_validation}
    validerenGegevens    ${_firstName}    ${_lastName}    ${_age}    ${_country}    ${_notes}