*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ทดสอบการจัดการซัพพลายเออร์
Metadata          owner    qa
Metadata          component    suppliers
Force Tags        regression    suppliers
Default Tags      ui

Suite Setup       เปิดเบราว์เซอร์
Suite Teardown    ปิดเบราว์เซอร์
Test Setup        เปิดเบราว์เซอร์ใหม่
Test Teardown     ปิดเบราว์เซอร์

Resource          ../../keywords/common_keywords.robot

*** Keywords ***
เปิดเบราว์เซอร์
    Open Browser    https://frontend-finally-delta.vercel.app/    chrome
    Set Window Size    1400    900
    Sleep    2s

เปิดเบราว์เซอร์ใหม่
    Close All Browsers
    Sleep    2s
    Open Browser    https://frontend-finally-delta.vercel.app/    chrome
    Set Window Size    1400    900
    Sleep    2s

ไปที่หน้าหลัก
    Go To    https://frontend-finally-delta.vercel.app
    Sleep    2s

กลับไปหน้าหลัก
    Go To    https://frontend-finally-delta.vercel.app
    Sleep    1s
    Log    รอ 3 วินาทีก่อนเริ่ม Test Case ถัดไป
    Sleep    3s

ปิดเบราว์เซอร์
    Close Browser

*** Test Cases ***
TC001 - เพิ่มซัพพลายเออร์
    [Documentation]    ทดสอบการเพิ่มซัพพลายเออร์ใหม่
    [Tags]    เพิ่มซัพพลายเออร์

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//a[@href='/supplier']    10s
    Click Element    xpath=//a[@href='/supplier']
    Sleep    2s

    # คลิกเพิ่มซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//button[contains(text(),'เพิ่มซัพพลายเออร์')]    10s
    Click Element    xpath=//button[contains(text(),'เพิ่มซัพพลายเออร์')]
    Sleep    2s

    # กรอกชื่อซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อซัพพลายเออร์']    10s
    Click Element    xpath=//input[@placeholder='ชื่อซัพพลายเออร์']
    Input Text    xpath=//input[@placeholder='ชื่อซัพพลายเออร์']    ทดสอบซัพพลายเออร์
    Sleep    1s

    # กรอกชื่อผู้ติดต่อ
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อผู้ติดต่อ']    10s
    Click Element    xpath=//input[@placeholder='ชื่อผู้ติดต่อ']
    Input Text    xpath=//input[@placeholder='ชื่อผู้ติดต่อ']    คุณสมชาย
    Sleep    1s

    # กรอกเบอร์โทรศัพท์
    Wait Until Element Is Visible    xpath=//input[@placeholder='เบอร์โทรศัพท์']    10s
    Click Element    xpath=//input[@placeholder='เบอร์โทรศัพท์']
    Input Text    xpath=//input[@placeholder='เบอร์โทรศัพท์']    0812345678
    Sleep    1s

    # กรอกที่อยู่
    Wait Until Element Is Visible    xpath=//textarea[@placeholder='ที่อยู่']    10s
    Click Element    xpath=//textarea[@placeholder='ที่อยู่']
    Input Text    xpath=//textarea[@placeholder='ที่อยู่']    123/45 ถนนทดสอบ เขตทดสอบ กรุงเทพฯ
    Sleep    2s

    # บันทึกซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึก')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึก')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC002 - แก้ไขซัพพลายเออร์
    [Documentation]    ทดสอบการแก้ไขข้อมูลซัพพลายเออร์
    [Tags]    แก้ไขซัพพลายเออร์

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//a[@href='/supplier']    10s
    Click Element    xpath=//a[@href='/supplier']
    Sleep    2s

    # ค้นหาซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//input[@placeholder='ค้นหาซัพพลายเออร์']    10s
    Input Text    xpath=//input[@placeholder='ค้นหาซัพพลายเออร์']    ทดสอบซัพพลายเออร์
    Press Keys    xpath=//input[@placeholder='ค้นหาซัพพลายเออร์']    ENTER
    Sleep    2s

    # คลิกแก้ไขซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//button[contains(@class,'edit')]    10s
    Click Element    xpath=//button[contains(@class,'edit')]
    Sleep    2s

    # แก้ไขชื่อซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อซัพพลายเออร์']    10s
    Clear Element Text    xpath=//input[@placeholder='ชื่อซัพพลายเออร์']
    Input Text    xpath=//input[@placeholder='ชื่อซัพพลายเออร์']    ทดสอบซัพพลายเออร์ แก้ไข
    Sleep    2s

    # บันทึกการแก้ไข
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึก')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึก')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC003 - ลบซัพพลายเออร์
    [Documentation]    ทดสอบการลบซัพพลายเออร์
    [Tags]    ลบซัพพลายเออร์

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//a[@href='/supplier']    10s
    Click Element    xpath=//a[@href='/supplier']
    Sleep    2s

    # ค้นหาซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//input[@placeholder='ค้นหาซัพพลายเออร์']    10s
    Input Text    xpath=//input[@placeholder='ค้นหาซัพพลายเออร์']    ทดสอบซัพพลายเออร์ แก้ไข
    Press Keys    xpath=//input[@placeholder='ค้นหาซัพพลายเออร์']    ENTER
    Sleep    2s

    # คลิกลบซัพพลายเออร์
    Wait Until Element Is Visible    xpath=//button[contains(@class,'delete')]    10s
    Click Element    xpath=//button[contains(@class,'delete')]
    Sleep    2s

    # ยืนยันการลบ
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]
    Sleep    3s

