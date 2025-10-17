*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections

# ========================================
# ไฟล์: common_keywords.robot
# หน้าที่: เก็บฟังก์ชันพื้นฐานที่ทุกเทสต้องใช้
# ใช้สำหรับ: เปิดเว็บ, เข้าสู่ระบบ, ฟังก์ชันช่วยเหลือ
# ========================================

*** Variables ***
# ข้อมูลพื้นฐาน
${BASE_URL}           https://frontend-finally-delta.vercel.app/login
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SCREEN_DIR}         screenshots

# Element พื้นฐาน
${SPINNERS}           css=.ant-spin,.loading,.v-overlay--active,.swal2-container
${SWAL_CONFIRM}       css=button.swal2-confirm

*** Keywords ***
# ฟังก์ชันพื้นฐาน
Safe Log
    [Arguments]    @{items}
    Log    @{items}

# ตั้งค่าเบื้องต้น
Test Setup Sequence
    Open Browser To Login Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}

Test Teardown Sequence
    Close All Browsers

Open Browser To Login Page
    Open Browser    ${BASE_URL}    chrome
    Set Window Size    1400    900
    Set Selenium Timeout    ${TIMEOUT}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    css=input[name='username']
    Input Text    css=input[name='username']    ${username}
    Input Text    css=input[name='password']    ${password}
    Click Button   css=button[type='submit']
    Wait Table Idle

# ฟังก์ชันช่วยเหลือ
Wait Table Idle
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    ${SPINNERS}    5s
    Sleep    0.3s

Click If Exists
    [Arguments]    ${locator}
    ${ok}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    2s
    Run Keyword If    ${ok}    Click Element    ${locator}

Wait And Click
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    5s
    Click Element    ${locator}
