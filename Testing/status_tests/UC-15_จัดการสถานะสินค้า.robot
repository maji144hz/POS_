*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ทดสอบการจัดการสถานะสินค้า
Metadata          owner    qa
Metadata          component    status
Force Tags        regression    status
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
TC001 - เพิ่มสถานะสินค้า
    [Documentation]    ทดสอบการเพิ่มสถานะสินค้าใหม่
    [Tags]    เพิ่มสถานะ

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสถานะสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/status']    10s
    Click Element    xpath=//a[@href='/status']
    Sleep    2s

    # คลิกเพิ่มสถานะ
    Wait Until Element Is Visible    xpath=//button[contains(text(),'เพิ่มสถานะ')]    10s
    Click Element    xpath=//button[contains(text(),'เพิ่มสถานะ')]
    Sleep    2s

    # กรอกชื่อสถานะ
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสถานะ']    10s
    Click Element    xpath=//input[@placeholder='ชื่อสถานะ']
    Input Text    xpath=//input[@placeholder='ชื่อสถานะ']    ทดสอบสถานะ
    Sleep    2s

    # บันทึกสถานะ
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึก')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึก')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC002 - แก้ไขสถานะสินค้า
    [Documentation]    ทดสอบการแก้ไขข้อมูลสถานะสินค้า
    [Tags]    แก้ไขสถานะ

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสถานะสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/status']    10s
    Click Element    xpath=//a[@href='/status']
    Sleep    2s

    # ค้นหาสถานะ
    Wait Until Element Is Visible    xpath=//input[@placeholder='ค้นหาสถานะ']    10s
    Input Text    xpath=//input[@placeholder='ค้นหาสถานะ']    ทดสอบสถานะ
    Press Keys    xpath=//input[@placeholder='ค้นหาสถานะ']    ENTER
    Sleep    2s

    # คลิกแก้ไขสถานะ
    Wait Until Element Is Visible    xpath=//button[contains(@class,'edit')]    10s
    Click Element    xpath=//button[contains(@class,'edit')]
    Sleep    2s

    # แก้ไขชื่อสถานะ
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสถานะ']    10s
    Clear Element Text    xpath=//input[@placeholder='ชื่อสถานะ']
    Input Text    xpath=//input[@placeholder='ชื่อสถานะ']    ทดสอบสถานะ แก้ไข
    Sleep    2s

    # บันทึกการแก้ไข
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึก')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึก')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC003 - ลบสถานะสินค้า
    [Documentation]    ทดสอบการลบสถานะสินค้า
    [Tags]    ลบสถานะ

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสถานะสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/status']    10s
    Click Element    xpath=//a[@href='/status']
    Sleep    2s

    # ค้นหาสถานะ
    Wait Until Element Is Visible    xpath=//input[@placeholder='ค้นหาสถานะ']    10s
    Input Text    xpath=//input[@placeholder='ค้นหาสถานะ']    ทดสอบสถานะ แก้ไข
    Press Keys    xpath=//input[@placeholder='ค้นหาสถานะ']    ENTER
    Sleep    2s

    # คลิกลบสถานะ
    Wait Until Element Is Visible    xpath=//button[contains(@class,'delete')]    10s
    Click Element    xpath=//button[contains(@class,'delete')]
    Sleep    2s

    # ยืนยันการลบ
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]
    Sleep    3s

