*** Settings ***
Library    SeleniumLibrary
Resource   ./common_keywords.robot

*** Variables ***
# ปุ่มหลัก
${BTN_CHECKOUT}             css=button[data-tip='ชำระเงิน']
${BTN_PAYMENT_CASH}         xpath=//button[.//h3[contains(normalize-space(.), 'เงินสด')]]
${BTN_PAYMENT_QR}           xpath=//button[.//h3[contains(normalize-space(.), 'QR Code')]]
${BTN_CONFIRM_PAY}          xpath=//button[contains(., 'ยืนยันการชำระเงิน')]
${SUCCESS_TEXT}             สร้างคำสั่งซื้อสำเร็จ

# ตะกร้าสินค้า
${BTN_OPEN_CART_ID}         css=button#open-cart-btn
${CART_HEADING}             xpath=//h2[normalize-space()='ตะกร้าสินค้า']

# ค้นหาสินค้า
${SEARCH_INPUT}             xpath=//input[@type='search']

# สำหรับทดสอบ
${ORDER_BTN_PAYMENT_CASH}     ${BTN_PAYMENT_CASH}
${ORDER_BTN_PAYMENT_QR}       ${BTN_PAYMENT_QR}
${ORDER_BTN_CONFIRM_PAY}      ${BTN_CONFIRM_PAY}
${ORDER_SUCCESS_TEXT}         ${SUCCESS_TEXT}

*** Keywords ***
Go To Order Sell Page
    Go To    ${BASE_URL}/order-sell
    Wait Until Page Contains Element    ${BTN_CHECKOUT}    ${TIMEOUT}

Ensure On Order Sell Page
    ${ok}=    Run Keyword And Return Status    Wait Until Page Contains    ขายสินค้า    3s
    IF    not ${ok}
        Go To Order Sell Page
    END

# ฟังก์ชันหลัก
Click Numeric Key
    [Arguments]    ${digit}
    Click Element    xpath=//button[normalize-space(.)='${digit}']

Ensure Cart Open
    Wait Until Element Is Visible    ${BTN_OPEN_CART_ID}    ${TIMEOUT}
    Click Element    ${BTN_OPEN_CART_ID}
    Wait Until Page Contains Element    ${CART_HEADING}    ${TIMEOUT}

Proceed To Checkout
    Ensure Cart Open
    Wait And Click    ${BTN_CHECKOUT}
    Wait Until Page Contains Element    ${BTN_PAYMENT_CASH}    ${TIMEOUT}

Confirm Payment And Expect Success
    Wait And Click    ${BTN_CONFIRM_PAY}
    Wait Until Page Contains    ${SUCCESS_TEXT}    ${TIMEOUT}
    Sleep    5s
    Click If Exists    ${SWAL_CONFIRM}

Add Product To Cart By Name
    [Arguments]    ${name}
    ${selector}=    Set Variable    xpath=//h2[contains(@class,'font-semibold') and contains(normalize-space(.), '${name}')]/ancestor::div[contains(@class,'cursor-pointer')]
    Wait Until Element Is Visible    ${selector}    ${TIMEOUT}
    Click Element    ${selector}

Try Filter Product By Name
    [Arguments]    ${name}
    ${has_search}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${SEARCH_INPUT}    1s
    IF    ${has_search}
        Clear Element Text    ${SEARCH_INPUT}
        Input Text    ${SEARCH_INPUT}    ${name}
        Sleep    0.4s
    END
