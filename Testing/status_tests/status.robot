*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ชุดทดสอบสถานะ: เพิ่ม/แก้ไข/ลบ ด้วย STATUS_* locators
Metadata          owner    qa
Metadata          component    status
Force Tags        regression    status
Default Tags      ui
Library           random

Suite Setup       NONE
Suite Teardown    NONE
Test Setup        Run Keywords    Open Browser To Login Page    AND    Initialize Test Logging    AND    Login And Go To Status Page
Test Teardown     Run Keywords    End Test Logging    AND    Close All Browsers

Resource          ../../variables/common_variables.robot
Resource          ../../variables/status_variables.robot
Resource          ../../keywords/common_keywords.robot
Resource          ../../keywords/status_keywords.robot

*** Test Cases ***
TC001 - เพิ่มสถานะสินค้า
    Initialize Test Logging
    ${RANDOM}=    Generate Random Number
    ${name}=      Set Variable    ทดสอบสถานะ 1234
    Create Status           ${name}
    Search Status By Name   ${name}
    Screenshot Latest Status Row    ${name}

TC002 - แก้ไขสถานะสินค้า
    Initialize Test Logging
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
    Log Step And Screenshot          แก้ไขสถานะเสร็จสิ้น

TC003 - ลบสถานะสินค้า
    Initialize Test Logging
    ${name}=    Set Variable    ทดสอบสถานะ 1234 แก้ไข
    Search Status By Name    ${name}
    Click Delete Button
    Confirm Delete Dialog
    Search Status By Name    ${name}
    Verify Category Not Exists    ${name}
    Log Step And Screenshot      ลบสถานะเสร็จสิ้น

