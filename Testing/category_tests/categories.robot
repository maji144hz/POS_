*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ชุดทดสอบหมวดหมู่: เพิ่ม/แก้ไข/ลบ ด้วย CATEGORY_* locators
Metadata          owner    qa
Metadata          component    categories
Force Tags        regression    categories
Default Tags      ui
Library           random

Suite Setup       NONE
Suite Teardown    NONE
Test Setup        Run Keywords    Open Browser To Login Page    AND    Initialize Test Logging    AND    Login And Go To Category Page
Test Teardown     Run Keywords    End Test Logging    AND    Close All Browsers

Resource          ../../variables/common_variables.robot
Resource          ../../variables/category_variables.robot
Resource          ../../keywords/common_keywords.robot
Resource          ../../keywords/category_keywords.robot

*** Test Cases ***
TC001 - เพิ่มหมวดหมู่
    Initialize Test Logging
    ${RANDOM}=    Generate Random Number
    ${name}=      Set Variable    ทดสอบหมวดหมู่ 1234
    Log Step And Screenshot    เปิดหน้าเพิ่มหมวดหมู่
    Create Category           ${name}
    Search Category By Name   ${name}
    Screenshot Latest Category Row    ${name}

TC002 - แก้ไขหมวดหมู่
    Initialize Test Logging
    ${old_name}=    Set Variable    ทดสอบหมวดหมู่ 1234
    ${new_name}=    Set Variable    ${old_name} แก้ไข

    Search Category By Name    ${old_name}
    Click Category Edit Button
    Wait Until Element Is Visible    ${CATEGORY_EDIT_INPUT_NAME}
    Clear Element Text               ${CATEGORY_EDIT_INPUT_NAME}
    Input Text                       ${CATEGORY_EDIT_INPUT_NAME}    ${new_name}
    Click Element                    ${CATEGORY_BTN_SAVE_EDIT}
    Click If Exists                  ${SWAL_CONFIRM}
    Wait Until Element Is Not Visible    ${CATEGORY_EDIT_INPUT_NAME}    ${TIMEOUT}
    Log Step And Screenshot          แก้ไขหมวดหมู่เสร็จสิ้น

TC003 - ลบหมวดหมู่
    Initialize Test Logging
    ${name}=    Set Variable    ทดสอบหมวดหมู่ 1234 แก้ไข
    Search Category By Name    ${name}
    Click Category Delete Button
    Confirm Delete Dialog
    Search Category By Name    ${name}
    Verify Category Not Exists    ${name}
    Log Step And Screenshot      ลบหมวดหมู่เสร็จสิ้น

