*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn

*** Variables ***
${FIRST_RESULT_LINK}    xpath=(//a[contains(@href,'/p/')])[1]
${FIRST_RESULT_TITLE}   xpath=((//a[contains(@href,'/p/')])[1]//div[contains(@class,'_4rR01T') or contains(@class,'s1Q9rs')])[1]

*** Keywords ***
Get First Result Title
    Wait Until Element Is Visible    ${FIRST_RESULT_LINK}    timeout=15s
    ${exists}=    Run Keyword And Return Status    Element Should Be Visible    ${FIRST_RESULT_TITLE}
    IF    ${exists}
        ${title}=    Get Text    ${FIRST_RESULT_TITLE}
    ELSE
        ${title}=    Get Text    ${FIRST_RESULT_LINK}
    END
    RETURN    ${title}

Open First Result
    Wait Until Element Is Visible    ${FIRST_RESULT_LINK}    timeout=15s
    Click Element    ${FIRST_RESULT_LINK}
    Sleep    1s
    # Ensure product page loaded
    Wait Until Page Contains Element    xpath=//body    timeout=10s
