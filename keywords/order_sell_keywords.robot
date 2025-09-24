*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BTN_CHECKOUT}        xpath=//button[contains(@class,'bg-green-500')][contains(., 'ชำระเงิน')]
${BTN_CHECKOUT_SPECIFIC}    xpath=//button[@class='px-6 py-3 text-white bg-green-500 rounded-xl font-medium hover:bg-green-600 transition-colors'][contains(., 'ชำระเงิน')]
${BTN_PAYMENT_CASH}    xpath=//button[.//h3[contains(normalize-space(.), 'เงินสด')]]
${BTN_PAYMENT_QR}      xpath=//button[.//h3[contains(normalize-space(.), 'QR Code')]]
${BTN_PAYMENT_BANK}    xpath=//button[.//h3[contains(normalize-space(.), 'โอนเงินผ่านธนาคาร')]]
${BTN_CONFIRM_PAY}     xpath=//button[contains(., 'ยืนยันการชำระเงิน')]
${SUCCESS_TEXT}        สร้างคำสั่งซื้อสำเร็จ
${BTN_CART_ICON}       xpath=//path[@d='M528.12 301.319l47.273-208C578.806 78.301 567.391 64 551.99 64H159.208l-9.166-44.81C147.758 8.021 137.93 0 126.529 0H24C10.745 0 0 10.745 0 24v16c0 13.255 10.745 24 24 24h69.883l70.248 343.435C147.325 417.1 136 435.222 136 456c0 30.928 25.072 56 56 56s56-25.072 56-56c0-15.674-6.447-29.835-16.824-40h209.647C430.447 426.165 424 440.326 424 456c0 30.928 25.072 56 56 56s56-25.072 56-56c0-22.172-12.888-41.332-31.579-50.405l5.517-24.276c3.413-15.018-8.002-29.319-23.403-29.319H218.117l-6.545-32h293.145c11.206 0 20.92-7.754 23.403-18.681z']/ancestor::button[1]
${BTN_OPEN_CART_ID}    css=button#open-cart-btn
${BTN_OPEN_CART_ICON}  xpath=//button[.//path[starts-with(@d,'M528.12')]]
${BTN_CHECKOUT_ALT1}   xpath=//a[contains(., 'ชำระเงิน')]
${BTN_CHECKOUT_ALT2}   xpath=//button[contains(@class,'bg-green-500')][contains(@class,'rounded-xl')][contains(., 'ชำระเงิน')]
${BTN_CHECKOUT_ALT3}   xpath=//*[self::a or self::button][contains(normalize-space(.), 'ชำระเงิน')]
${OPEN_CART_DATA_TIP}  css=button[data-tip='สร้างคำสั่งซื้อ']
${CART_DRAWER_HINT}    xpath=//*[contains(@class,'cart') or contains(@class,'drawer') or contains(@class,'offcanvas') or @role='dialog']
${CART_HEADING}        xpath=//h2[normalize-space()='ตะกร้าสินค้า']
${SEARCH_INPUT_OPT1}   xpath=//input[@type='search']
${SEARCH_INPUT_OPT2}   xpath=//input[contains(@placeholder,'ค้นหา') or contains(@placeholder,'Search')]

*** Keywords ***
Go To Order Sell Page
    Go To    ${BASE_URL}/order-sell
    Wait Until Page Contains Element    ${BTN_CHECKOUT}    ${TIMEOUT}

Ensure On Order Sell Page
    # รอหัวข้อ/องค์ประกอบหลักใดอย่างใดอย่างหนึ่ง เพื่อยืนยันว่าอยู่หน้า "ขายสินค้า"
    ${ok1}=    Run Keyword And Return Status    Wait Until Page Contains    ขายสินค้า    3s
    ${ok2}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//input[@type='search' or contains(@placeholder,'ค้นหา') or contains(@placeholder,'Search')]    3s
    ${ok}=    Evaluate    ${ok1} or ${ok2}
    Run Keyword If    not ${ok}    Fail    ไม่พบ element จากตัวเลือกที่ระบุในหน้าออเดอร์ขาย

Open Order Sell From Menu
    ${menu}=    Set Variable    xpath=//span[contains(text(), 'ออเดอร์ขาย')]
    Wait Until Page Contains Element    ${menu}    ${TIMEOUT}
    Click Element    ${menu}
    ${link_opt1}=    Set Variable    css=a.p-2.text-gray-600[href='/order-sell/']
    ${link_opt2}=    Set Variable    css=a.p-2.text-gray-600[href='/order-sell']
    ${link}=    Get First Present Locator    ${link_opt1}    ${link_opt2}
    Wait Until Page Contains Element    ${link}    ${TIMEOUT}
    Click Element    ${link}
    # Optional floating add-order button
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
    ${target}=    Get First Present Locator    ${card_exact}    ${card_contains}    ${img_exact}    ${h2_exact}
    Wait Until Element Is Visible    ${target}    ${TIMEOUT}
    Scroll Element Into View    ${target}
    Sleep    0.2s
    ${clicked}=    Run Keyword And Return Status    Click Element    ${target}
    Run Keyword If    not ${clicked}    ${el}=    Get WebElement    ${target}
    Run Keyword If    not ${clicked}    Execute Javascript    arguments[0].click();    ${el}
    ${icon_visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${BTN_CART_ICON}    1s
    Run Keyword If    ${icon_visible}    Click Element    ${BTN_CART_ICON}

Click Numeric Key
    [Arguments]    ${digit}
    Click Element    xpath=//button[normalize-space(.)='${digit}']

Open Cart Floating Button
    # Try multiple methods to click the cart button
    ${clicked}=    Run Keyword And Return Status    Wait And Click    ${BTN_OPEN_CART_ID}
    Run Keyword If    not ${clicked}    ${clicked}=    Run Keyword And Return Status    Wait And Click    ${OPEN_CART_DATA_TIP}
    Run Keyword If    not ${clicked}    ${clicked}=    Run Keyword And Return Status    Wait And Click    ${BTN_OPEN_CART_ICON}
    # Last resort: Direct JS click by id
    Run Keyword If    not ${clicked}    Execute Javascript    var b=document.getElementById('open-cart-btn');if(b){b.click();return true;}return false;
    # Wait a moment for drawer/buttons
    Run Keyword And Ignore Error    Wait Until Page Contains Element    ${CART_DRAWER_HINT}    3s

Ensure Cart Open
    # Open and ensure the cart drawer with heading is visible
    Log    Opening cart...
    Open Cart Floating Button
    ${opened}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${CART_HEADING}    4s
    Log    Cart opened: ${opened}
    IF    not ${opened}
        Log    Retrying to open cart...
        Open Cart Floating Button
        Wait Until Page Contains Element    ${CART_HEADING}    ${TIMEOUT}
    END
    Log    Cart is now open

Proceed To Checkout
    # Open the cart explicitly and ensure it's open
    Ensure Cart Open
    # Click the specific "ชำระเงิน" button directly
    Click Element    xpath=//button[@class='px-6 py-3 text-white bg-green-500 rounded-xl font-medium hover:bg-green-600 transition-colors'][contains(.,'ชำระเงิน')]
    Wait Until Page Contains Element    ${BTN_PAYMENT_CASH}    ${TIMEOUT}

Confirm Payment And Expect Success
    Click Element    ${BTN_CONFIRM_PAY}
    Wait Until Page Contains    ${SUCCESS_TEXT}    ${TIMEOUT}
    Capture Page Screenshot    ${SCREEN_DIR}${/}order_cash_success.png
    Click If Exists    ${SWAL_CONFIRM}

Get First Present Locator
    [Arguments]    @{locators}
    FOR    ${loc}    IN    @{locators}
        ${ok}=    Run Keyword And Return Status    Page Should Contain Element    ${loc}
        IF    ${ok}    RETURN    ${loc}
    END
    Log    [OrderSell] ไม่พบ element จากตัวเลือก: ${locators}
    Run Keyword And Ignore Error    Capture Page Screenshot    ${SCREEN_DIR}${/}order_not_found.png
    Fail    ไม่พบ element จากตัวเลือกที่ระบุในหน้าออเดอร์ขาย

Add Product To Cart By Name
    [Arguments]    ${name}
    ${card_exact}=        Set Variable    xpath=//h2[(normalize-space(.)='${name}' or @title='${name}')]/ancestor::div[contains(@class,'rounded-2xl') or contains(@class,'cursor-pointer')]
    ${card_contains}=     Set Variable    xpath=//h2[(contains(normalize-space(.), '${name}') or contains(@title, '${name}'))]/ancestor::div[contains(@class,'rounded-2xl') or contains(@class,'cursor-pointer')]
    ${any_text_exact}=    Set Variable    xpath=//*[normalize-space(text())='${name}']/ancestor::div[contains(@class,'rounded-2xl') or contains(@class,'cursor-pointer')]
    ${any_text_contains}= Set Variable    xpath=//*[contains(normalize-space(text()),'${name}')]/ancestor::div[contains(@class,'rounded-2xl') or contains(@class,'cursor-pointer')]
    ${img_exact}=         Set Variable    xpath=//img[@alt='${name}']/ancestor::div[contains(@class,'rounded-2xl') or contains(@class,'cursor-pointer')]
    ${img_contains}=      Set Variable    xpath=//img[contains(@alt,'${name}')]/ancestor::div[contains(@class,'rounded-2xl') or contains(@class,'cursor-pointer')]
    ${h2_exact}=          Set Variable    xpath=//h2[(normalize-space(.)='${name}' or @title='${name}')]
    ${candidates}=    Create List    ${card_exact}    ${card_contains}    ${img_exact}    ${img_contains}    ${any_text_exact}    ${any_text_contains}    ${h2_exact}
    # Try to find by scrolling a few times (infinite list safeguard)
    Execute Javascript    window.scrollTo(0, 0)
    ${target}=    Run Keyword And Return Status    Page Should Contain Element    ${card_exact}
    IF    not ${target}
        FOR    ${i}    IN RANGE    0    5
            ${loc}=    Get First Present Locator    @{candidates}
            ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${loc}
            IF    ${found}
                ${target}=    Set Variable    ${loc}
                Exit For Loop
            END
            Execute Javascript    window.scrollBy(0, document.body.clientHeight/2)
            Sleep    0.3s
        END
    ELSE
        ${target}=    Set Variable    ${card_exact}
    END
    ${target}=    Set Variable If    '${target}'=='True'    ${card_exact}    ${target}
    ${target}=    Set Variable If    '${target}'=='False'    ${card_exact}    ${target}
    ${target}=    Run Keyword If    '${target}'=='${None}'    Get First Present Locator    @{candidates}
    Wait Until Element Is Visible    ${target}    ${TIMEOUT}
    Scroll Element Into View    ${target}
    Sleep    0.2s
    ${clicked}=    Run Keyword And Return Status    Click Element    ${target}
    Run Keyword If    not ${clicked}    ${el}=    Get WebElement    ${target}
    Run Keyword If    not ${clicked}    Execute Javascript    arguments[0].click();    ${el}
    # Try clicking cart icon inside the card via JS (path d starts with 'M528.12')
    ${el}=    Get WebElement    ${target}
    ${js_clicked}=    Execute Javascript    var root=arguments[0];var p=root.querySelector("path[d^='M528.12']");if(p){var b=p.closest('button');if(b){b.click();return true;}}return false;    ${el}
    Run Keyword If    not ${js_clicked}    Execute Javascript    var root=arguments[0];var btns=root.querySelectorAll('button');if(btns&&btns.length){btns[btns.length-1].click();}    ${el}
    ${icon_visible}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${BTN_CART_ICON}    1s
    Run Keyword If    ${icon_visible}    Click Element    ${BTN_CART_ICON}

Filter Product By Name
    [Arguments]    ${name}
    ${inp}=    Get First Present Locator    ${SEARCH_INPUT_OPT1}    ${SEARCH_INPUT_OPT2}
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
    ELSE IF    ${has2}
        ${inp}=    Set Variable    ${SEARCH_INPUT_OPT2}
    END
    Run Keyword If    ${has1} or ${has2}    Wait Until Element Is Visible    ${inp}    5s
    Run Keyword If    ${has1} or ${has2}    Clear Element Text    ${inp}
    Run Keyword If    ${has1} or ${has2}    Input Text    ${inp}    ${name}
    Run Keyword If    ${has1} or ${has2}    Sleep    0.4s
    Run Keyword If    not ${has1} and not ${has2}    Log    [OrderSell] ไม่มีช่องค้นหา ข้ามการกรองชื่อสินค้า: ${name}


