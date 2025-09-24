*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
# ใช้คีย์เวิร์ดล็อกอินจาก common_keywords ด้วย alias CK ให้ตรงกับไฟล์ cash
Test Setup        CK.Login Using Resource

Resource          ../variables/common_variables.robot
Resource          ../variables/variables.robot
Resource          ../keywords/common_keywords.robot           WITH NAME    CK
Resource          ../keywords/products_keywords.robot         WITH NAME    PK
Resource          ../keywords/order_sell_keywords.robot       WITH NAME    OS

*** Variables ***
${PRODUCT_NAME}        ขนมปังฟาร์มเฮ้าส์โฮลวีท 65 กรัม
${PRODUCT_NAME_2}      โค้กกระป๋อง 325 มล

*** Test Cases ***
ขายสินค้า - ชำระด้วย QR Code
    Create Directory    ${SCREEN_DIR}
    OS.Ensure On Order Sell Page
    OS.Ensure Cart Open

    PK.Try Filter Product By Name      ${PRODUCT_NAME}
    PK.Add Product To Cart By Name     ${PRODUCT_NAME}
    PK.Try Filter Product By Name      ${PRODUCT_NAME_2}
    PK.Add Product To Cart By Name     ${PRODUCT_NAME_2}

    OS.Proceed To Checkout
    Click Element    ${BTN_PAYMENT_QR}
    Capture Page Screenshot    ${SCREEN_DIR}${/}order_qr.png
    # ในโหมด QR อาจไม่มีการยืนยันสำเร็จทันที แค่ถ่ายรูปไว้ตามขั้นตอนที่ให้มา
    CK.Click If Exists    ${SWAL_CONFIRM}
