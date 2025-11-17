*** Settings ***
Library    SeleniumLibrary
Library    libraries.webdriver_helper
Library    libraries.driverpath

*** Keywords ***
Open Browser To Flipkart
    [Documentation]    Opens Flipkart home page and registers webdriver
    ${exe}=    Get Chrome Driver Path
    Open Browser    https://www.flipkart.com    chrome    executable_path=${exe}
    Maximize Browser Window
    Run Keyword And Ignore Error    Close Login Popup

Close All Browser Instances
    [Documentation]    Close all browser instances (calls SeleniumLibrary's Close All Browsers)
    SeleniumLibrary.Close All Browsers

Close Login Popup
    [Documentation]    Closes the initial login modal if present
    Wait Until Element Is Visible    xpath=//button[contains(.,'✕')]    timeout=5s
    Click Button    xpath=//button[contains(.,'✕')]
