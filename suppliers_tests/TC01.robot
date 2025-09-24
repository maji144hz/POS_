*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           random

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Setup        Login And Go To Suppliers Page
Test Teardown     Run Keyword And Ignore Error    Close Browser

Resource          ../variables/common_variables.robot
Resource          ../variables/suppliers_variables.robot
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/suppliers_keywords.robot

*** Test Cases ***
เพิ่มซัพพลายเออร์
    ${RANDOM}=    Generate Random Number
    ${name}=      Set Variable    ทดสอบซัพพลายเออร์ 1234
    ${contact}=   Set Variable    คุณสมชาย
    ${phone}=     Set Variable    0812345678
    ${address}=   Set Variable    123/45 ถนนทดสอบ เขตทดสอบ กรุงเทพฯ

    Click Element                 ${BTN_ADD_SUPPLIER}
    Create Supplier Full Form     ${name}    ${contact}    ${phone}    ${address}
    Search Supplier By Name       ${name}
    Screenshot Latest Supplier Row    ${name}
