*** Settings ***
Documentation    Some tests using the Browser Library
...              //
...              $ pip install robotframework-browser
...              $ rfbrowser init

Library    Browser

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

Scenario: Do something in device iPhone X modus
    ${device} =    Get Device    iPhone X
    
    New Page    https://playwright.dev/
