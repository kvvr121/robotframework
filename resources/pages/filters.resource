*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BRAND_FILTER}    xpath=//div[contains(.,'Brand') or contains(.,'BRAND')]/following::div//label
${PRICE_MIN}    xpath=//input[@placeholder='Min']
${PRICE_MAX}    xpath=//input[@placeholder='Max']
${APPLY_FILTER_BUTTON}    xpath=//button[contains(.,'APPLY') or contains(.,'Apply')]

*** Keywords ***
Apply Brand Filter
    [Arguments]    ${brand}
    [Documentation]    Apply brand filter with robust retry logic
    Sleep    2s
    # Wait for any modal overlay to disappear
    FOR    ${i}    IN RANGE    0    5
        ${modal}=    Get WebElements    xpath=//div[@class='_23axDd']
        ${modal_count}=    Get Length    ${modal}
        IF    ${modal_count} == 0
            BREAK
        END
        Sleep    1s
    END
    
    # Now click the filter
    ${locator}=    Set Variable    xpath=//div[contains(.,'Brand') or contains(.,'BRAND')]/following::div//label[contains(.,'${brand}')]
    FOR    ${attempt}    IN RANGE    0    3
        TRY
            ${element}=    Get WebElement    ${locator}
            Scroll Element Into View    ${element}
            Wait Until Element Is Visible    ${element}    timeout=5s
            Click Element    ${element}
            Sleep    2s
            BREAK
        EXCEPT
            Sleep    1s
        END
    END
    
    Wait Until Page Contains    ${brand}    timeout=10s
