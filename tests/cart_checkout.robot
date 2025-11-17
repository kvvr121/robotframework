*** Settings ***
Documentation    Cart and Checkout tests (POM-style) for Flipkart
Resource    ../resources/common.resource
Resource    ../resources/pages/homepage.resource
Resource    ../resources/pages/searchresults.resource
Resource    ../resources/pages/product.resource
Resource    ../resources/pages/cart.resource
Resource    ../resources/pages/checkout.resource
Resource    ../resources/utilities.resource

Suite Setup    Open Browser To Flipkart
Suite Teardown    Close All Browser Instances
Test Teardown    Run Keyword If Test Failed    Capture Screenshot On Failure

*** Test Cases ***
Add Product To Cart
    [Tags]    cart
    Search For Product    iPhone 13
    Open First Result
    Add Product To Cart
    Log    Product added to cart successfully

Checkout Mock Flow
    [Tags]    checkout
    [Documentation]    Mock checkout flow - real payment testing is out of scope
    Log    Checkout step: fill address (mocked in test environment)
    Log    Checkout step: select payment method (mocked in test environment)
    Log    Checkout step: place order (would be done in UAT/production)

