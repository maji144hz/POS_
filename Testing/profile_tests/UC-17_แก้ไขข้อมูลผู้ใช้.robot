*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ทดสอบการแก้ไขข้อมูลผู้ใช้
Metadata          owner    qa
Metadata          component    profile
Force Tags        regression    profile
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
TC001 - แก้ไขข้อมูลส่วนตัว
    [Documentation]    ทดสอบการแก้ไขข้อมูลส่วนตัว
    [Tags]    แก้ไขข้อมูล

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าโปรไฟล์
    Wait Until Element Is Visible    xpath=//a[@href='/profile']    10s
    Click Element    xpath=//a[@href='/profile']
    Sleep    2s

    # คลิกเมนูการตั้งค่า
    Wait Until Element Is Visible    xpath=//button[contains(@class,'dropdown')]    10s
    Click Element    xpath=//button[contains(@class,'dropdown')]
    Sleep    1s

    # คลิกไปการตั้งค่า
    Wait Until Element Is Visible    xpath=//a[contains(text(),'การตั้งค่า')]    10s
    Click Element    xpath=//a[contains(text(),'การตั้งค่า')]
    Sleep    2s

    # คลิกแก้ไขโปรไฟล์
    Wait Until Element Is Visible    xpath=//button[contains(text(),'แก้ไขโปรไฟล์')]    10s
    Click Element    xpath=//button[contains(text(),'แก้ไขโปรไฟล์')]
    Sleep    2s

    # แก้ไขชื่อผู้ใช้
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อผู้ใช้']    10s
    Clear Element Text    xpath=//input[@placeholder='ชื่อผู้ใช้']
    Input Text    xpath=//input[@placeholder='ชื่อผู้ใช้']    ผู้ใช้ทดสอบ
    Sleep    1s

    # แก้ไขเบอร์โทรศัพท์
    Wait Until Element Is Visible    xpath=//input[@placeholder='เบอร์โทรศัพท์']    10s
    Clear Element Text    xpath=//input[@placeholder='เบอร์โทรศัพท์']
    Input Text    xpath=//input[@placeholder='เบอร์โทรศัพท์']    0891234567
    Sleep    2s

    # บันทึกการแก้ไข
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึก')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึก')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC002 - เปลี่ยนรูปโปรไฟล์
    [Documentation]    ทดสอบการเปลี่ยนรูปโปรไฟล์
    [Tags]    เปลี่ยนรูป

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าโปรไฟล์
    Wait Until Element Is Visible    xpath=//a[@href='/profile']    10s
    Click Element    xpath=//a[@href='/profile']
    Sleep    2s

    # คลิกเมนูการตั้งค่า
    Wait Until Element Is Visible    xpath=//button[contains(@class,'dropdown')]    10s
    Click Element    xpath=//button[contains(@class,'dropdown')]
    Sleep    1s

    # คลิกไปการตั้งค่า
    Wait Until Element Is Visible    xpath=//a[contains(text(),'การตั้งค่า')]    10s
    Click Element    xpath=//a[contains(text(),'การตั้งค่า')]
    Sleep    2s

    # คลิกแก้ไขโปรไฟล์
    Wait Until Element Is Visible    xpath=//button[contains(text(),'แก้ไขโปรไฟล์')]    10s
    Click Element    xpath=//button[contains(text(),'แก้ไขโปรไฟล์')]
    Sleep    2s

    # อัปโหลดรูปโปรไฟล์
    Wait Until Element Is Visible    xpath=//input[@type='file']    10s
    Choose File    xpath=//input[@type='file']    ${CURDIR}/../../images/test_images/น้ำยาล้างจาน.jpg
    Sleep    2s

    # บันทึกการแก้ไข
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึก')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึก')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

