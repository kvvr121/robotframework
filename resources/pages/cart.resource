*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CART_ITEMS}    xpath=//div[contains(@class,'_1AtVbE') and .//a[contains(@href,'/p/')]]
${PROCEED_TO_CHECKOUT}    xpath=//button[contains(.,'Place Order') or contains(.,'Place order') or contains(.,'Proceed to checkout') or contains(.,'Proceed to Checkout')]

*** Keywords ***
Get Cart Items Count
    ${items}=    Get Element Count    ${CART_ITEMS}
    RETURN    ${items}

Proceed To Checkout
    Wait Until Element Is Visible    ${PROCEED_TO_CHECKOUT}    timeout=10s
    Click Button    ${PROCEED_TO_CHECKOUT}
    Wait Until Page Contains    Checkout    timeout=15s
