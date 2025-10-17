*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
# ===== การจัดการเบราว์เซอร์ =====

เปิดเว็บไซต์
    [Documentation]    เปิดเว็บไซต์ POS
    Open Browser    https://frontend-finally-delta.vercel.app/login    chrome
    Set Window Size    1400    900
    Sleep    2s

ปิดเบราว์เซอร์
    [Documentation]    ปิดเบราว์เซอร์
    Close Browser

# ===== การเข้าสู่ระบบ =====

เข้าสู่ระบบ
    [Documentation]    เข้าสู่ระบบ POS
    เปิดเว็บไซต์
    กรอกชื่อผู้ใช้    1
    กรอกรหัสผ่าน    123
    กดปุ่มเข้าสู่ระบบ
    ตรวจสอบเข้าสู่ระบบสำเร็จ

กรอกชื่อผู้ใช้
    [Arguments]    ${username}
    [Documentation]    กรอกชื่อผู้ใช้
    Input Text    css=input[name='username']    ${username}

กรอกรหัสผ่าน
    [Arguments]    ${password}
    [Documentation]    กรอกรหัสผ่าน
    Input Text    css=input[name='password']    ${password}

กดปุ่มเข้าสู่ระบบ
    [Documentation]    กดปุ่มเข้าสู่ระบบ
    Click Button    css=button[type='submit']
    Sleep    3s

ตรวจสอบเข้าสู่ระบบสำเร็จ
    [Documentation]    ตรวจสอบว่าสามารถเข้าสู่ระบบได้
    Page Should Contain    ยินดีต้อนรับ

# ===== การนำทาง =====

ไปที่หน้าหมวดหมู่
    [Documentation]    ไปที่หน้าจัดการหมวดหมู่
    Click Element    xpath=//span[contains(text(),'จัดการ')]
    Sleep    2s
    Click Element    xpath=//a[contains(text(),'ประเภทสินค้า')]
    Sleep    2s

ไปที่หน้าสินค้า
    [Documentation]    ไปที่หน้าจัดการสินค้า
    Click Element    xpath=//span[contains(text(),'จัดการ')]
    Sleep    2s
    Click Element    xpath=//a[contains(text(),'สินค้า')]
    Sleep    2s

ไปที่หน้าซัพพลายเออร์
    [Documentation]    ไปที่หน้าจัดการซัพพลายเออร์
    Click Element    xpath=//span[contains(text(),'จัดการ')]
    Sleep    2s
    Click Element    xpath=//a[contains(text(),'ซัพพลายเออร์')]
    Sleep    2s

ไปที่หน้าตั้งค่า
    [Documentation]    ไปที่หน้าตั้งค่า
    Click Element    xpath=//span[contains(text(),'ตั้งค่า')]
    Sleep    2s

# ===== การจัดการหมวดหมู่ =====

เพิ่มหมวดหมู่ใหม่
    [Arguments]    ${ชื่อหมวดหมู่}
    [Documentation]    เพิ่มหมวดหมู่ใหม่
    Click Element    css=button:contains('เพิ่ม')
    Sleep    1s
    Input Text    css=input[placeholder*='ชื่อ']    ${ชื่อหมวดหมู่}
    Sleep    1s
    Click Element    css=button:contains('บันทึก')
    Sleep    2s

ค้นหาหมวดหมู่
    [Arguments]    ${คำค้นหา}
    [Documentation]    ค้นหาหมวดหมู่
    Input Text    css=input[placeholder*='ค้นหา']    ${คำค้นหา}
    Press Keys    css=input[placeholder*='ค้นหา']    ENTER
    Sleep    2s

ตรวจสอบว่ามีหมวดหมู่
    [Arguments]    ${ชื่อหมวดหมู่}
    [Documentation]    ตรวจสอบว่ามีหมวดหมู่ในรายการ
    Page Should Contain    ${ชื่อหมวดหมู่}

# ===== การจัดการสินค้า =====

ค้นหาสินค้า
    [Arguments]    ${คำค้นหา}
    [Documentation]    ค้นหาสินค้า
    Input Text    css=input[placeholder*='ค้นหา']    ${คำค้นหา}
    Press Keys    css=input[placeholder*='ค้นหา']    ENTER
    Sleep    2s

ตรวจสอบว่ามีสินค้า
    [Arguments]    ${ชื่อสินค้า}
    [Documentation]    ตรวจสอบว่ามีสินค้าในรายการ
    Page Should Contain    ${ชื่อสินค้า}

# ===== การจัดการซัพพลายเออร์ =====

ค้นหาซัพพลายเออร์
    [Arguments]    ${คำค้นหา}
    [Documentation]    ค้นหาซัพพลายเออร์
    Input Text    css=input[placeholder*='ค้นหา']    ${คำค้นหา}
    Press Keys    css=input[placeholder*='ค้นหา']    ENTER
    Sleep    2s

ตรวจสอบว่ามีซัพพลายเออร์
    [Arguments]    ${ชื่อซัพพลายเออร์}
    [Documentation]    ตรวจสอบว่ามีซัพพลายเออร์ในรายการ
    Page Should Contain    ${ชื่อซัพพลายเออร์}

# ===== การตรวจสอบทั่วไป =====

ตรวจสอบว่าอยู่หน้าถูกต้อง
    [Arguments]    ${ชื่อหน้า}
    [Documentation]    ตรวจสอบว่าอยู่หน้าที่ถูกต้อง
    Page Should Contain    ${ชื่อหน้า}

ตรวจสอบชื่อหน้าเว็บ
    [Arguments]    ${ชื่อหน้า}
    [Documentation]    ตรวจสอบชื่อหน้าเว็บ
    Title Should Be    ${ชื่อหน้า}

รอให้โหลดเสร็จ
    [Documentation]    รอให้หน้าเว็บโหลดเสร็จ
    Sleep    2s

รอให้โหลดเสร็จนาน
    [Documentation]    รอให้หน้าเว็บโหลดเสร็จ (นานขึ้น)
    Sleep    5s

# ===== การจัดการข้อมูล =====

กรอกข้อความ
    [Arguments]    ${locator}    ${text}
    [Documentation]    กรอกข้อความในช่องที่ระบุ
    Input Text    ${locator}    ${text}

คลิกปุ่ม
    [Arguments]    ${locator}
    [Documentation]    คลิกปุ่มหรือองค์ประกอบที่ระบุ
    Click Element    ${locator}
    Sleep    1s

คลิกปุ่มและรอ
    [Arguments]    ${locator}
    [Documentation]    คลิกปุ่มและรอให้โหลดเสร็จ
    Click Element    ${locator}
    Sleep    2s

# ===== การจัดการไฟล์ =====

สร้างโฟลเดอร์
    [Arguments]    ${ชื่อโฟลเดอร์}
    [Documentation]    สร้างโฟลเดอร์ใหม่
    Run Keyword And Ignore Error    Create Directory    ${ชื่อโฟลเดอร์}

บันทึกภาพหน้าจอ
    [Arguments]    ${ชื่อไฟล์}
    [Documentation]    บันทึกภาพหน้าจอ
    Capture Page Screenshot    ${ชื่อไฟล์}

# ===== การจัดการข้อผิดพลาด =====

ลองทำและไม่สนใจข้อผิดพลาด
    [Arguments]    ${คำสั่ง}
    [Documentation]    ลองทำคำสั่งและไม่สนใจข้อผิดพลาด
    Run Keyword And Ignore Error    ${คำสั่ง}

ตรวจสอบว่ามีข้อผิดพลาด
    [Arguments]    ${ข้อความ}
    [Documentation]    ตรวจสอบว่ามีข้อความแสดงข้อผิดพลาด
    Page Should Contain    ${ข้อความ}

# ===== การจัดการรายการ =====

เลือกจากรายการ
    [Arguments]    ${locator}    ${ค่า}
    [Documentation]    เลือกค่าจากรายการ
    Select From List    ${locator}    ${ค่า}

ตรวจสอบว่ามีรายการ
    [Arguments]    ${locator}
    [Documentation]    ตรวจสอบว่ามีรายการ
    Element Should Be Visible    ${locator}

# ===== การจัดการตาราง =====

ตรวจสอบว่ามีแถวในตาราง
    [Arguments]    ${ข้อความ}
    [Documentation]    ตรวจสอบว่ามีแถวในตารางที่มีข้อความที่ระบุ
    Page Should Contain    ${ข้อความ}

นับจำนวนแถวในตาราง
    [Arguments]    ${locator}
    [Documentation]    นับจำนวนแถวในตาราง
    ${count}=    Get Element Count    ${locator}
    RETURN    ${count}

# ===== การจัดการฟอร์ม =====

กรอกฟอร์ม
    [Arguments]    ${locator}    ${text}
    [Documentation]    กรอกข้อมูลในฟอร์ม
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}

ล้างฟอร์ม
    [Arguments]    ${locator}
    [Documentation]    ล้างข้อมูลในฟอร์ม
    Clear Element Text    ${locator}

ส่งฟอร์ม
    [Arguments]    ${locator}
    [Documentation]    ส่งฟอร์ม
    Click Element    ${locator}
    Sleep    2s

# ===== การจัดการการรอ =====

รอจนกว่าจะมีข้อความ
    [Arguments]    ${ข้อความ}
    [Documentation]    รอจนกว่าหน้าเว็บจะมีข้อความที่ระบุ
    Wait Until Page Contains    ${ข้อความ}

รอจนกว่าจะไม่มีข้อความ
    [Arguments]    ${ข้อความ}
    [Documentation]    รอจนกว่าหน้าเว็บจะไม่มีข้อความที่ระบุ
    Wait Until Page Does Not Contain    ${ข้อความ}

รอจนกว่าองค์ประกอบจะปรากฏ
    [Arguments]    ${locator}
    [Documentation]    รอจนกว่าองค์ประกอบจะปรากฏ
    Wait Until Element Is Visible    ${locator}

รอจนกว่าองค์ประกอบจะหายไป
    [Arguments]    ${locator}
    [Documentation]    รอจนกว่าองค์ประกอบจะหายไป
    Wait Until Element Is Not Visible    ${locator}
