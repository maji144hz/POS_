*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
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
ขายสินค้า - โอนเงินผ่านธนาคาร
    Create Directory    ${SCREEN_DIR}
    OS.Ensure On Order Sell Page
    OS.Ensure Cart Open

    PK.Try Filter Product By Name      ${PRODUCT_NAME}
    PK.Add Product To Cart By Name     ${PRODUCT_NAME}
    PK.Try Filter Product By Name      ${PRODUCT_NAME_2}
    PK.Add Product To Cart By Name     ${PRODUCT_NAME_2}

    OS.Proceed To Checkout
    Click Element    ${BTN_PAYMENT_BANK}
    Capture Page Screenshot    ${SCREEN_DIR}${/}order_bank_transfer.png
    # หากมีการยืนยันสำเร็จเหมือนเงินสดให้คลิกยืนยันและตรวจข้อความ
    ${has_confirm}=    Run Keyword And Return Status    Page Should Contain Element    ${BTN_CONFIRM_PAY}
    IF    ${has_confirm}
        Click Element    ${BTN_CONFIRM_PAY}
        Wait Until Page Contains    ${SUCCESS_TEXT}    ${TIMEOUT}
        Capture Page Screenshot    ${SCREEN_DIR}${/}order_bank_transfer_success.png
        CK.Click If Exists    ${SWAL_CONFIRM}
    END

