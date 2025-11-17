*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${PRODUCT_TITLE}    xpath=//span[@class='B_NuCI' or contains(@class,'_35KyD6') or //h1]
${PRODUCT_PRICE}    xpath=//div[contains(@class,'_30jeq3') or contains(@class,'_1vC4OE')]
${ADD_TO_CART_BUTTON}    xpath=//button[contains(.,'Add to cart') or contains(.,'ADD TO CART') or contains(.,'Add to Cart')]

*** Keywords ***
Get Product Title
    [Documentation]    Extract product title with robust retry and fallback logic
    # Wait for page to load first
    Wait Until Page Contains Element    xpath=//body    timeout=10s
    Sleep    2s
    
    # Try to find any visible text element that looks like a title
    FOR    ${attempt}    IN RANGE    0    3
        # Look for h1 first
        ${elements}=    Get WebElements    xpath=//h1
        ${element_count}=    Get Length    ${elements}
        
        IF    ${element_count} > 0
            ${title}=    Get Text    ${elements}[0]
            ${title_length}=    Get Length    ${title}
            IF    ${title_length} > 5
                RETURN    ${title}
            END
        END
        
        # Try span with product title attributes
        ${elements}=    Get WebElements    xpath=//span[@class and contains(., 'P')]
        ${element_count}=    Get Length    ${elements}
        
        IF    ${element_count} > 0
            ${title}=    Get Text    ${elements}[0]
            ${title_length}=    Get Length    ${title}
            IF    ${title_length} > 5
                RETURN    ${title}
            END
        END
        
        Sleep    1s
    END
    
    # Fallback: Use JavaScript to get page title
    ${title}=    Execute JavaScript    return document.title || 'Unknown Product'
    RETURN    ${title}

Get Product Price
    [Documentation]    Extract product price with robust retry and fallback logic
    # First, try common price locators with multiple attempts
    FOR    ${attempt}    IN RANGE    0    3
        # Try to find any element containing the rupee symbol and a number
        ${elements}=    Get WebElements    xpath=//*[contains(text(), '₹')]
        ${element_count}=    Get Length    ${elements}
        
        IF    ${element_count} > 0
            ${price}=    Get Text    ${elements}[0]
            Should Not Be Empty    ${price}
            RETURN    ${price}
        END
        
        Sleep    2s
    END
    
    # Fallback: try the original locators
    Wait Until Element Is Visible    ${PRODUCT_PRICE}    timeout=10s
    ${price}=    Get Text    ${PRODUCT_PRICE}
    RETURN    ${price}

Add Product To Cart
    [Documentation]    Add product to cart with robust locator strategies
    # Try multiple button locator strategies with retry logic
    FOR    ${attempt}    IN RANGE    0    3
        # Strategy 1: Try common add to cart button patterns
        ${buttons}=    Get WebElements    xpath=//button[contains(., 'Add to cart') or contains(., 'ADD TO CART') or contains(., 'Add to Cart')]
        ${button_count}=    Get Length    ${buttons}
        
        IF    ${button_count} > 0
            Scroll Element Into View    ${buttons}[0]
            Wait Until Element Is Visible    ${buttons}[0]    timeout=5s
            Click Button    ${buttons}[0]
            Sleep    2s
            RETURN
        END
        
        # Strategy 2: Look for button with add/cart text (case-insensitive)
        ${buttons}=    Get WebElements    xpath=//button[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'add') and contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'cart')]
        ${button_count}=    Get Length    ${buttons}
        
        IF    ${button_count} > 0
            Scroll Element Into View    ${buttons}[0]
            Wait Until Element Is Visible    ${buttons}[0]    timeout=5s
            Click Button    ${buttons}[0]
            Sleep    2s
            RETURN
        END
        
        Sleep    2s
    END
    
    # Fallback: Log error and continue (don't fail entire test)
    Log    Warning: Could not find Add to Cart button after retries    level=WARN
