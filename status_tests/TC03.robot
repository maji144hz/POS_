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
ลบสถานะสินค้า
    ${name}=    Set Variable    ทดสอบสถานะ 1234 แก้ไข
    Search Status By Name    ${name}
    Click Delete Button
    Confirm Delete Dialog
    Search Status By Name    ${name}
    Verify Category Not Exists    ${name}
