*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ทดสอบการขายสินค้าและจ่ายเงิน
Metadata          owner    qa
Metadata          component    orders
Force Tags        regression    orders
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
TC001 - ขายสินค้าด้วยเงินสด
    [Documentation]    ทดสอบการขายสินค้าและจ่ายเงินด้วยเงินสด
    [Tags]    ขายสินค้า    เงินสด
    
    # เข้าสู่ระบบ
    Login With Credentials    1    123
    
    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    
    # คลิกชำระเงิน
    Wait Until Element Is Visible    xpath=//button[contains(text(),'ชำระเงิน')]    10s
    Click Element    xpath=//button[contains(text(),'ชำระเงิน')]
    Sleep    2s
    
    # เลือกเงินสด
    Wait Until Element Is Visible    xpath=//button[.//h3[contains(text(),'เงินสด')]]    10s
    Click Element    xpath=//button[.//h3[contains(text(),'เงินสด')]]
    Sleep    2s
    
    # กรอกจำนวนเงิน 500
    Wait Until Element Is Visible    xpath=//button[contains(text(),'5')]    10s
    Click Element    xpath=//button[contains(text(),'5')]
    Click Element    xpath=//button[contains(text(),'0')]
    Click Element    xpath=//button[contains(text(),'0')]
    Sleep    2s
    
    # ยืนยันการชำระเงิน
    Wait Until Element Is Visible    xpath=//button[contains(text(),'ยืนยันการชำระเงิน')]    10s
    Click Element    xpath=//button[contains(text(),'ยืนยันการชำระเงิน')]
    Sleep    3s
    
    # ตรวจสอบผลลัพธ์ - ตรวจสอบข้อความ "สร้างคำสั่งซื้อสำเร็จ"
    Wait Until Element Is Visible    xpath=//h2[contains(text(),'สร้างคำสั่งซื้อสำเร็จ')]    10s
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]
TC002 - ขายสินค้าด้วย QR Code
    [Documentation]    ทดสอบการขายสินค้าและจ่ายเงินด้วย QR Code
    [Tags]    ขายสินค้า    QR Code
    
    # เข้าสู่ระบบ
    Login With Credentials    1    123
    
    # คลิกสินค้าชิ้นแรก
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    
    # คลิกสินค้าชิ้นที่สอง
    Wait Until Element Is Visible    css=img[alt*='โค้ก']    10s
    Click Element    css=img[alt*='โค้ก']
    
    # คลิกชำระเงิน
    Wait Until Element Is Visible    xpath=//button[contains(text(),'ชำระเงิน')]    10s
    Click Element    xpath=//button[contains(text(),'ชำระเงิน')]
    Sleep    2s
    
    # เลือก QR Code
    Wait Until Element Is Visible    xpath=//button[contains(.,'QR')]    10s
    Click Element    xpath=//button[contains(.,'QR')]
    Sleep    2s
    
    # ตรวจสอบผลลัพธ์ - ตรวจสอบข้อความ "เลือก PromptPay หรือ Mobile Banking"
    Wait Until Element Is Visible    xpath=//p[contains(text(),'เลือก PromptPay หรือ Mobile Banking')]    10s

