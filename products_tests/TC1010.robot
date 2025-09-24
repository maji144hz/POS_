*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Setup        Login Using Resource

Resource          ../variables/common_variables.robot
Resource          ../variables/variables.robot
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/products_keywords.robot

*** Test Cases ***
แก้ไขสินค้า TC1010
    Create Directory                     ${SCREEN_DIR}
    Go To                               ${PRODUCT_LIST_URL}
    Wait Until Element Is Visible        ${STOCK_SEARCH_INPUT}    ${TIMEOUT}
    
    # ค้นหาสินค้า "น้ำยาล้างจาน"
    Input Text                          ${STOCK_SEARCH_INPUT}    น้ำยาล้างจาน
    Press Keys                          ${STOCK_SEARCH_INPUT}    ENTER
    Wait Table Idle
    
    # คลิกปุ่มแก้ไขของสินค้าที่พบ
    Wait Until Element Is Visible        ${BTN_EDIT_PRODUCT}    ${TIMEOUT}
    Click Element                        ${BTN_EDIT_PRODUCT}
    Wait Table Idle
    
    # ตรวจสอบว่าอยู่ในหน้าแก้ไขสินค้า
    Wait Until Element Is Visible        ${EDIT_INPUT_NAME}    ${TIMEOUT}
    
    # แก้ไขชื่อและรายละเอียด
    ${current_name}=    Get Element Attribute    ${EDIT_INPUT_NAME}    value
    ${new_name}=    Set Variable    ${current_name} แก้ไข
    Clear Element Text                  ${EDIT_INPUT_NAME}
    Input Text                          ${EDIT_INPUT_NAME}    ${new_name}
    
    ${current_desc}=    Get Element Attribute    ${EDIT_INPUT_DESC}    value
    ${new_desc}=    Set Variable    ${current_desc} แก้ไข
    Clear Element Text                  ${EDIT_INPUT_DESC}
    Input Text                          ${EDIT_INPUT_DESC}    ${new_desc}
    
    # บันทึกการแก้ไข
    Click Element                        ${EDIT_BTN_SAVE}
    Click If Exists                      ${SWAL_CONFIRM}
    Wait Table Idle
    
    # ตรวจสอบว่ากลับมาหน้าสินค้าแล้ว
    Wait Until Element Is Visible        ${STOCK_SEARCH_INPUT}    ${TIMEOUT}
    
    # ค้นหาและตรวจสอบว่าการแก้ไขสำเร็จ
    Input Text                          ${STOCK_SEARCH_INPUT}    ${new_name}
    Press Keys                          ${STOCK_SEARCH_INPUT}    ENTER
    Wait Table Idle
    Page Should Contain                 ${new_name}
