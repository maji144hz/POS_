*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
# ===== Category Management =====
Login And Go To Category Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Navigate To Management Menu
    Click Element    xpath=//a[contains(text(),'ประเภทสินค้า')]
    Wait Until Element Is Visible    ${CATEGORY_BTN_ADD}

Create Category
    [Arguments]    ${name}
    Click Element    ${CATEGORY_BTN_ADD}
    Wait Until Element Is Visible    ${CATEGORY_INPUT_NAME}
    Clear Element Text    ${CATEGORY_INPUT_NAME}
    Input Text            ${CATEGORY_INPUT_NAME}    ${name}
    Click Element         ${CATEGORY_BTN_SAVE}
    Click If Exists       css=button.swal2-confirm
    Wait Until Element Is Not Visible    ${CATEGORY_INPUT_NAME}    ${TIMEOUT}

Search Category By Name
    [Arguments]    ${name}
    Wait Until Element Is Visible    ${CATEGORY_INPUT_SEARCH}    ${TIMEOUT}
    Clear Element Text    ${CATEGORY_INPUT_SEARCH}
    Input Text            ${CATEGORY_INPUT_SEARCH}    ${name}
    Press Keys            ${CATEGORY_INPUT_SEARCH}    ENTER
    Wait Until Page Contains    ${name}    ${TIMEOUT}

Screenshot Latest Category Row
    [Arguments]    ${name}
    ${ROW}=    Set Variable    xpath=(//tr[.//*[self::td or self::span or self::div][contains(normalize-space(.),"${name}")]])[1]
    Wait Until Element Is Visible    ${ROW}    ${TIMEOUT}
    Scroll Element Into View         ${ROW}
    Create Directory If Not Exists    ${SCREEN_DIR}
    Capture Element Screenshot    ${ROW}    ${SCREEN_DIR}${/}latest_category.png

# ===== Edit =====
Click Category Edit Button
    Wait Until Page Contains Element    xpath=//button[starts-with(@id,'edit-category-button-')]    ${TIMEOUT}
    Scroll Element Into View            xpath=//button[starts-with(@id,'edit-category-button-')]
    Click Element                       xpath=//button[starts-with(@id,'edit-category-button-')]
    Wait Table Idle

# ===== Delete =====
Click Category Delete Button
    Wait Until Page Contains Element    xpath=//button[starts-with(@id,'delete-category-button-')]    ${TIMEOUT}
    Scroll Element Into View            xpath=//button[starts-with(@id,'delete-category-button-')]
    Click Element                       xpath=//button[starts-with(@id,'delete-category-button-')]
    Wait Table Idle

Confirm Delete Dialog
    ${ok}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${SWAL_CONFIRM}    5s
    Run Keyword If    ${ok}    Click Element    ${SWAL_CONFIRM}
    ${ok2}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//button[normalize-space()='ยืนยัน' or normalize-space()='ตกลง' or normalize-space()='OK']    3s
    Run Keyword If    ${ok2}   Click Element    xpath=//button[normalize-space()='ยืนยัน' or normalize-space()='ตกลง' or normalize-space()='OK']
    Wait Table Idle

Verify Category Not Exists
    [Arguments]    ${name}
    Wait Until Page Does Not Contain    ${name}    ${TIMEOUT}