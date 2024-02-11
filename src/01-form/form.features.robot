*** Settings ***
Library    SeleniumLibrary
Resource   form.steps.robot

*** Test Cases ***
Scenario: De gebruiker vult het formulier in met persoonlijke gegevens en kiest voor verzenden
    Given De gebruiker navigeert naar de website
    When De gebruiker vult het formulier in en kiest voor verzenden
    Then De gebruiker ziet een rapport en valideert dat de gegevens correct zijn doorgevoerd