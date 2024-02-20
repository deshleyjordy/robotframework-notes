*** Settings ***
Documentation    Some tests using the Browser Library
...              //
...              $ pip install robotframework-browser
...              $ rfbrowser init

Library    Browser
Library    OperatingSystem

*** Test Cases ***
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
    
    # Provide user information
    Type Text    id=firstNameInput    Tony
    Type Text    id=lastNameInput    Stark
    Type Text    id=addressLine1Input    Stark Tower New York 911
    Type Text    id=provinceInput    New York
    Type Text    id=postCodeInput    11001 XL
    
    # Confirm
    Click    id=checkout-shipping-continue

    # Verify confirmation
    Get Text    id=confirmation-message    contains     successfully

    # Download a pdf
    ${downloadtest} =  Promise To Wait For Download    C:/Users/Deshley/Downloads/confirmation.pdf
    Click    id=downloadpdf
    
    # Vefiry if file is downloaded by browser
    ${file_obj}=           Wait For    ${downloadtest}

    # Just for example purposes
    Log    ${file_obj}
    Log    ${file_obj}[saveAs]
    Log    ${file_obj.suggestedFilename}
    Log    "${file_obj.suggestedFilename}"
    
    File Should Exist      ${file_obj}[saveAs]

    # Put quotes between variable: check: https://stackoverflow.com/questions/68425725/error-a-name-is-not-defined-when-using-a-variable-in-expression
    Should Be True         "${file_obj.suggestedFilename}"

Scenario: User tests with a iPhone X as device
    
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