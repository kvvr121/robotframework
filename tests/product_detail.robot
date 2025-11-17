*** Settings ***
Documentation    Product Detail tests (POM-style) for Flipkart
Resource    ../resources/common.resource
Resource    ../resources/pages/homepage.resource
Resource    ../resources/pages/searchresults.resource
Resource    ../resources/pages/product.resource
Resource    ../resources/utilities.resource

Suite Setup    Open Browser To Flipkart
Suite Teardown    Close All Browser Instances
Test Teardown    Run Keyword If Test Failed    Capture Screenshot On Failure

*** Test Cases ***
View Product Details
    [Tags]    product
    Search For Product    iPhone 13
    Open First Result
    ${title}=    Get Product Title
    Log    Product title: ${title}
    Should Not Be Empty    ${title}
    ${price}=    Get Product Price
    Log    Product price: ${price}
    Should Not Be Empty    ${price}

