*** Settings ***
Documentation    Search for a product on Flipkart and verify results (POM-style)
Resource    ../resources/common.resource
Resource    ../resources/pages/homepage.resource
Resource    ../resources/pages/searchresults.resource
Resource    ../resources/utilities.resource

Suite Setup    Open Browser To Flipkart
Suite Teardown    Close All Browser Instances
Test Teardown    Run Keyword If Test Failed    Capture Screenshot On Failure

*** Test Cases ***
Search Product Should Show Results
    [Tags]    smoke
    Search For Product    iPhone 13
    ${title}=    Get First Result Title
    Log    First result title: ${title}
    Should Not Be Empty    ${title}
