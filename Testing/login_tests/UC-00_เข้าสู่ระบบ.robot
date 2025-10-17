*** Settings ***
Resource          ../../variables/login_variables.robot
Resource          ../../keywords/login_keywords.robot
Resource          ../../keywords/common_keywords.robot
Documentation     ทดสอบการเข้าสู่ระบบ
Metadata          owner    qa
Metadata          component    login
Force Tags        regression    login
Default Tags      ui

Suite Setup       เปิดเบราว์เซอร์
Suite Teardown    ปิดเบราว์เซอร์
Test Setup        เปิดเบราว์เซอร์ใหม่
Test Teardown     ปิดเบราว์เซอร์

*** Test Cases ***
TC001 - เข้าสู่ระบบสำเร็จ
    [Documentation]    ทดสอบการเข้าสู่ระบบสำเร็จ
    [Tags]    เข้าสู่ระบบสำเร็จ
    
    Log    เริ่มทดสอบ TC001 - เข้าสู่ระบบสำเร็จ
    Initialize Test Logging
    Open Browser To Login Page
    Log Step And Screenshot    เปิดหน้า Login
    
    Input Username    perth1
    Input Password    1234
    Submit Credentials
    
    Welcome Page Should Be Open
    Log Step And Screenshot    เข้าสู่ระบบสำเร็จ
    Capture Page Screenshot    TC001_เข้าสู่ระบบสำเร็จ_เสร็จสิ้น.png
    Log    เสร็จสิ้น TC001 - เข้าสู่ระบบสำเร็จ

TC002 - เข้าสู่ระบบไม่สำเร็จ
    [Documentation]    ทดสอบการเข้าสู่ระบบด้วยข้อมูลผิด
    [Tags]    เข้าสู่ระบบล้มเหลว
    
    Log    เริ่มทดสอบ TC002 - เข้าสู่ระบบไม่สำเร็จ
    [Setup]    Run Keywords    Initialize Test Logging    AND    Open Browser To Login Page    AND    Log Step And Screenshot    เปิดหน้า Login
    [Template]    Login With Invalid Credentials Should Fail
    
    Username ผิด                 perth1          ${VALID_PASSWORD}
    Password ผิด                 ${VALID_USER}    122
    Username และ Password ผิด    invalid          whatever
    ไม่กรอก Username             ${EMPTY}         ${VALID_PASSWORD}
    ไม่กรอก Password             ${VALID_USER}    ${EMPTY}
    ไม่กรอกอะไรเลย               ${EMPTY}         ${EMPTY}
    
    Capture Page Screenshot    TC002_เข้าสู่ระบบไม่สำเร็จ_เสร็จสิ้น.png
    Log    เสร็จสิ้น TC002 - เข้าสู่ระบบไม่สำเร็จ

*** Keywords ***
เปิดเบราว์เซอร์
    Open Browser    https://frontend-finally-delta.vercel.app/login    chrome
    Set Window Size    1400    900
    Sleep    2s

เปิดเบราว์เซอร์ใหม่
    Close All Browsers
    Sleep    2s
    Open Browser    https://frontend-finally-delta.vercel.app/login    chrome
    Set Window Size    1400    900
    Sleep    2s

ไปที่หน้าหลัก
    Go To    https://frontend-finally-delta.vercel.app/
    Sleep    2s

กลับไปหน้าหลัก
    Go To    https://frontend-finally-delta.vercel.app/
    Sleep    1s
    Log    รอ 3 วินาทีก่อนเริ่ม Test Case ถัดไป
    Sleep    3s

ปิดเบราว์เซอร์
    Close Browser

