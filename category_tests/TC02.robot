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
แก้ไขหมวดหมู่
    ${old_name}=    Set Variable    ทดสอบหมวดหมู่ 1234
    ${new_name}=    Set Variable    ${old_name} แก้ไข

    Search Category By Name    ${old_name}
    Click Edit Category Button
    Wait Until Element Is Visible    ${EDIT_INPUT}
    Clear Element Text               ${EDIT_INPUT}
    Input Text                       ${EDIT_INPUT}    ${new_name}
    Click Element                    ${BTN_SAVE_EDIT}
    Click If Exists                  ${SWAL_CONFIRM}
    Wait Until Element Is Not Visible    ${EDIT_INPUT}    ${TIMEOUT}
