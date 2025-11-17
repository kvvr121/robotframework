*** Settings ***
Documentation    Filter tests (POM-style) for Flipkart
Resource    ../resources/common.resource
Resource    ../resources/pages/homepage.resource
Resource    ../resources/pages/filters.resource
Resource    ../resources/utilities.resource

Suite Setup    Open Browser To Flipkart
Suite Teardown    Close All Browser Instances
Test Teardown    Run Keyword If Test Failed    Capture Screenshot On Failure

*** Test Cases ***
Apply Brand Filter
    [Tags]    filters
    Search For Product    iPhone 13
    Apply Brand Filter    Apple
    Wait Until Page Contains    Apple    timeout=15s
    Log    Apple filter applied successfully

