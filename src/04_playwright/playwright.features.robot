*** Settings ***
Documentation    Some tests using the Browser Library
...              //
...              $ pip install robotframework-browser
...              $ rfbrowser init

Library    Browser
Library    OperatingSystem

*** Test Cases ***
Has Title
    New Page    https://playwright.dev/
    Get Title    contains    Playwright

Get Started Link
    New Page    https://playwright.dev/
    ${element}=    Get Element By Role    LINK    name=Get started
    Click    ${element}
    ${heading}=    Get Element By Role    HEADING    name=Installation
    Get Element States    ${heading}    contains    visible

Get Started Link [Alternative]
    New Page    https://playwright.dev/
    Click    a >> "Get started"
    Get Element States    h1 >> "Installation"    contains    visible

Playwright Test
    New Page    https://playwright.dev/
    Get Title    matches   Playwright
    Get Attribute    "Get started"    href    ==    /docs/intro
    Click    "Get started"
    Get Url    matches    .*intro

Scenario: The user adds an iPhone to the cart, logs in to the website and verifies order
    [Documentation]    https://www.browserstack.com/guide/cross-browser-testing-using-playwright
    
    # Headless on false to test different browsers (chromium, firefox and webkit)
    Open Browser    https://bstackdemo.com/    chromium    headless=false

    # Add item to shopping cart and proceed order
    Click    //*[@id="1"]//div[@class="shelf-item__buy-btn"]
    Click    //*[@class="buy-btn"]

    # Somehow the 'Type Text & 'Type Secret' does not work on this specific login page...
    Click   //*[@id="username"]
    Keyboard Key    press    ArrowDown
    Keyboard Key    press    ArrowDown
    Keyboard Key    press    ArrowDown
    Keyboard Key    press    Enter

    Click    //*[@id="password"]
    Keyboard Key    press    Enter

    # Login to the website and verify if order is correct
    Click    id=login-btn
    Get Text    id=1    contains    iPhone 12
    
    Type Text    id=firstNameInput    Tony
    Type Text    id=lastNameInput    Stark
    Type Text    id=addressLine1Input    Stark Tower New York 911
    Type Text    id=provinceInput    New York
    Type Text    id=postCodeInput    11001 XL

    Click    id=checkout-shipping-continue

    Get Text    id=confirmation-message    contains     successfully


    ${downloadtest} =  Promise To Wait For Download    C:/Users/Deshley/Downloads/confirmation.pdf
    Click    id=downloadpdf
    

    Sleep    7s


    ${file_obj}=           Wait For    ${downloadtest}
    Log    ${file_obj}
    Log    ${file_obj}[saveAs]
    Log    ${file_obj.suggestedFilename}
    Log    "${file_obj.suggestedFilename}"
    
    File Should Exist      ${file_obj}[saveAs]

    # Put quotes... check: https://stackoverflow.com/questions/68425725/error-a-name-is-not-defined-when-using-a-variable-in-expression
    Should Be True         "${file_obj.suggestedFilename}"



Scenario: Same test as above, but for the device iPhone X
    
    # Setup device and open in 'New page'
    ${device} =    Get Device    iPhone X
    New Context    &{device}
    New Page    https://bstackdemo.com/
    Take Screenshot

    # Add item to shopping cart and proceed order
    Click    //*[@id="1"]//div[@class="shelf-item__buy-btn"]
    Take Screenshot
    Click    //*[@class="buy-btn"]
    Take Screenshot

    # Somehow the 'Type Text & 'Type Secret' does not work on this specific login page...
    Click   //*[@id="username"]
    Keyboard Key    press    ArrowDown
    Keyboard Key    press    ArrowDown
    Keyboard Key    press    ArrowDown
    Keyboard Key    press    Enter
    Take Screenshot

    Click    //*[@id="password"]
    Keyboard Key    press    Enter
    Take Screenshot

    # Login to the website and verify if order is correct
    Click    id=login-btn
    Get Text    id=1    contains    iPhone 12
    Take Screenshot