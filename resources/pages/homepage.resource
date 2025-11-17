*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${SEARCH_INPUT}    xpath=//input[@name='q' or @title='Search for Products, Brands and More']

*** Keywords ***
Search For Product
    [Arguments]    ${product}
    [Documentation]    Search for a product from Flipkart homepage
    Wait Until Element Is Visible    ${SEARCH_INPUT}    timeout=15s
    Click Element    ${SEARCH_INPUT}
    Input Text    ${SEARCH_INPUT}    ${product}
    Press Keys    ${SEARCH_INPUT}    ENTER
    Wait Until Page Contains Element    xpath=//a[contains(@href,'/p/')]    timeout=15s
    Sleep    1s
