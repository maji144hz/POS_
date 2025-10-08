*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ชุดทดสอบซัพพลายเออร์: เพิ่ม/แก้ไข/ลบ ด้วย SUPPLIER_* locators
Metadata          owner    qa
Metadata          component    suppliers
Force Tags        regression    suppliers
Default Tags      ui
Library           random

Suite Setup       NONE
Suite Teardown    NONE
Test Setup        Run Keywords    Open Browser To Login Page    AND    Initialize Test Logging    AND    Login And Go To Suppliers Page
Test Teardown     Run Keywords    End Test Logging    AND    Close All Browsers

Resource          ../../variables/common_variables.robot
Resource          ../../variables/suppliers_variables.robot
Resource          ../../keywords/common_keywords.robot
Resource          ../../keywords/suppliers_keywords.robot

*** Test Cases ***
TC001 - เพิ่มซัพพลายเออร์
    Initialize Test Logging
    ${RANDOM}=    Generate Random Number
    ${name}=      Set Variable    ทดสอบซัพพลายเออร์ 1234
    ${contact}=   Set Variable    คุณสมชาย
    ${phone}=     Set Variable    0812345678
    ${address}=   Set Variable    123/45 ถนนทดสอบ เขตทดสอบ กรุงเทพฯ

    Click Element                 ${BTN_ADD_SUPPLIER}
    Create Supplier Full Form     ${name}    ${contact}    ${phone}    ${address}
    Search Supplier By Name       ${name}
    Screenshot Latest Supplier Row    ${name}
    Log Step And Screenshot       เพิ่มซัพพลายเออร์สำเร็จ

TC002 - แก้ไขซัพพลายเออร์
    Initialize Test Logging
    ${old_name}=    Set Variable    ทดสอบซัพพลายเออร์ 1234
    ${new_name}=    Set Variable    ${old_name} แก้ไข

    Search Supplier By Name    ${old_name}
    Click Edit Supplier Button
    Wait Until Element Is Visible    ${INPUT_EDIT_SUPPLIER_NAME}
    Clear Element Text               ${INPUT_EDIT_SUPPLIER_NAME}
    Input Text                       ${INPUT_EDIT_SUPPLIER_NAME}    ${new_name}
    Click Element                    ${BTN_SAVE_EDIT_SUPPLIER}
    Click If Exists                  ${SWAL_CONFIRM}
    Wait Until Element Is Not Visible    ${INPUT_EDIT_SUPPLIER_NAME}    ${TIMEOUT}
    Log Step And Screenshot          แก้ไขซัพพลายเออร์เสร็จสิ้น

TC003 - ลบซัพพลายเออร์
    Initialize Test Logging
    ${name}=    Set Variable    ทดสอบซัพพลายเออร์ 1234 แก้ไข
    Search Supplier By Name    ${name}
    Click Delete Supplier Button
    Confirm Delete Dialog
    Search Supplier By Name    ${name}
    Verify Supplier Not Exists    ${name}
    Log Step And Screenshot      ลบซัพพลายเออร์เสร็จสิ้น

