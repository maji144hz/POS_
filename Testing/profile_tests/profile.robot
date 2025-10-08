*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ชุดทดสอบโปรไฟล์: แก้ไขข้อมูล/เปลี่ยนรูป ด้วย PROFILE_* locators
Metadata          owner    qa
Metadata          component    profile
Force Tags        regression    profile
Default Tags      ui

Suite Setup       NONE
Suite Teardown    NONE
Test Setup        Run Keywords    Open Browser To Login Page    AND    Initialize Test Logging    AND    Login And Go To Profile Page
Test Teardown     Run Keywords    End Test Logging    AND    Close All Browsers

Resource          ../../variables/common_variables.robot
Resource          ../../variables/profile_variables.robot
Resource          ../../keywords/common_keywords.robot
Resource          ../../keywords/profile_keywords.robot

*** Test Cases ***
TC001 - แก้ไขข้อมูลส่วนตัว (ถ่ายภาพทุกขั้นตอน)
    [Documentation]    ล็อกอิน → /profile → เปิดเมนูการตั้งค่า → แก้ไขข้อมูลส่วนตัว → กรอก username/phone → บันทึก
    Log Step And Screenshot             เริ่มต้นแก้ไขโปรไฟล์
    Go To                               ${PROFILE_URL}
    Wait Table Idle
    Log Step And Screenshot             เปิดหน้าโปรไฟล์    profile_page
    Wait Until Element Is Visible       ${PROFILE_DROPDOWN_BTN}    ${TIMEOUT}
    Scroll Element Into View            ${PROFILE_DROPDOWN_BTN}
    Click Element                       ${PROFILE_DROPDOWN_BTN}
    Wait Until Element Is Visible       ${BTN_GO_SETTINGS}         ${TIMEOUT}
    Click Element                       ${BTN_GO_SETTINGS}
    Wait Table Idle
    Log Step And Screenshot             เปิดแผงการตั้งค่า    profile_settings_panel
    Wait Until Element Is Visible       ${BTN_PROFILE_EDIT}        ${TIMEOUT}
    Scroll Element Into View            ${BTN_PROFILE_EDIT}
    Click Element                       ${BTN_PROFILE_EDIT}
    Wait Table Idle
    Wait Until Element Is Visible       ${INPUT_USERNAME}          ${TIMEOUT}
    Clear Element Text                  ${INPUT_USERNAME}
    Input Text                          ${INPUT_USERNAME}          ผู้ใช้ทดสอบ
    Wait Until Element Is Visible       ${INPUT_PHONE}             ${TIMEOUT}
    Clear Element Text                  ${INPUT_PHONE}
    Input Text                          ${INPUT_PHONE}             0891234567
    Log Step And Screenshot             กรอกข้อมูลครบ    profile_edit_filled
    Scroll Element Into View            ${BTN_SUBMIT}
    Click Element                       ${BTN_SUBMIT}
    Click If Exists                     ${SWAL_CONFIRM}
    Wait Table Idle
    Log Step And Screenshot             บันทึกสำเร็จ    profile_edit_submitted

TC002 - เปลี่ยนรูปโปรไฟล์ (อัปโหลดรูป)
    [Documentation]    ล็อกอิน → /profile → เมนูการตั้งค่า → แก้ไขข้อมูลส่วนตัว → อัปโหลดรูป → บันทึก
    Log Step And Screenshot             เริ่มต้นเปลี่ยนรูปโปรไฟล์
    Go To                               ${PROFILE_URL}
    Wait Table Idle
    Log Step And Screenshot             เปิดหน้าโปรไฟล์    profile_page
    Wait Until Element Is Visible       ${PROFILE_DROPDOWN_BTN}    ${TIMEOUT}
    Click Element                       ${PROFILE_DROPDOWN_BTN}
    Wait Until Element Is Visible       ${BTN_GO_SETTINGS}         ${TIMEOUT}
    Click Element                       ${BTN_GO_SETTINGS}
    Wait Table Idle
    Log Step And Screenshot             เปิดแผงการตั้งค่า    profile_settings_panel
    Wait Until Element Is Visible       ${BTN_PROFILE_EDIT}        ${TIMEOUT}
    Scroll Element Into View            ${BTN_PROFILE_EDIT}
    Click Element                       ${BTN_PROFILE_EDIT}
    Wait Table Idle
    Log Step And Screenshot             เปิดหน้าแก้ไข    profile_edit_open
    Upload Avatar From Path             ${AVATAR_FILEPATH}
    Log Step And Screenshot             เลือกรูปใหม่แล้ว    profile_avatar_selected
    Scroll Element Into View            ${BTN_SUBMIT}
    Click Element                       ${BTN_SUBMIT}
    Click If Exists                     ${SWAL_CONFIRM}
    Wait Table Idle
    Log Step And Screenshot             บันทึกรูปสำเร็จ    profile_avatar_saved

