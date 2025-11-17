*** Settings ***
Documentation    Extract mobile phone price from Flipkart
Resource    ../resources/common.resource
Resource    ../resources/pages/homepage.resource
Resource    ../resources/pages/searchresults.resource
Resource    ../resources/pages/product.resource
Resource    ../resources/utilities.resource

Suite Setup    Open Browser To Flipkart
Suite Teardown    Close All Browser Instances
Test Teardown    Run Keyword If Test Failed    Capture Screenshot On Failure

*** Test Cases ***
Extract Mobile Phone Price
    [Tags]    price-extraction
    [Documentation]    Search for iPhone 13 and extract the price of the first result
    Search For Product    iPhone 13
    Open First Result
    ${price}=    Get Product Price
    Log    Mobile phone price: ${price}
    Should Not Be Empty    ${price}
    Log To Console    ✅ Price extracted successfully: ${price}

Extract Price For Different Mobile
    [Tags]    price-extraction
    [Documentation]    Search for Samsung Galaxy and extract the price
    Search For Product    Samsung Galaxy A13
    Open First Result
    ${price}=    Get Product Price
    Log    Samsung Galaxy A13 price: ${price}
    Should Not Be Empty    ${price}
    Log To Console    ✅ Samsung price extracted successfully: ${price}

Extract Premium Phone Price
    [Tags]    price-extraction
    [Documentation]    Extract price for premium phone - iPhone 15 Pro Max
    Search For Product    iPhone 15 Pro Max
    Open First Result
    ${price}=    Get Product Price
    Log    iPhone 15 Pro Max price: ${price}
    Should Not Be Empty    ${price}
    Log To Console    ✅ Premium phone price extracted: ${price}

Extract Budget Phone Price
    [Tags]    price-extraction
    [Documentation]    Extract price for budget phone - Redmi Note
    Search For Product    Redmi Note 12
    Open First Result
    ${price}=    Get Product Price
    Log    Redmi Note 12 price: ${price}
    Should Not Be Empty    ${price}
    Log To Console    ✅ Budget phone price extracted: ${price}

Extract Mid Range Phone Price
    [Tags]    price-extraction
    [Documentation]    Extract price for mid-range phone - OnePlus
    Search For Product    OnePlus 12
    Open First Result
    ${price}=    Get Product Price
    Log    OnePlus 12 price: ${price}
    Should Not Be Empty    ${price}
    Log To Console    ✅ Mid-range phone price extracted: ${price}

Compare Multiple Phone Prices
    [Tags]    price-extraction    price-comparison
    [Documentation]    Extract and compare prices of multiple phones
    ${iphone_price}=    Get Phone Price    iPhone 13
    ${samsung_price}=    Get Phone Price    Samsung Galaxy A13
    ${redmi_price}=    Get Phone Price    Redmi Note 12
    Log    Price Comparison - iPhone 13: ${iphone_price}, Samsung: ${samsung_price}, Redmi: ${redmi_price}
    Log To Console    ✅ Price comparison completed

*** Keywords ***
Get Phone Price
    [Arguments]    ${phone_name}
    [Documentation]    Helper keyword to search, open, and extract phone price
    Search For Product    ${phone_name}
    Open First Result
    ${price}=    Get Product Price
    RETURN    ${price}

