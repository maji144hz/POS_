*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ทดสอบการสร้างคำสั่งซื้อ
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
TC001 - เพิ่มสินค้าเข้าไปในตะกร้า
    [Documentation]    TC-9001: ตรวจสอบว่าสามารถสร้างคำสั่งซื้อได้สำเร็จ
    [Tags]    เพิ่มสินค้า

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    Sleep    2s

    # ตรวจสอบว่าน้ำยาล้างจานถูกเพิ่มไปยังตะกร้าสินค้า
    Wait Until Element Is Visible    xpath=//h3[contains(text(),'น้ำยาล้างจาน')]    10sTC002 - แก้ไขจำนวนสินค้าในคำสั่งซื้อ
    [Documentation]    TC-9002: ตรวจสอบว่าสามารถแก้ไขจำนวนสินค้าในคำสั่งซื้อได้
    [Tags]    แก้ไขจำนวน

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    Sleep    2s

    # คลิกปุ่ม "+" สองครั้งเพื่อเพิ่มจำนวนเป็น "3"
    Wait Until Element Is Visible    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]    10s
    Click Element    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]
    Sleep    1s
    Click Element    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]
    Sleep    2s

    # ตรวจสอบว่าน้ำยาล้างจานถูกเพิ่มเป็น 3 ชิ้น
    Wait Until Element Is Visible    xpath=//span[@class='w-8 text-center font-medium' and contains(text(),'3')]    10s

TC003 - ลบรายการสินค้าออกจากคำสั่งซื้อ
    [Documentation]    TC-9003: ตรวจสอบว่าสามารถลบรายการสินค้าออกจากคำสั่งซื้อได้
    [Tags]    ลบสินค้า

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    Sleep    2s

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='มาม่า']    10s
    Click Element    css=img[alt*='มาม่า']
    Sleep    2s

    # กดเลือกถังขยะในสินค้ามาม่า
    Wait Until Element Is Visible    xpath=//button[contains(@class,'delete')]    10s
    Click Element    xpath=//button[contains(@class,'delete')]
    Sleep    2s

    # ตรวจสอบว่ามาม่าถูกลบออกจากตะกร้า
    Wait Until Element Is Not Visible    xpath=//h3[contains(text(),'มาม่า')]    10s

TC004 - ยกเลิกคำสั่งซื้อทั้งหมด
    [Documentation]    TC-9004: ตรวจสอบการยกเลิกคำสั่งซื้อทั้งหมด
    [Tags]    ยกเลิกคำสั่งซื้อ

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    Sleep    2s

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='มาม่า']    10s
    Click Element    css=img[alt*='มาม่า']
    Sleep    2s

    # คลิกปุ่ม "ยกเลิก"
    Wait Until Element Is Visible    xpath=//button[contains(text(),'ยกเลิก')]    10s
    Click Element    xpath=//button[contains(text(),'ยกเลิก')]
    Sleep    2s

    # ตรวจสอบว่าตะกร้าถูกล้าง
    Wait Until Element Is Not Visible    xpath=//h3[contains(text(),'น้ำยาล้างจาน')]    10s

TC005 - เปลี่ยนสินค้าจากชิ้นเป็นแพ็ค
    [Documentation]    TC-9005: ตรวจสอบว่าสามารถแก้ไขจำนวนสินค้าในคำสั่งซื้อได้
    [Tags]    เปลี่ยนหน่วย

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    Sleep    2s

    # คลิกปุ่ม toggle เพื่อเปลี่ยนเป็นแพ็ค
    Wait Until Element Is Visible    xpath=//button[contains(@class,'bg-gray-300')]    10s
    Click Element    xpath=//button[contains(@class,'bg-gray-300')]
    Sleep    2s

    # ตรวจสอบว่าสินค้าเปลี่ยนเป็นแพ็ค (ปุ่ม toggle เป็นสีเขียว)
    Wait Until Element Is Visible    xpath=//button[contains(@class,'bg-green-500')]    10s

TC006 - เปลี่ยนเป็นแพ็คแล้วเพิ่มจำนวนให้มากที่สุด
    [Documentation]    TC-9006: ตรวจสอบว่าสามารถแก้ไขจำนวนสินค้าในคำสั่งซื้อได้
    [Tags]    เปลี่ยนหน่วย    เพิ่มจำนวน

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    Sleep    2s

    # คลิกปุ่ม toggle เพื่อเปลี่ยนเป็นแพ็ค
    Wait Until Element Is Visible    xpath=//button[contains(@class,'bg-gray-300')]    10s
    Click Element    xpath=//button[contains(@class,'bg-gray-300')]
    Sleep    2s

    # คลิกปุ่ม "+" ให้มากที่สุด
    Wait Until Element Is Visible    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]    10s
    FOR    ${i}    IN RANGE    10
        Click Element    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]
        Sleep    0.5s
    END
    Sleep    2s

    # ตรวจสอบว่าสินค้าเพิ่มจำนวนมากที่สุด
    Wait Until Element Is Visible    xpath=//div[contains(text(),'แพ็ค')]    10s

TC007 - เพิ่มสินค้าให้มากที่สุดแล้วเปลี่ยนเป็นแพ็ค
    [Documentation]    TC-9007: ตรวจสอบว่าสามารถแก้ไขจำนวนสินค้าในคำสั่งซื้อได้
    [Tags]    เพิ่มจำนวน    เปลี่ยนหน่วย

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    Sleep    2s

    # คลิกปุ่ม "+" ให้มากที่สุด
    Wait Until Element Is Visible    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]    10s
    FOR    ${i}    IN RANGE    10
        Click Element    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]
        Sleep    0.5s
    END
    Sleep    2s

    # คลิกปุ่ม toggle เพื่อเปลี่ยนเป็นแพ็ค
    Wait Until Element Is Visible    xpath=//button[contains(@class,'bg-gray-300')]    10s
    Click Element    xpath=//button[contains(@class,'bg-gray-300')]
    Sleep    2s

    # ตรวจสอบว่าสินค้าเปลี่ยนเป็นแพ็ค (ปุ่ม toggle เป็นสีเขียว)
    Wait Until Element Is Visible    xpath=//button[contains(@class,'bg-green-500')]    10s

    # คลิกปุ่ม toggle เพื่อเปลี่ยนกลับเป็นชิ้น
    Wait Until Element Is Visible    xpath=//button[contains(@class,'bg-green-500')]    10s
    Click Element    xpath=//button[contains(@class,'bg-green-500')]
    Sleep    2s

    # ตรวจสอบว่าสินค้าเปลี่ยนกลับเป็นชิ้น (ปุ่ม toggle เป็นสีเทา)
    Wait Until Element Is Visible    xpath=//button[contains(@class,'bg-gray-300')]    10s

TC008 - เพิ่มและลดจำนวนสินค้า
    [Documentation]    TC-9008: ตรวจสอบว่าสามารถแก้ไขจำนวนสินค้าในคำสั่งซื้อได้
    [Tags]    เพิ่มลดจำนวน

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    Sleep    2s

    # คลิกปุ่ม "+" สองครั้งเพื่อเพิ่มจำนวนเป็น "3"
    Wait Until Element Is Visible    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]    10s
    Click Element    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]
    Sleep    1s
    Click Element    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'+')]
    Sleep    2s

    # คลิกปุ่ม "-" หนึ่งครั้งเพื่อลดจำนวนเป็น "2"
    Wait Until Element Is Visible    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'-')]    10s
    Click Element    xpath=//button[@class='w-8 h-8 flex items-center justify-center text-gray-500 hover:text-gray-700' and contains(text(),'-')]
    Sleep    2s

    # ตรวจสอบว่าจำนวนเป็น 2
    Wait Until Element Is Visible    xpath=//span[@class='w-8 text-center font-medium' and contains(text(),'2')]    10s

TC009 - เคลียร์ตะกร้าทั้งหมด
    [Documentation]    TC-9009: ตรวจสอบการยกเลิกคำสั่งซื้อทั้งหมด
    [Tags]    เคลียร์ตะกร้า

    # เข้าสู่ระบบ
    Login With Credentials    1    123

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='น้ำยาล้างจาน']    10s
    Click Element    css=img[alt*='น้ำยาล้างจาน']
    Sleep    2s

    # คลิกสินค้าโดยตรง
    Wait Until Element Is Visible    css=img[alt*='มาม่า']    10s
    Click Element    css=img[alt*='มาม่า']
    Sleep    2s

    # คลิกปุ่ม "เคลียร์ตะกร้าทั้งหมด"
    Wait Until Element Is Visible    xpath=//button[contains(text(),'เคลียร์ตะกร้าทั้งหมด')]    10s
    Click Element    xpath=//button[contains(text(),'เคลียร์ตะกร้าทั้งหมด')]
    Sleep    2s

    # ตรวจสอบว่าตะกร้าสินค้าถูกเคลียร์
    Wait Until Element Is Not Visible    xpath=//h3[contains(text(),'น้ำยาล้างจาน')]    10s

TC010 - เพิ่มสินค้าด้วยบาร์โค้ดแบบชิ้น
    [Documentation]    TC-9010: ตรวจสอบว่าสามารถลบรายการสินค้าออกจากคำสั่งซื้อได้
    [Tags]    บาร์โค้ด

    # เข้าสู่ระบบ
    Login With Credentials    1    123



    # กรอกบาร์โค้ด 2000125080091 โค้กกระป๋อง (แบบชิ้น)
    Wait Until Element Is Visible    xpath=//input[@placeholder='กรอกบาร์โค้ด']    10s
    Click Element    xpath=//input[@placeholder='กรอกบาร์โค้ด']
    Input Text    xpath=//input[@placeholder='กรอกบาร์โค้ด']    2000125080091
    Press Keys    xpath=//input[@placeholder='กรอกบาร์โค้ด']    ENTER
    Sleep    2s

    # ตรวจสอบว่าโค้กกระป๋องถูกเพิ่มไปยังตะกร้า
    Wait Until Element Is Visible    xpath=//h3[contains(text(),'โค้กกระป๋อง')]    10s

TC011 - เพิ่มสินค้าด้วยบาร์โค้ดแบบแพ็ค
    [Documentation]    TC-9011: ตรวจสอบว่าสามารถลบรายการสินค้าออกจากคำสั่งซื้อได้
    [Tags]    บาร์โค้ด

    # เข้าสู่ระบบ
    Login With Credentials    1    123



    # กรอกบาร์โค้ด 2000225080083 โค้กกระป๋อง (แบบแพ็ค)
    Wait Until Element Is Visible    xpath=//input[@placeholder='กรอกบาร์โค้ด']    10s
    Click Element    xpath=//input[@placeholder='กรอกบาร์โค้ด']
    Input Text    xpath=//input[@placeholder='กรอกบาร์โค้ด']    2000225080083
    Press Keys    xpath=//input[@placeholder='กรอกบาร์โค้ด']    ENTER
    Sleep    2s

    # ตรวจสอบว่าโค้กกระป๋องถูกเพิ่มไปยังตะกร้า
    Wait Until Element Is Visible    xpath=//h3[contains(text(),'โค้กกระป๋อง')]    10s

TC012 - เพิ่มสินค้าด้วยเครื่องสแกนบาร์โค้ด
    [Documentation]    TC-9012: ตรวจสอบว่าสามารถแก้ไขจำนวนสินค้าในคำสั่งซื้อได้
    [Tags]    สแกนบาร์โค้ด

    # เข้าสู่ระบบ
    Login With Credentials    1    123


    # ใช้เครื่องสแกนบาร์โค้ด (จำลองด้วยการกรอกบาร์โค้ด)
    Wait Until Element Is Visible    xpath=//input[@placeholder='กรอกบาร์โค้ด']    10s
    Click Element    xpath=//input[@placeholder='กรอกบาร์โค้ด']
    Input Text    xpath=//input[@placeholder='กรอกบาร์โค้ด']    2000125080091
    Press Keys    xpath=//input[@placeholder='กรอกบาร์โค้ด']    ENTER
    Sleep    2s

    # รอสินค้าถูกพิมพ์มาที่ตะกร้าสินค้า
    Wait Until Element Is Visible    xpath=//div[contains(text(),'โค้กกระป๋อง')]    10s

    # ตรวจสอบว่าสินค้าเพิ่มไปยังตะกร้า
    Wait Until Element Is Visible    xpath=//div[contains(text(),'โค้กกระป๋อง')]    10s


