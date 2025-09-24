*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
# เรียกคีย์เวิร์ด Login ด้วย prefix จาก common_keywords (หรือ auth_keywords ถ้าคุณแยกไฟล์)
Test Setup        CK.Login Using Resource

Resource          ../variables/common_variables.robot
Resource          ../variables/variables.robot
Resource          ../keywords/common_keywords.robot           WITH NAME    CK
Resource          ../keywords/products_keywords.robot         WITH NAME    PK
Resource          ../keywords/order_sell_keywords.robot       WITH NAME    OS

*** Variables ***
${PRODUCT_NAME}        ขนมปังฟาร์มเฮ้าส์โฮลวีท 65 กรัม
${PRODUCT_NAME_2}      โค้กกระป๋อง 325 มล

# ปุ่มชำระเงิน (บนหน้าสรุปตะกร้า) และปุ่มเลือกวิธีชำระเงินสด (หน้าเลือกวิธี)
${BTN_PAY_NOW}         xpath=//button[normalize-space(.)='ชำระเงิน' or contains(.,'Pay')]
${BTN_PAYMENT_CASH}    xpath=//button[contains(.,'เงินสด') or contains(.,'Cash')]

*** Test Cases ***
ขายสินค้า - ชำระด้วยเงินสด
    Create Directory    ${SCREEN_DIR}
    Ensure On Order Sell Page
    Ensure Cart Open

    PK.Try Filter Product By Name      ${PRODUCT_NAME}
    PK.Add Product To Cart By Name     ${PRODUCT_NAME}

    PK.Try Filter Product By Name      ${PRODUCT_NAME_2}
    PK.Add Product To Cart By Name     ${PRODUCT_NAME_2}

    # ไปหน้าเช็คเอาต์แล้วกดปุ่ม "ชำระเงิน"
    Wait Until Page Contains Element   ${BTN_PAY_NOW}    10s
    CK.Wait And Click                  ${BTN_PAY_NOW}

    # เลือกวิธีชำระ "เงินสด"
    Wait Until Page Contains Element   ${BTN_PAYMENT_CASH}    10s
    CK.Wait And Click                  ${BTN_PAYMENT_CASH}

    # ใส่จำนวนเงินสด 100
    Click Numeric Key    1
    Click Numeric Key    0
    Click Numeric Key    0

    Confirm Payment And Expect Success
