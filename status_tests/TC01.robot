*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           random

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Setup        Login And Go To Status Page
Test Teardown     Run Keyword And Ignore Error    Close Browser

Resource          ../variables/common_variables.robot
Resource          ../variables/status_variables.robot
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/status_keywords.robot

*** Test Cases ***
เพิ่มสถานะสินค้า
    ${RANDOM}=    Generate Random Number
    ${name}=      Set Variable    ทดสอบสถานะ 1234
    Create Status           ${name}
    Search Status By Name   ${name}
    Screenshot Latest Status Row    ${name}
