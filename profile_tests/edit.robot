*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Setup        Login And Go To Profile

Resource          ../variables/common_variables.robot
Resource          ../variables/profile_variables.robot
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/profile_keywords.robot

*** Test Cases ***
แก้ไขข้อมูลส่วนตัว (ถ่ายภาพทุกขั้นตอน)
    [Documentation]    ล็อกอิน → /profile → เปิดเมนูการตั้งค่า → แก้ไขข้อมูลส่วนตัว → กรอก username/phone → บันทึก
    # 1) ไปหน้าโปรไฟล์ + แคป
    Create Directory                    ${SCREEN_DIR}
    Go To                               ${PROFILE_URL}
    Wait Table Idle
    Capture Page Screenshot             ${SCREEN_DIR}${/}profile_page.png

    # 2) เปิดเมนู "การตั้งค่า" จาก dropdown
    #    เผื่อบางธีม dropdown เปิดอัตโนมัติ: ลองกดปุ่ม dropdown ก่อน แล้วกดปุ่ม "การตั้งค่า"
    Wait Until Element Is Visible       ${PROFILE_DROPDOWN_BTN}    ${TIMEOUT}
    Scroll Element Into View            ${PROFILE_DROPDOWN_BTN}
    Click Element                       ${PROFILE_DROPDOWN_BTN}
    Wait Until Element Is Visible       ${BTN_GO_SETTINGS}         ${TIMEOUT}
    Click Element                       ${BTN_GO_SETTINGS}
    Wait Table Idle
    Capture Page Screenshot             ${SCREEN_DIR}${/}profile_settings_panel.png

    # 3) กด "แก้ไขข้อมูลส่วนตัว"
    Wait Until Element Is Visible       ${BTN_PROFILE_EDIT}        ${TIMEOUT}
    Scroll Element Into View            ${BTN_PROFILE_EDIT}
    Click Element                       ${BTN_PROFILE_EDIT}
    Wait Table Idle

    # 4) กรอกข้อมูล
    Wait Until Element Is Visible       ${INPUT_USERNAME}          ${TIMEOUT}
    Clear Element Text                  ${INPUT_USERNAME}
    Input Text                          ${INPUT_USERNAME}          ผู้ใช้ทดสอบ

    Wait Until Element Is Visible       ${INPUT_PHONE}             ${TIMEOUT}
    Clear Element Text                  ${INPUT_PHONE}
    Input Text                          ${INPUT_PHONE}             0891234567    # 10 หลัก

    Capture Page Screenshot             ${SCREEN_DIR}${/}profile_edit_filled.png

    # 5) บันทึก
    Scroll Element Into View            ${BTN_SUBMIT}
    Click Element                       ${BTN_SUBMIT}
    Click If Exists                     ${SWAL_CONFIRM}
    Wait Table Idle
    Capture Page Screenshot             ${SCREEN_DIR}${/}profile_edit_submitted.png
