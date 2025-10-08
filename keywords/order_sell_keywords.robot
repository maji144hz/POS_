*** Settings ***
Library    SeleniumLibrary
Resource   ./common_keywords.robot

*** Variables ***
# --- Buttons / Elements ---
${BTN_CHECKOUT}             css=button.px-6.py-3.text-white.bg-green-500.rounded-xl.font-medium.hover\\:bg-green-600.transition-colors
${BTN_CHECKOUT_SPECIFIC}    css=button.px-6.py-3.text-white.bg-green-500.rounded-xl.font-medium.hover\\:bg-green-600.transition-colors

${BTN_PAYMENT_CASH}         xpath=//button[.//h3[contains(normalize-space(.), 'เงินสด')]]
${BTN_PAYMENT_QR}           xpath=//button[.//h3[contains(normalize-space(.), 'QR Code')]]
${BTN_PAYMENT_BANK}         xpath=//button[.//h3[contains(normalize-space(.), 'โอนเงินผ่านธนาคาร')]]
${BTN_CONFIRM_PAY}          xpath=//button[contains(., 'ยืนยันการชำระเงิน')]
${SUCCESS_TEXT}             สร้างคำสั่งซื้อสำเร็จ

${BTN_CART_ICON}            xpath=//path[@d='M528.12 301.319l47.273-208C578.806 78.301 567.391 64 551.99 64H159.208l-9.166-44.81C147.758 8.021 137.93 0 126.529 0H24C10.745 0 0 10.745 0 24v16c0 13.255 10.745 24 24 24h69.883l70.248 343.435C147.325 417.1 136 435.222 136 456c0 30.928 25.072 56 56 56s56-25.072 56-56c0-15.674-6.447-29.835-16.824-40h209.647C430.447 426.165 424 440.326 424 456c0 30.928 25.072 56 56 56s56-25.072 56-56c0-22.172-12.888-41.332-31.579-50.405l5.517-24.276c3.413-15.018-8.002-29.319-23.403-29.319H218.117l-6.545-32h293.145c11.206 0 20.92-7.754 23.403-18.681z']/ancestor::button[1]
${BTN_OPEN_CART_ID}         css=button#open-cart-btn
${BTN_OPEN_CART_ICON}       xpath=//button[.//path[starts-with(@d,'M528.12')]]
${OPEN_CART_DATA_TIP}       css=button[data-tip='สร้างคำสั่งซื้อ']
${CART_DRAWER_HINT}         xpath=//*[contains(@class,'cart') or contains(@class,'drawer') or contains(@class,'offcanvas') or @role='dialog']
${CART_HEADING}             xpath=//h2[normalize-space()='ตะกร้าสินค้า']

${SEARCH_INPUT_OPT1}        xpath=//input[@type='search']
${SEARCH_INPUT_OPT2}        xpath=//input[contains(@placeholder,'ค้นหา') or contains(@placeholder,'Search')]

# --- Fallbacks for Pay Now ---
${BTN_CHECKOUT_ALT1}        xpath=//a[contains(., 'ชำระเงิน')]
${BTN_CHECKOUT_ALT2}        xpath=//button[contains(@class,'bg-green-500')][contains(@class,'rounded-xl')][contains(., 'ชำระเงิน')]
${BTN_CHECKOUT_ALT3}        xpath=//*[self::a or self::button][contains(normalize-space(.), 'ชำระเงิน')]

# --- Mapping for tests (ORDER_* -> BTN_*) ---
${ORDER_BTN_PAY_NOW}          ${BTN_CHECKOUT_SPECIFIC}
${ORDER_BTN_PAYMENT_CASH}     ${BTN_PAYMENT_CASH}
${ORDER_BTN_PAYMENT_BANK}     ${BTN_PAYMENT_BANK}
${ORDER_BTN_PAYMENT_QR}       ${BTN_PAYMENT_QR}
${ORDER_BTN_CONFIRM_PAY}      ${BTN_CONFIRM_PAY}
${ORDER_SUCCESS_TEXT}         ${SUCCESS_TEXT}

*** Keywords ***
Go To Order Sell Page
    Go To    ${BASE_URL}/order-sell
    Wait Until Page Contains Element    ${BTN_CHECKOUT}    ${TIMEOUT}

Ensure On Order Sell Page
    ${ok1}=    Run Keyword And Return Status    Wait Until Page Contains    ขายสินค้า    3s
    ${ok2}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//input[@type='search' or contains(@placeholder,'ค้นหา') or contains(@placeholder,'Search')]    3s
    IF    not (${ok1} or ${ok2})
        Go To Order Sell Page
    END

Open Order Sell From Menu
    ${menu}=    Set Variable    xpath=//span[contains(text(), 'ออเดอร์ขาย')]
    Wait Until Page Contains Element    ${menu}    ${TIMEOUT}
    Click Element    ${menu}
    ${link_opt1}=    Set Variable    css=a.p-2.text-gray-600[href='/order-sell/']
    ${link_opt2}=    Set Variable    css=a.p-2.text-gray-600[href='/order-sell']
    ${found1}=    Run Keyword And Return Status    Page Should Contain Element    ${link_opt1}
    ${found2}=    Run Keyword And Return Status    Page Should Contain Element    ${link_opt2}
    IF    ${found1}
        ${link}=    Set Variable    ${link_opt1}
    ELSE IF    ${found2}
        ${link}=    Set Variable    ${link_opt2}
    ELSE
        Fail    ไม่พบลิงก์ไปหน้า order-sell
    END
    Wait Until Page Contains Element    ${link}    ${TIMEOUT}
    Click Element    ${link}
    ${add_btn}=    Set Variable    xpath=//button[contains(@class,'fixed')][contains(@class,'text-green-500')][contains(@class,'rounded-full')]
    ${has_add}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${add_btn}    2s
    Run Keyword If    ${has_add}    Click Element    ${add_btn}
    Wait Until Page Contains Element    ${BTN_CHECKOUT}    ${TIMEOUT}

Select Product Card By Name
    [Arguments]    ${name}
    ${card_exact}=        Set Variable    xpath=//h2[contains(@class,'font-semibold') and (normalize-space(.)='${name}' or @title='${name}')]/ancestor::div[contains(@class,'cursor-pointer')]
    ${card_contains}=     Set Variable    xpath=//h2[contains(@class,'font-semibold') and (contains(normalize-space(.), '${name}') or contains(@title, '${name}'))]/ancestor::div[contains(@class,'cursor-pointer')]
    ${h2_exact}=          Set Variable    xpath=//h2[contains(@class,'font-semibold') and (normalize-space(.)='${name}' or @title='${name}')]
    ${img_exact}=         Set Variable    xpath=//img[@alt='${name}']/ancestor::div[contains(@class,'cursor-pointer')]

    ${target}=    Set Variable    ${EMPTY}
    ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${card_exact}
    IF    ${found}
        ${target}=    Set Variable    ${card_exact}
    ELSE
        ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${card_contains}
        IF    ${found}
            ${target}=    Set Variable    ${card_contains}
        ELSE
            ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${img_exact}
            IF    ${found}
                ${target}=    Set Variable    ${img_exact}
            ELSE
                ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${h2_exact}
                IF    ${found}
                    ${target}=    Set Variable    ${h2_exact}
                END
            END
        END
    END

    Run Keyword If    $target == ""    Fail    ไม่พบสินค้า: ${name}

    Wait Until Element Is Visible    ${target}    ${TIMEOUT}
    Scroll Element Into View    ${target}
    Sleep    0.2s
    ${clicked}=    Run Keyword And Return Status    Click Element    ${target}
    IF    not ${clicked}
        ${el}=    Get WebElement    ${target}
        Execute Javascript    arguments[0].click();    ARGUMENTS    ${el}
    END
    ${icon_visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${BTN_CART_ICON}    1s
    IF    ${icon_visible}
        Click Element    ${BTN_CART_ICON}
    END

Click Numeric Key
    [Arguments]    ${digit}
    Click Element    xpath=//button[normalize-space(.)='${digit}']

Open Cart Floating Button
    Wait Until Element Is Visible    ${BTN_OPEN_CART_ID}    ${TIMEOUT}
    Scroll Element Into View    ${BTN_OPEN_CART_ID}
    Sleep    0.5s
    ${clicked}=    Run Keyword And Return Status    Click Element    ${BTN_OPEN_CART_ID}
    IF    not ${clicked}
        ${clicked}=    Run Keyword And Return Status    Click Element    ${OPEN_CART_DATA_TIP}
    END
    IF    not ${clicked}
        ${clicked}=    Run Keyword And Return Status    Click Element    ${BTN_OPEN_CART_ICON}
    END
    IF    not ${clicked}
        Execute Javascript    var b=document.getElementById('open-cart-btn');if(b){b.click();return true;}return false;
    END
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${CART_DRAWER_HINT}    3s

Ensure Cart Open
    Safe Log    Opening cart...
    Open Cart Floating Button
    ${opened}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${CART_HEADING}    4s
    Safe Log    Cart opened: ${opened}
    IF    not ${opened}
        Safe Log    Retrying to open cart...
        Open Cart Floating Button
        Wait Until Page Contains Element    ${CART_HEADING}    ${TIMEOUT}
    END
    Safe Log    Cart is now open

# คลิกปุ่มชำระเงินแบบฉลาด (ลองหลาย selector)
Click Pay Now Smart
    ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${BTN_CHECKOUT_SPECIFIC}
    IF    ${found}
        Wait And Click    ${BTN_CHECKOUT_SPECIFIC}
    ELSE
        ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${BTN_CHECKOUT}
        IF    ${found}
            Wait And Click    ${BTN_CHECKOUT}
        ELSE
            Fail    ไม่พบปุ่ม ชำระเงิน
        END
    END

Proceed To Checkout
    Ensure Cart Open
    Click Pay Now Smart
    Wait Until Page Contains Element    ${BTN_PAYMENT_CASH}    ${TIMEOUT}

Confirm Payment And Expect Success
    Wait And Click    ${BTN_CONFIRM_PAY}
    Wait Until Page Contains    ${SUCCESS_TEXT}    ${TIMEOUT}
    Sleep    5s
    Capture Page Screenshot    ${SCREEN_DIR}${/}order_cash_success.png
    Click If Exists    ${SWAL_CONFIRM}

Get First Present Locator
    [Arguments]    @{locators}
    FOR    ${loc}    IN    @{locators}
        ${ok}=    Run Keyword And Return Status    Page Should Contain Element    ${loc}
        IF    ${ok}    RETURN    ${loc}
    END
    Safe Log    [OrderSell] ไม่พบ element จากตัวเลือก:    @{locators}
    Run Keyword And Ignore Error    Capture Page Screenshot    ${SCREEN_DIR}${/}order_not_found.png
    RETURN    ${EMPTY}

Add Product To Cart By Name
    [Arguments]    ${name}
    Safe Log    [DEBUG] กำลังหาสินค้า: ${name}

    ${selector1}=    Set Variable    xpath=//h2[contains(@class,'font-semibold') and (normalize-space(.)='${name}' or @title='${name}')]/ancestor::div[contains(@class,'cursor-pointer')]
    ${selector2}=    Set Variable    xpath=//img[@alt='${name}']/ancestor::div[contains(@class,'cursor-pointer')]
    ${selector3}=    Set Variable    xpath=//h2[contains(@class,'font-semibold') and contains(normalize-space(.), '${name}')]/ancestor::div[contains(@class,'cursor-pointer')]
    ${selector4}=    Set Variable    xpath=//img[contains(@alt,'${name}')]/ancestor::div[contains(@class,'cursor-pointer')]

    Execute Javascript    window.scrollTo(0, 0)
    ${target}=    Set Variable    ${EMPTY}

    ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${selector1}
    IF    ${found}
        ${target}=    Set Variable    ${selector1}
        Safe Log    [DEBUG] เจอสินค้าด้วย selector1
    ELSE
        ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${selector2}
        IF    ${found}
            ${target}=    Set Variable    ${selector2}
            Safe Log    [DEBUG] เจอสินค้าด้วย selector2
        ELSE
            ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${selector3}
            IF    ${found}
                ${target}=    Set Variable    ${selector3}
                Safe Log    [DEBUG] เจอสินค้าด้วย selector3
            ELSE
                ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${selector4}
                IF    ${found}
                    ${target}=    Set Variable    ${selector4}
                    Safe Log    [DEBUG] เจอสินค้าด้วย selector4
                END
            END
        END
    END

    IF    $target == ""
        Safe Log    [DEBUG] ไม่เจอสินค้า กำลังเลื่อนหน้าจอ
        FOR    ${i}    IN RANGE    0    3
            Execute Javascript    window.scrollBy(0, document.body.clientHeight/2)
            Sleep    0.3s
            ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${selector1}
            IF    ${found}
                ${target}=    Set Variable    ${selector1}
                Safe Log    [DEBUG] เจอสินค้าหลังเลื่อนด้วย selector1
                Exit For Loop
            END
        END
    END

    Run Keyword If    $target == ""    Fail    ไม่พบสินค้า: ${name}

    Safe Log    [DEBUG] คลิกสินค้า: ${target}
    Wait Until Element Is Visible    ${target}    ${TIMEOUT}
    Scroll Element Into View    ${target}
    Sleep    0.2s
    ${clicked}=    Run Keyword And Return Status    Click Element    ${target}
    Safe Log    [DEBUG] ผลการคลิก: ${clicked}
    IF    not ${clicked}
        ${el}=    Get WebElement    ${target}
        Execute Javascript    arguments[0].click();    ARGUMENTS    ${el}
    END

    ${el}=    Get WebElement    ${target}
    ${js_clicked}=    Execute Javascript    var root=arguments[0];var p=root.querySelector('path[d^="M528.12"]');if(p){var b=p.closest('button');if(b){b.click();return true;}}return false;    ARGUMENTS    ${el}
    Safe Log    [DEBUG] ผลการคลิก cart icon: ${js_clicked}
    IF    not ${js_clicked}
        Execute Javascript    var root=arguments[0];var btns=root.querySelectorAll('button');if(btns&&btns.length){btns[btns.length-1].click();}    ARGUMENTS    ${el}
    END

    ${icon_visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${BTN_CART_ICON}    1s
    IF    ${icon_visible}
        Click Element    ${BTN_CART_ICON}
    END
    Safe Log    [DEBUG] เสร็จสิ้นการเพิ่มสินค้าในตะกร้า

Filter Product By Name
    [Arguments]    ${name}
    ${found1}=    Run Keyword And Return Status    Page Should Contain Element    ${SEARCH_INPUT_OPT1}
    ${found2}=    Run Keyword And Return Status    Page Should Contain Element    ${SEARCH_INPUT_OPT2}
    IF    ${found1}
        ${inp}=    Set Variable    ${SEARCH_INPUT_OPT1}
    ELSE IF    ${found2}
        ${inp}=    Set Variable    ${SEARCH_INPUT_OPT2}
    ELSE
        Fail    ไม่พบช่องค้นหา
    END
    Wait Until Element Is Visible    ${inp}    5s
    Clear Element Text    ${inp}
    Input Text    ${inp}    ${name}
    Sleep    0.4s

Try Filter Product By Name
    [Arguments]    ${name}
    ${has1}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${SEARCH_INPUT_OPT1}    1s
    ${has2}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${SEARCH_INPUT_OPT2}    1s
    IF    ${has1}
        ${inp}=    Set Variable    ${SEARCH_INPUT_OPT1}
        Wait Until Element Is Visible    ${inp}    5s
        Clear Element Text    ${inp}
        Input Text    ${inp}    ${name}
        Sleep    0.4s
    ELSE IF    ${has2}
        ${inp}=    Set Variable    ${SEARCH_INPUT_OPT2}
        Wait Until Element Is Visible    ${inp}    5s
        Clear Element Text    ${inp}
        Input Text    ${inp}    ${name}
        Sleep    0.4s
    ELSE
        Safe Log    [OrderSell] ไม่มีช่องค้นหา ข้ามการกรองชื่อสินค้า: ${name}
    END
