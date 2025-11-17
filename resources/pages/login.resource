*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_USERNAME_FIELD}    xpath=//input[@type='text' and (contains(@placeholder,'Phone') or contains(@placeholder,'email') or contains(@name,'username'))]
${LOGIN_PASSWORD_FIELD}    xpath=//input[@type='password']
${LOGIN_BUTTON}    xpath=//button[contains(.,'Login') or contains(.,'Log In')]

*** Keywords ***
Login With Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${LOGIN_USERNAME_FIELD}    timeout=10s
    Input Text    ${LOGIN_USERNAME_FIELD}    ${username}
    Input Text    ${LOGIN_PASSWORD_FIELD}    ${password}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    xpath=//a[contains(.,'Logout') or contains(.,'My Account')]    timeout=15s

Close Login Modal If Present
    Run Keyword And Ignore Error    Click Button    xpath=//button[contains(.,'✕') or contains(@class,'_2KpZ6l')]
