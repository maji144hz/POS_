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
เปลี่ยนรูปโปรไฟล์ (อัปโหลดรูป) — ถ่ายภาพทุกขั้นตอน
    [Documentation]    ล็อกอิน → /profile → เมนูการตั้งค่า → แก้ไขข้อมูลส่วนตัว → อัปโหลดรูป → บันทึก
    Create Directory                    ${SCREEN_DIR}

    # 1) เปิดหน้าโปรไฟล์
    Go To                               ${PROFILE_URL}
    Wait Table Idle
    Capture Page Screenshot             ${SCREEN_DIR}${/}profile_page.png

    # 2) เปิดเมนู "การตั้งค่า"
    Wait Until Element Is Visible       ${PROFILE_DROPDOWN_BTN}    ${TIMEOUT}
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
    Capture Page Screenshot             ${SCREEN_DIR}${/}profile_edit_open.png

    # 4) อัปโหลดรูปใหม่
    Upload Avatar From Path             ${AVATAR_FILEPATH}
    # ถ่ายภาพหลังเลือกรูป (ตัวพรีวิวมักจะเปลี่ยน)
    Capture Page Screenshot             ${SCREEN_DIR}${/}profile_avatar_selected.png

    # 5) บันทึก
    Scroll Element Into View            ${BTN_SUBMIT}
    Click Element                       ${BTN_SUBMIT}
    Click If Exists                     ${SWAL_CONFIRM}
    Wait Table Idle
    Capture Page Screenshot             ${SCREEN_DIR}${/}profile_avatar_saved.png
