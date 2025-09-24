*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           random

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Setup        Login And Go To Category Page
Test Teardown     Run Keyword And Ignore Error    Close Browser

Resource          ../variables/common_variables.robot
Resource          ../variables/category_variables.robot
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/category_keywords.robot

*** Test Cases ***
ลบหมวดหมู่
    ${name}=    Set Variable    ทดสอบหมวดหมู่ 1234 แก้ไข
    Search Category By Name    ${name}
    Click Delete Button
    Confirm Delete Dialog
    Search Category By Name    ${name}
    Verify Category Not Exists    ${name}
