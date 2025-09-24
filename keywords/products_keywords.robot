*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
# ===== Products Login & Navigation =====
Login Using Resource
    Go To Login Page
    Input Username     ${VALID_USER}
    Input Password     ${VALID_PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open
    Sleep    0.2s

Go To Login Page
    Go To    ${BASE_URL}/
    Wait Until Page Contains Element    css=input[name='username']
    Wait Until Page Contains Element    css=input[name='password']
    Wait Until Page Contains Element    css=button[type='submit']

Input Username
    [Arguments]    ${username}
    Wait Until Element Is Visible    css=input[name='username']
    Input Text    css=input[name='username']    ${username}

Input Password
    [Arguments]    ${password}
    Wait Until Element Is Visible    css=input[name='password']
    Input Text    css=input[name='password']    ${password}

Submit Credentials
    Wait Until Element Is Visible    css=button[type='submit']
    Click Button    css=button[type='submit']

Welcome Page Should Be Open
    Sleep    2s
    Wait Until Page Contains Element    xpath=//span[contains(text(),'จัดการ')]    ${TIMEOUT}
    Wait Until Page Contains Element    xpath=//span[contains(text(),'ตั้งค่า')]    ${TIMEOUT}

# ===== Products Management =====
Type
    [Arguments]    ${locator}    ${text}
    Should Not Be Empty    ${locator}    
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Clear Element Text               ${locator}
    Input Text    locator=${locator}    text=${text}

Get First Present Locator
    [Arguments]    @{locators}
    FOR    ${loc}    IN    @{locators}
        ${ok}=    Run Keyword And Return Status    Page Should Contain Element    ${loc}
        IF    ${ok}    RETURN    ${loc}
    END
    Fail    ไม่พบ input[type=file] สำหรับอัปโหลดรูปสินค้า

Ensure On Create Product Page
    ${loc}=         Get Location
    ${on_create}=   Run Keyword And Return Status    Should Contain    ${loc}    /products/create-product
    IF    not ${on_create}
        Go To    ${CREATE_URL}
        Wait Table Idle
    END

Upload Product Image
    [Arguments]    ${filepath}
    Wait Until Element Is Visible       ${UPLOAD_CLICK_AREA}    ${TIMEOUT}
    Scroll Element Into View            ${UPLOAD_CLICK_AREA}
    Click Element                       ${UPLOAD_CLICK_AREA}
    Sleep    0.3s
    ${file_input}=    Get First Present Locator    ${INPUT_FILE_OPT1}    ${INPUT_FILE_OPT2}
    Run Keyword And Ignore Error    Execute Javascript    arguments[0].style.display='block';    ${file_input}
    Run Keyword And Ignore Error    Execute Javascript    arguments[0].removeAttribute('hidden');    ${file_input}
    Choose File    ${file_input}    ${filepath}
    Wait Table Idle
    Sleep    0.5s

Click Save Product
    ${clicked}=    Run Keyword And Return Status    Click Element    ${BTN_SAVE_OPT1}
    Run Keyword If    ${clicked}    RETURN From Keyword
    ${has2}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${BTN_SAVE_OPT2}    2s
    Run Keyword If    ${has2}    Click Element    ${BTN_SAVE_OPT2}
    Run Keyword If    ${has2}    RETURN From Keyword
    ${has3}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${BTN_SAVE_OPT3}    2s
    Run Keyword If    ${has3}    Click Element    ${BTN_SAVE_OPT3}
    Run Keyword If    ${has3}    RETURN From Keyword
    Fail    ไม่พบปุ่มบันทึกสินค้า

# หา card สินค้าจากชื่อ โดยรองรับทั้ง h2@title, h2 text, และ img@alt
Get Product Card Locator By Name
    [Arguments]    ${name}
    ${card}=    Set Variable    xpath=(//div[contains(@class,'cursor-pointer')][descendant::h2[contains(@title,'${name}')] or descendant::h2[contains(normalize-space(.),'${name}')] or descendant::img[contains(@alt,'${name}')]])[1]
    RETURN    ${card}

# คลิกการ์ด -> ถ้า modal/แถบรายละเอียดมีปุ่มให้กดก็คลิก, ถ้าไม่มีให้ลองปุ่ม +, ถ้าไม่มีอีกแปลว่า UI เพิ่มลงตะกร้าเมื่อคลิกการ์ดแล้ว
Add Product To Cart By Name
    [Arguments]    ${name}
    ${card}=    Get Product Card Locator By Name    ${name}
    Wait Until Page Contains Element    ${card}    10s
    Scroll Element Into View             ${card}
    Wait Until Element Is Visible        ${card}    10s
    Click Element                        ${card}

    # รอ UI โผล่หลังคลิก (modal/side panel)
    Sleep    0.3s

    # ปุ่ม "เพิ่ม"/"Add"/aria-label/คลาส
    ${add_btn}=    Set Variable    xpath=//button[contains(.,'เพิ่ม') or contains(.,'Add') or contains(@aria-label,'เพิ่ม') or contains(@class,'add')]
    ${has_add}=    Run Keyword And Return Status    Page Should Contain Element    ${add_btn}    0.5s
    Run Keyword If    ${has_add}    Wait And Click    ${add_btn}

    # ถ้าไม่เจอปุ่ม "เพิ่ม" ให้ลองปุ่ม + (ถ้ามี)
    ${plus_btn}=    Set Variable    xpath=//button[contains(normalize-space(.),'+') or contains(@aria-label,'เพิ่ม')]
    ${has_plus}=    Run Keyword And Return Status    Page Should Contain Element    ${plus_btn}    0.5s
    Run Keyword If    not ${has_add} and ${has_plus}    Wait And Click    ${plus_btn}

    # เคสบางระบบ "คลิกการ์ด = ใส่ตะกร้าแล้ว" ไม่มีปุ่มให้กดต่อ → ไม่ต้องทำอะไรเพิ่ม
    Log    Product added to cart (or system auto-added when card was clicked)

# คีย์เวิร์ดกรองชื่อแบบทน input หลายแบบ: placeholder ไทย/อังกฤษ + กด Enter
Try Filter Product By Name
    [Arguments]    ${name}
    ${input}=    Set Variable    xpath=//input[@type='search' or contains(@placeholder,'ค้นหา') or contains(@placeholder,'Search')]
    Wait Until Page Contains Element     ${input}    10s
    Clear Element Text                   ${input}
    Input Text                           ${input}    ${name}
    Press Keys                           ${input}    ENTER
    Sleep                                0.5s