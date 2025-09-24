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
แก้ไขสถานะสินค้า
    ${old_name}=    Set Variable    ทดสอบสถานะ 1234
    ${new_name}=    Set Variable    ${old_name} แก้ไข

    Search Status By Name    ${old_name}
    Click Status Edit Button
    Wait Until Element Is Visible    ${EDIT_INPUT_STATUS}
    Clear Element Text               ${EDIT_INPUT_STATUS}
    Input Text                       ${EDIT_INPUT_STATUS}    ${new_name}
    Click Element                    ${BTN_SAVE_EDIT_STATUS}
    Click If Exists                  ${SWAL_CONFIRM}
    Wait Until Element Is Not Visible    ${EDIT_INPUT_STATUS}    ${TIMEOUT}
