*** Settings ***
Library    SeleniumLibrary
Library    libraries.webdriver_helper
Library    libraries.driverpath    # Provides Get Chrome Service, Get Chrome Options keywords

*** Keywords ***
Open Browser To Flipkart
    [Documentation]    Opens Flipkart home page and registers webdriver
    # Prefer using Selenium Service + ChromeOptions instead of deprecated executable_path
    ${service}=    Get Chrome Service
    ${options}=    Get Chrome Options
    Open Browser    https://www.flipkart.com    chrome    service=${service}    options=${options}
    Maximize Browser Window
    Run Keyword And Ignore Error    Close Login Popup

Close All Browser Instances
    [Documentation]    Close all browser instances (calls SeleniumLibrary's Close All Browsers)
    SeleniumLibrary.Close All Browsers

Close Login Popup
    [Documentation]    Closes the initial login modal if present
    Wait Until Element Is Visible    xpath=//button[contains(.,'✕')]    timeout=5s
    Click Button    xpath=//button[contains(.,'✕')]
