*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    DateTime

*** Variables ***
${SCREENSHOT_DIR}    ${OUTPUT DIR}/screenshots

*** Keywords ***
Capture Screenshot On Failure
    [Documentation]    Capture page screenshot if the test failed. Use TEST STATUS variable.
    ${status}    Set Variable    ${TEST STATUS}
    Run Keyword If    '${status}'=='FAIL'    Capture Page Screenshot    ${SCREENSHOT_DIR}/failure-${TEST NAME}.png

Log Info
    [Arguments]    ${msg}
    Log    ${msg}    INFO

Wait Until Element Visible With Timeout
    [Arguments]    ${locator}    ${timeout}=15s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}

Wait Until Element Clickable
    [Arguments]    ${locator}    ${timeout}=15s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    Wait Until Element Is Enabled    ${locator}    timeout=${timeout}
