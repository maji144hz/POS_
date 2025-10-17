*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ทดสอบการจัดการหมวดหมู่สินค้า
Metadata          owner    qa
Metadata          component    categories
Force Tags        regression    categories
Default Tags      ui

Suite Setup       เปิดเบราว์เซอร์
Suite Teardown    ปิดเบราว์เซอร์
Test Setup        เปิดเบราว์เซอร์ใหม่
Test Teardown     ปิดเบราว์เซอร์

Resource          ../../keywords/common_keywords.robot

*** Test Cases ***
TC001 - เพิ่มหมวดหมู่
    [Documentation]    ทดสอบการเพิ่มหมวดหมู่สินค้าใหม่
    [Tags]    เพิ่มหมวดหมู่

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าหมวดหมู่
    Wait Until Element Is Visible    xpath=//a[@href='/category']    10s
    Click Element    xpath=//a[@href='/category']
    Sleep    2s

    # คลิกเพิ่มหมวดหมู่
    Wait Until Element Is Visible    xpath=//button[contains(text(),'เพิ่มหมวดหมู่')]    10s
    Click Element    xpath=//button[contains(text(),'เพิ่มหมวดหมู่')]
    Sleep    2s

    # กรอกชื่อหมวดหมู่
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อหมวดหมู่']    10s
    Click Element    xpath=//input[@placeholder='ชื่อหมวดหมู่']
    Input Text    xpath=//input[@placeholder='ชื่อหมวดหมู่']    ทดสอบหมวดหมู่
    Sleep    2s

    # บันทึกหมวดหมู่
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึก')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึก')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC002 - แก้ไขหมวดหมู่
    [Documentation]    ทดสอบการแก้ไขข้อมูลหมวดหมู่สินค้า
    [Tags]    แก้ไขหมวดหมู่

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าหมวดหมู่
    Wait Until Element Is Visible    xpath=//a[@href='/category']    10s
    Click Element    xpath=//a[@href='/category']
    Sleep    2s

    # ค้นหาหมวดหมู่
    Wait Until Element Is Visible    xpath=//input[@placeholder='ค้นหาหมวดหมู่']    10s
    Input Text    xpath=//input[@placeholder='ค้นหาหมวดหมู่']    ทดสอบหมวดหมู่
    Press Keys    xpath=//input[@placeholder='ค้นหาหมวดหมู่']    ENTER
    Sleep    2s

    # คลิกแก้ไขหมวดหมู่
    Wait Until Element Is Visible    xpath=//button[contains(@class,'edit')]    10s
    Click Element    xpath=//button[contains(@class,'edit')]
    Sleep    2s

    # แก้ไขชื่อหมวดหมู่
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อหมวดหมู่']    10s
    Clear Element Text    xpath=//input[@placeholder='ชื่อหมวดหมู่']
    Input Text    xpath=//input[@placeholder='ชื่อหมวดหมู่']    ทดสอบหมวดหมู่ แก้ไข
    Sleep    2s

    # บันทึกการแก้ไข
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึก')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึก')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC003 - ลบหมวดหมู่
    [Documentation]    ทดสอบการลบหมวดหมู่สินค้า
    [Tags]    ลบหมวดหมู่

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าหมวดหมู่
    Wait Until Element Is Visible    xpath=//a[@href='/category']    10s
    Click Element    xpath=//a[@href='/category']
    Sleep    2s

    # ค้นหาหมวดหมู่
    Wait Until Element Is Visible    xpath=//input[@placeholder='ค้นหาหมวดหมู่']    10s
    Input Text    xpath=//input[@placeholder='ค้นหาหมวดหมู่']    ทดสอบหมวดหมู่ แก้ไข
    Press Keys    xpath=//input[@placeholder='ค้นหาหมวดหมู่']    ENTER
    Sleep    2s

    # คลิกลบหมวดหมู่
    Wait Until Element Is Visible    xpath=//button[contains(@class,'delete')]    10s
    Click Element    xpath=//button[contains(@class,'delete')]
    Sleep    2s

    # ยืนยันการลบ
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]
    Sleep    3s

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

