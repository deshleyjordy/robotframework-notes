*** Settings ***
Documentation    Idee om de keyword "Switch Browsers" te testen, om via Chrome te chatten met een Firefox browser EN wellicht Edge erbij?
...              Zie URL onder variables waarbij dit gemakkelijk getest kan worden.
...              Ook interessant om eens te kijken naar de webdrivers en de webdrivermanager zoals beschrijven staat op de SeleniumLibrary Github:
...              https://github.com/robotframework/SeleniumLibrary#browser-drivers

Library          SeleniumLibrary    run_on_failure=None
Resource         

Test Setup      
Test Teardown   Close All Browsers

*** Variables ***
${url}        https://otr.to

*** Test Cases ***