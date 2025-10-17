*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Resource   ./common_keywords.robot
Resource   ../variables/category_variables.robot

# ========================================
# ไฟล์: category_keywords.robot
# หน้าที่: เก็บฟังก์ชันสำหรับเทสหมวดหมู่สินค้า
# ใช้สำหรับ: เทสเพิ่ม/แก้ไข/ลบหมวดหมู่สินค้า
# ========================================

*** Keywords ***
# ฟังก์ชันหลักสำหรับ Category
Login And Go To Category Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Navigate To Management Menu
    Click Element    xpath=//a[contains(text(),'ประเภทสินค้า')]
    Wait Until Element Is Visible    ${CATEGORY_BTN_ADD}

Create Category
    [Arguments]    ${name}
    Click Element    ${CATEGORY_BTN_ADD}
    Wait Until Element Is Visible    ${CATEGORY_INPUT_NAME}
    Clear Element Text    ${CATEGORY_INPUT_NAME}
    Input Text            ${CATEGORY_INPUT_NAME}    ${name}
    Click Element         ${CATEGORY_BTN_SAVE}
    Click If Exists       ${SWAL_CONFIRM}
    Wait Until Element Is Not Visible    ${CATEGORY_INPUT_NAME}    ${TIMEOUT}

Search Category By Name
    [Arguments]    ${name}
    Wait Until Element Is Visible    ${CATEGORY_INPUT_SEARCH}    ${TIMEOUT}
    Clear Element Text    ${CATEGORY_INPUT_SEARCH}
    Input Text            ${CATEGORY_INPUT_SEARCH}    ${name}
    Press Keys            ${CATEGORY_INPUT_SEARCH}    ENTER
    Wait Until Page Contains    ${name}    ${TIMEOUT}

Screenshot Latest Category Row
    [Arguments]    ${name}
    ${ROW}=    Set Variable    xpath=(//tr[.//*[self::td or self::span or self::div][contains(normalize-space(.),"${name}")]])[1]
    Wait Until Element Is Visible    ${ROW}    ${TIMEOUT}
    Scroll Element Into View         ${ROW}
    Capture Element Screenshot    ${ROW}    ${SCREEN_DIR}${/}latest_category.png

Click Category Edit Button
    Wait Until Page Contains Element    xpath=//button[starts-with(@id,'edit-category-button-')]    ${TIMEOUT}
    Click Element                       xpath=//button[starts-with(@id,'edit-category-button-')]
    Wait Table Idle

Click Category Delete Button
    Wait Until Page Contains Element    xpath=//button[starts-with(@id,'delete-category-button-')]    ${TIMEOUT}
    Click Element                       xpath=//button[starts-with(@id,'delete-category-button-')]
    Wait Table Idle

Confirm Delete Dialog
    Click If Exists    ${SWAL_CONFIRM}
    Wait Table Idle

Verify Category Not Exists
    [Arguments]    ${name}
    Wait Until Page Does Not Contain    ${name}    ${TIMEOUT}