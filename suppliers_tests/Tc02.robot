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
แก้ไขซัพพลายเออร์
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
