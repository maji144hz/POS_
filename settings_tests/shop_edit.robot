*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Setup        Login And Go To Shop Settings

Resource          ../variables/common_variables.robot
Resource          ../variables/settings_variables.robot
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/settings_keywords.robot

*** Test Cases ***
แก้ไขข้อมูลร้านค้า (ถ่ายภาพทุกขั้นตอน)
    [Documentation]    ล็อกอิน → ไปหน้า /setting/shop → แคปหน้าจอ → กดแก้ไข → กรอกชื่อ/ที่อยู่ → แคปหน้าจอ → กดยืนยัน → แคปหน้าจอ
    # 1) หน้า "การตั้งค่า" ของร้าน
    Wait Until Element Is Visible       ${MENU_SETTINGS}    ${TIMEOUT}
    Click Element                       ${MENU_SETTINGS}
    Wait Table Idle
    Create Directory                    ${SCREEN_DIR}
    Capture Page Screenshot             ${SCREEN_DIR}${/}shop_settings_page.png

    # 2) กด "แก้ไขข้อมูล"
    Wait Until Element Is Visible       ${BTN_EDIT}    ${TIMEOUT}
    Scroll Element Into View            ${BTN_EDIT}
    Click Element                       ${BTN_EDIT}
    Wait Table Idle

    # 3) กรอกฟอร์ม
    Wait Until Element Is Visible       ${INPUT_SHOP_NAME}       ${TIMEOUT}
    Clear Element Text                  ${INPUT_SHOP_NAME}
    Input Text                          ${INPUT_SHOP_NAME}       ร้านทดสอบ โปโรเจค POS

    Wait Until Element Is Visible       ${TEXTAREA_SHOP_ADDR}    ${TIMEOUT}
    Clear Element Text                  ${TEXTAREA_SHOP_ADDR}
    Input Text                          ${TEXTAREA_SHOP_ADDR}    123/45 ถนนตัวอย่าง แขวงทดสอบ เขตทดสอบ กรุงเทพฯ 10110

    Capture Page Screenshot             ${SCREEN_DIR}${/}shop_edit_filled.png

    # 4) ยืนยัน
    Scroll Element Into View            ${BTN_SUBMIT}
    Click Element                       ${BTN_SUBMIT}
    Click If Exists                     ${SWAL_CONFIRM}
    Wait Table Idle
    Capture Page Screenshot             ${SCREEN_DIR}${/}shop_edit_submitted.png
