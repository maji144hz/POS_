*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ชุดทดสอบการขาย: เงินสด/โอน/QR ด้วย ORDER_* selectors
Metadata          owner    qa
Metadata          component    orders
Force Tags        regression    orders
Default Tags      ui

Suite Setup       NONE
Suite Teardown    NONE
Test Setup        Test Setup Sequence
Test Teardown     Test Teardown Sequence

Resource          ../../keywords/common_keywords.robot
Resource          ../../keywords/order_sell_keywords.robot

*** Variables ***
${PRODUCT_NAME}        ขนมปังฟาร์มเฮ้าส์โฮลวีท 65 กรัม
${PRODUCT_NAME_2}      โค้กกระป๋อง 325 มล

*** Test Cases ***
TC001 - ขายสินค้า (ชำระด้วยเงินสด)
    Safe Log    เริ่มต้น Cash Flow
    Ensure On Order Sell Page
    Ensure Cart Open

    Wait Table Idle
    Add Product To Cart By Name     ${PRODUCT_NAME}

    Wait Table Idle
    Proceed To Checkout

    Wait Table Idle
    Wait And Click    ${ORDER_BTN_PAYMENT_CASH}

    Click Numeric Key    1
    Click Numeric Key    0
    Click Numeric Key    0

    Confirm Payment And Expect Success
    Safe Log    ชำระเงินสดสำเร็จ

TC003 - ขายสินค้า (ชำระด้วย QR Code)
    Safe Log    เริ่มต้น QR Flow
    Ensure On Order Sell Page
    Ensure Cart Open

    Try Filter Product By Name      ${PRODUCT_NAME}
    Add Product To Cart By Name     ${PRODUCT_NAME}
    Try Filter Product By Name      ${PRODUCT_NAME_2}
    Add Product To Cart By Name     ${PRODUCT_NAME_2}

    Proceed To Checkout
    Wait Table Idle
    Wait And Click    ${ORDER_BTN_PAYMENT_QR}
    Log Step And Screenshot    เปิดหน้าจ่ายเงิน - QR    order_qr
    Click If Exists    ${SWAL_CONFIRM}
