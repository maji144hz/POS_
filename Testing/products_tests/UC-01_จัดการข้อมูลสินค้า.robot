*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ทดสอบการจัดการข้อมูลสินค้า
Metadata          owner    qa
Metadata          component    products
Force Tags        regression    products
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
TC001 - เพิ่มสินค้าแบบไม่กรอกล็อตกับวันหมดอายุ
    [Documentation]    ทดสอบการเพิ่มสินค้าโดยไม่กรอกข้อมูลล็อตและวันหมดอายุ
    [Tags]    เพิ่มสินค้า

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # คลิกเพิ่มสินค้า
    Wait Until Element Is Visible    css=#stock-add-product-button    15s
    Click Element    css=#stock-add-product-button
    Sleep    2s

    # อัปโหลดรูปสินค้า
    Wait Until Element Is Visible    xpath=//input[@type='file']    15s
    Choose File    xpath=//input[@type='file']    ${CURDIR}/../../images/test_images/น้ำยาล้างจาน.jpg
    Sleep    2s

    # กรอกชื่อสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสินค้า *']    10s
    Click Element    xpath=//input[@placeholder='ชื่อสินค้า *']
    Input Text    xpath=//input[@placeholder='ชื่อสินค้า *']    น้ำยาล้างจาน
    Sleep    1s

    # กรอกรายละเอียดสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='รายละเอียดสินค้า']    10s
    Click Element    xpath=//input[@placeholder='รายละเอียดสินค้า']
    Input Text    xpath=//input[@placeholder='รายละเอียดสินค้า']    น้ำยาล้างจานของดี
    Sleep    1s

    # เลือกหมวดหมู่
    Wait Until Element Is Visible    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    10s
    Select From List By Value    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    6855a82ec16f3c50f07fc147
    Sleep    1s

    # กรอกบาร์โค้ดแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    0150758695519
    Sleep    1s

    # กรอกบาร์โค้ดชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    0646818912454
    Sleep    1s

    # กรอกจำนวนชิ้นในแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    10s
    Click Element    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']
    Input Text    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    12
    Sleep    1s

    # กรอกราคาขายต่อชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10
    Sleep    1s

    # กรอกราคาขายต่อแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    120
    Sleep    2s

    # บันทึกสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึกสินค้า')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึกสินค้า')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC002 - แก้ไขสินค้า
    [Documentation]    ทดสอบการแก้ไขข้อมูลสินค้า
    [Tags]    แก้ไขสินค้า

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # ค้นหาสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ค้นหาสินค้า']    10s
    Input Text    xpath=//input[@placeholder='ค้นหาสินค้า']    น้ำยาล้างจาน
    Press Keys    xpath=//input[@placeholder='ค้นหาสินค้า']    ENTER
    Sleep    2s

    # คลิกแก้ไขสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(@class,'edit')]    10s
    Click Element    xpath=//button[contains(@class,'edit')]
    Sleep    2s

    # แก้ไขชื่อสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสินค้า']    10s
    Clear Element Text    xpath=//input[@placeholder='ชื่อสินค้า']
    Input Text    xpath=//input[@placeholder='ชื่อสินค้า']    น้ำยาล้างจาน แก้ไข
    Sleep    2s

    # บันทึกการแก้ไข
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึก')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึก')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC003 - เพิ่มสินค้าแบบกรอกล็อตและวันหมดอายุ
    [Documentation]    ทดสอบการเพิ่มสินค้าโดยกรอกข้อมูลล็อตและวันหมดอายุ
    [Tags]    เพิ่มสินค้า    ล็อต

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # คลิกเพิ่มสินค้า
    Wait Until Element Is Visible    css=#stock-add-product-button    15s
    Click Element    css=#stock-add-product-button
    Sleep    2s

    # อัปโหลดรูปสินค้า
    Wait Until Element Is Visible    xpath=//input[@type='file']    15s
    Choose File    xpath=//input[@type='file']    ${CURDIR}/../../images/test_images/น้ำยาล้างจาน.jpg
    Sleep    2s

    # กรอกชื่อสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสินค้า *']    10s
    Click Element    xpath=//input[@placeholder='ชื่อสินค้า *']
    Input Text    xpath=//input[@placeholder='ชื่อสินค้า *']    น้ำยาล้างจาน
    Sleep    1s

    # กรอกรายละเอียดสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='รายละเอียดสินค้า']    10s
    Click Element    xpath=//input[@placeholder='รายละเอียดสินค้า']
    Input Text    xpath=//input[@placeholder='รายละเอียดสินค้า']    น้ำยาล้างจานของดี
    Sleep    1s

    # เลือกหมวดหมู่
    Wait Until Element Is Visible    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    10s
    Select From List By Value    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    6855a82ec16f3c50f07fc147
    Sleep    1s

    # กรอกบาร์โค้ดแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    0150758695519
    Sleep    1s

    # กรอกบาร์โค้ดชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    0646818912454
    Sleep    1s

    # กรอกจำนวนชิ้นในแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    10s
    Click Element    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']
    Input Text    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    12
    Sleep    1s

    # กรอกราคาขายต่อชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10
    Sleep    1s

    # กรอกราคาขายต่อแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    120
    Sleep    1s

    # กรอกข้อมูลล็อต
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    10s
    Click Element    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']
    Input Text    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    120
    Sleep    1s

    # กรอกราคาซื้อต่อหน่วย
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    10s
    Click Element    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']
    Input Text    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    6
    Sleep    1s

    # กรอกวันหมดอายุ
    Wait Until Element Is Visible    xpath=//input[@name='initialLot.expirationDate']    10s
    Input Text    xpath=//input[@name='initialLot.expirationDate']    2025-10-17
    Sleep    2s

    # บันทึกสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึกสินค้า')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึกสินค้า')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC004 - เพิ่มสินค้าแบบกรอกแค่รูปชื่อกับรายละเอียดสินค้า
    [Documentation]    ทดสอบการเพิ่มสินค้าโดยกรอกแค่รูป ชื่อ และรายละเอียด
    [Tags]    เพิ่มสินค้า    ขั้นต่ำ

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # คลิกเพิ่มสินค้า
    Wait Until Element Is Visible    css=#stock-add-product-button    15s
    Click Element    css=#stock-add-product-button
    Sleep    2s

    # อัปโหลดรูปสินค้า
    Wait Until Element Is Visible    xpath=//input[@type='file']    15s
    Choose File    xpath=//input[@type='file']    ${CURDIR}/../../images/test_images/น้ำยาล้างจาน.jpg
    Sleep    2s

    # กรอกชื่อสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสินค้า *']    10s
    Click Element    xpath=//input[@placeholder='ชื่อสินค้า *']
    Input Text    xpath=//input[@placeholder='ชื่อสินค้า *']    น้ำยาล้างจาน
    Sleep    1s

    # กรอกรายละเอียดสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='รายละเอียดสินค้า']    10s
    Click Element    xpath=//input[@placeholder='รายละเอียดสินค้า']
    Input Text    xpath=//input[@placeholder='รายละเอียดสินค้า']    น้ำยาล้างจานของดี
    Sleep    2s

    # บันทึกสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึกสินค้า')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึกสินค้า')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC005 - เพิ่มสินค้าแบบกรอกจำนวนติดลบ
    [Documentation]    ทดสอบการเพิ่มสินค้าโดยกรอกจำนวนติดลบ
    [Tags]    เพิ่มสินค้า    ข้อมูลผิด

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # คลิกเพิ่มสินค้า
    Wait Until Element Is Visible    css=#stock-add-product-button    15s
    Click Element    css=#stock-add-product-button
    Sleep    2s

    # อัปโหลดรูปสินค้า
    Wait Until Element Is Visible    xpath=//input[@type='file']    15s
    Choose File    xpath=//input[@type='file']    ${CURDIR}/../../images/test_images/น้ำยาล้างจาน.jpg
    Sleep    2s

    # กรอกชื่อสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสินค้า *']    10s
    Click Element    xpath=//input[@placeholder='ชื่อสินค้า *']
    Input Text    xpath=//input[@placeholder='ชื่อสินค้า *']    น้ำยาล้างจาน
    Sleep    1s

    # กรอกรายละเอียดสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='รายละเอียดสินค้า']    10s
    Click Element    xpath=//input[@placeholder='รายละเอียดสินค้า']
    Input Text    xpath=//input[@placeholder='รายละเอียดสินค้า']    น้ำยาล้างจานของดี
    Sleep    1s

    # เลือกหมวดหมู่
    Wait Until Element Is Visible    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    10s
    Select From List By Value    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    6855a82ec16f3c50f07fc147
    Sleep    1s

    # กรอกบาร์โค้ดแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    0150758695519
    Sleep    1s

    # กรอกบาร์โค้ดชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    0646818912454
    Sleep    1s

    # กรอกจำนวนชิ้นในแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    10s
    Click Element    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']
    Input Text    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    12
    Sleep    1s

    # กรอกราคาขายต่อชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10
    Sleep    1s

    # กรอกราคาขายต่อแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    120
    Sleep    1s

    # กรอกจำนวนติดลบ
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    10s
    Click Element    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']
    Input Text    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    -120
    Sleep    1s

    # กรอกราคาซื้อต่อหน่วย
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    10s
    Click Element    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']
    Input Text    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    6
    Sleep    1s

    # กรอกวันหมดอายุ
    Wait Until Element Is Visible    xpath=//input[@name='initialLot.expirationDate']    10s
    Input Text    xpath=//input[@name='initialLot.expirationDate']    2025-12-31
    Sleep    2s

    # บันทึกสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึกสินค้า')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึกสินค้า')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC006 - เพิ่มสินค้าแบบราคาซื้อมากกว่าขาย
    [Documentation]    ทดสอบการเพิ่มสินค้าโดยราคาซื้อมากกว่าราคาขาย
    [Tags]    เพิ่มสินค้า    ราคาผิด

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # คลิกเพิ่มสินค้า
    Wait Until Element Is Visible    css=#stock-add-product-button    15s
    Click Element    css=#stock-add-product-button
    Sleep    2s

    # อัปโหลดรูปสินค้า
    Wait Until Element Is Visible    xpath=//input[@type='file']    15s
    Choose File    xpath=//input[@type='file']    ${CURDIR}/../../images/test_images/น้ำยาล้างจาน.jpg
    Sleep    2s

    # กรอกชื่อสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสินค้า *']    10s
    Click Element    xpath=//input[@placeholder='ชื่อสินค้า *']
    Input Text    xpath=//input[@placeholder='ชื่อสินค้า *']    น้ำยาล้างจาน
    Sleep    1s

    # กรอกรายละเอียดสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='รายละเอียดสินค้า']    10s
    Click Element    xpath=//input[@placeholder='รายละเอียดสินค้า']
    Input Text    xpath=//input[@placeholder='รายละเอียดสินค้า']    น้ำยาล้างจานของดี
    Sleep    1s

    # เลือกหมวดหมู่
    Wait Until Element Is Visible    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    10s
    Select From List By Value    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    6855a82ec16f3c50f07fc147
    Sleep    1s

    # กรอกบาร์โค้ดแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    0150758695519
    Sleep    1s

    # กรอกบาร์โค้ดชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    0646818912454
    Sleep    1s

    # กรอกจำนวนชิ้นในแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    10s
    Click Element    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']
    Input Text    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    12
    Sleep    1s

    # กรอกราคาขายต่อชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10
    Sleep    1s

    # กรอกราคาขายต่อแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    120
    Sleep    1s

    # กรอกราคาซื้อมากกว่าขาย
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    10s
    Click Element    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']
    Input Text    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    120
    Sleep    1s

    # กรอกราคาซื้อต่อหน่วย
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    10s
    Click Element    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']
    Input Text    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    60
    Sleep    1s

    # กรอกวันหมดอายุ
    Wait Until Element Is Visible    xpath=//input[@name='initialLot.expirationDate']    10s
    Input Text    xpath=//input[@name='initialLot.expirationDate']    2025-12-31
    Sleep    2s

    # บันทึกสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึกสินค้า')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึกสินค้า')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC007 - เพิ่มสินค้าแบบกรอกวันที่หมดอายุไปแล้ว
    [Documentation]    ทดสอบการเพิ่มสินค้าโดยกรอกวันที่หมดอายุไปแล้ว
    [Tags]    เพิ่มสินค้า    วันที่ผิด

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # คลิกเพิ่มสินค้า
    Wait Until Element Is Visible    css=#stock-add-product-button    15s
    Click Element    css=#stock-add-product-button
    Sleep    2s

    # อัปโหลดรูปสินค้า
    Wait Until Element Is Visible    xpath=//input[@type='file']    15s
    Choose File    xpath=//input[@type='file']    ${CURDIR}/../../images/test_images/น้ำยาล้างจาน.jpg
    Sleep    2s

    # กรอกชื่อสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสินค้า *']    10s
    Click Element    xpath=//input[@placeholder='ชื่อสินค้า *']
    Input Text    xpath=//input[@placeholder='ชื่อสินค้า *']    น้ำยาล้างจาน
    Sleep    1s

    # กรอกรายละเอียดสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='รายละเอียดสินค้า']    10s
    Click Element    xpath=//input[@placeholder='รายละเอียดสินค้า']
    Input Text    xpath=//input[@placeholder='รายละเอียดสินค้า']    น้ำยาล้างจานของดี
    Sleep    1s

    # เลือกหมวดหมู่
    Wait Until Element Is Visible    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    10s
    Select From List By Value    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    6855a82ec16f3c50f07fc147
    Sleep    1s

    # กรอกบาร์โค้ดแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    0150758695519
    Sleep    1s

    # กรอกบาร์โค้ดชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    0646818912454
    Sleep    1s

    # กรอกจำนวนชิ้นในแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    10s
    Click Element    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']
    Input Text    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    12
    Sleep    1s

    # กรอกราคาขายต่อชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10
    Sleep    1s

    # กรอกราคาขายต่อแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    120
    Sleep    1s

    # กรอกวันที่หมดอายุไปแล้ว
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    10s
    Click Element    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']
    Input Text    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    120
    Sleep    1s

    # กรอกราคาซื้อต่อหน่วย
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    10s
    Click Element    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']
    Input Text    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    6
    Sleep    1s

    # กรอกวันหมดอายุ
    Wait Until Element Is Visible    xpath=//input[@name='initialLot.expirationDate']    10s
    Input Text    xpath=//input[@name='initialLot.expirationDate']    2014-01-11
    Sleep    2s

    # บันทึกสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึกสินค้า')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึกสินค้า')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC008 - เพิ่มสินค้าแบบกดยกเลิกแทนตกลง
    [Documentation]    ทดสอบการเพิ่มสินค้าโดยกดยกเลิกแทนตกลง
    [Tags]    เพิ่มสินค้า    ยกเลิก

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # คลิกเพิ่มสินค้า
    Wait Until Element Is Visible    css=#stock-add-product-button    15s
    Click Element    css=#stock-add-product-button
    Sleep    2s

    # อัปโหลดรูปสินค้า
    Wait Until Element Is Visible    xpath=//input[@type='file']    15s
    Choose File    xpath=//input[@type='file']    ${CURDIR}/../../images/test_images/น้ำยาล้างจาน.jpg
    Sleep    2s

    # กรอกชื่อสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสินค้า *']    10s
    Click Element    xpath=//input[@placeholder='ชื่อสินค้า *']
    Input Text    xpath=//input[@placeholder='ชื่อสินค้า *']    น้ำยาล้างจาน
    Sleep    1s

    # กรอกรายละเอียดสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='รายละเอียดสินค้า']    10s
    Click Element    xpath=//input[@placeholder='รายละเอียดสินค้า']
    Input Text    xpath=//input[@placeholder='รายละเอียดสินค้า']    น้ำยาล้างจานของดี
    Sleep    1s

    # เลือกหมวดหมู่
    Wait Until Element Is Visible    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    10s
    Select From List By Value    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    6855a82ec16f3c50f07fc147
    Sleep    1s

    # กรอกบาร์โค้ดแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    0150758695519
    Sleep    1s

    # กรอกบาร์โค้ดชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    0646818912454
    Sleep    1s

    # กรอกจำนวนชิ้นในแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    10s
    Click Element    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']
    Input Text    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    12
    Sleep    1s

    # กรอกราคาขายต่อชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10
    Sleep    1s

    # กรอกราคาขายต่อแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    120
    Sleep    1s

    # กรอกข้อมูลล็อต
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    10s
    Click Element    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']
    Input Text    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    120
    Sleep    1s

    # กรอกราคาซื้อต่อหน่วย
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    10s
    Click Element    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']
    Input Text    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    6
    Sleep    1s

    # กรอกวันหมดอายุ
    Wait Until Element Is Visible    xpath=//input[@name='initialLot.expirationDate']    10s
    Input Text    xpath=//input[@name='initialLot.expirationDate']    2025-12-31
    Sleep    2s

    # บันทึกสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึกสินค้า')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึกสินค้า')]
    Sleep    3s

    # กดยกเลิกแทนตกลง
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-cancel')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-cancel')]

TC009 - เพิ่มสินค้าแบบกรอกบาร์โค้ดซ้ำ
    [Documentation]    ทดสอบการเพิ่มสินค้าโดยกรอกบาร์โค้ดซ้ำ
    [Tags]    เพิ่มสินค้า    บาร์โค้ดซ้ำ

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # คลิกเพิ่มสินค้า
    Wait Until Element Is Visible    css=#stock-add-product-button    15s
    Click Element    css=#stock-add-product-button
    Sleep    2s

    # อัปโหลดรูปสินค้า
    Wait Until Element Is Visible    xpath=//input[@type='file']    15s
    Choose File    xpath=//input[@type='file']    ${CURDIR}/../../images/test_images/น้ำยาล้างจาน.jpg
    Sleep    2s

    # กรอกชื่อสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ชื่อสินค้า *']    10s
    Click Element    xpath=//input[@placeholder='ชื่อสินค้า *']
    Input Text    xpath=//input[@placeholder='ชื่อสินค้า *']    น้ำยาล้างจาน
    Sleep    1s

    # กรอกรายละเอียดสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='รายละเอียดสินค้า']    10s
    Click Element    xpath=//input[@placeholder='รายละเอียดสินค้า']
    Input Text    xpath=//input[@placeholder='รายละเอียดสินค้า']    น้ำยาล้างจานของดี
    Sleep    1s

    # เลือกหมวดหมู่
    Wait Until Element Is Visible    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    10s
    Select From List By Value    xpath=//select[@aria-label='หมวดหมู่สินค้า *']    6855a82ec16f3c50f07fc147
    Sleep    1s

    # กรอกบาร์โค้ดแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดแพ็ค']    0150758695519
    Sleep    1s

    # กรอกบาร์โค้ดชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']
    Input Text    xpath=//input[@placeholder='บาร์โค้ดชิ้น *']    0646818912454
    Sleep    1s

    # กรอกจำนวนชิ้นในแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    10s
    Click Element    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']
    Input Text    xpath=//input[@placeholder='จำนวนชิ้นที่มีใน 1 แพ็ค']    12
    Sleep    1s

    # กรอกราคาขายต่อชิ้น
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อชิ้น *']    10
    Sleep    1s

    # กรอกราคาขายต่อแพ็ค
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    10s
    Click Element    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']
    Input Text    xpath=//input[@placeholder='ราคาขายต่อแพ็ค']    120
    Sleep    1s

    # กรอกข้อมูลล็อต
    Wait Until Element Is Visible    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    10s
    Click Element    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']
    Input Text    xpath=//input[@placeholder='จำนวนสินค้าในล็อตแรก']    120
    Sleep    1s

    # กรอกราคาซื้อต่อหน่วย
    Wait Until Element Is Visible    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    10s
    Click Element    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']
    Input Text    xpath=//input[@placeholder='ราคาซื้อต่อหน่วย']    6
    Sleep    1s

    # กรอกวันหมดอายุ
    Wait Until Element Is Visible    xpath=//input[@name='initialLot.expirationDate']    10s
    Input Text    xpath=//input[@name='initialLot.expirationDate']    2025-12-31
    Sleep    2s

    # บันทึกสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(text(),'บันทึกสินค้า')]    10s
    Click Element    xpath=//button[contains(text(),'บันทึกสินค้า')]
    Sleep    3s

    # ยืนยันการบันทึก
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]

TC010 - ลบสินค้า
    [Documentation]    ทดสอบการลบสินค้า
    [Tags]    ลบสินค้า

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # ไปที่หน้าสินค้า
    Wait Until Element Is Visible    xpath=//a[@href='/product']    10s
    Click Element    xpath=//a[@href='/product']
    Sleep    2s
    Wait Until Element Is Visible    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]    10s
    Click Element    xpath=//a[@href='/product/' and contains(text(),'ทั้งหมด')]
    Sleep    2s

    # ค้นหาสินค้า
    Wait Until Element Is Visible    xpath=//input[@placeholder='ค้นหาสินค้า']    10s
    Input Text    xpath=//input[@placeholder='ค้นหาสินค้า']    น้ำยาล้างจาน
    Press Keys    xpath=//input[@placeholder='ค้นหาสินค้า']    ENTER
    Sleep    2s

    # คลิกลบสินค้า
    Wait Until Element Is Visible    xpath=//button[contains(@class,'delete')]    10s
    Click Element    xpath=//button[contains(@class,'delete')]
    Sleep    2s

    # ยืนยันการลบ
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm')]    10s
    Click Element    xpath=//button[contains(@class,'swal2-confirm')]
    Sleep    3s

