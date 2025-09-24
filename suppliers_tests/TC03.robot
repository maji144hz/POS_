*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Setup        Login And Go To Suppliers Page
Test Teardown     Run Keyword And Ignore Error    Close Browser

Resource          ../variables/common_variables.robot
Resource          ../variables/suppliers_variables.robot
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/suppliers_keywords.robot

*** Test Cases ***
ลบซัพพลายเออร์
    ${name}=    Set Variable    ทดสอบซัพพลายเออร์ 1234 แก้ไข
    Search Supplier By Name    ${name}
    Click Delete Supplier Button
    Confirm Delete Dialog
    Search Supplier By Name    ${name}
    Verify Supplier Not Exists    ${name}
