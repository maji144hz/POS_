*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    random

*** Keywords ***
# ===== Category Edit Management =====
Login And Go To Category Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Navigate To Management Menu
    Click Element    xpath=//a[contains(text(),'ประเภทสินค้า')]
    Wait Until Element Is Visible    ${BTN_ADD_CATEGORY}    ${TIMEOUT}

# ===== Create =====
Create Category
    [Arguments]    ${name}
    Click Element                      ${BTN_ADD_CATEGORY}
    Wait Until Element Is Visible      ${CREATE_INPUT}    ${TIMEOUT}
    Clear Element Text                 ${CREATE_INPUT}
    Input Text                         ${CREATE_INPUT}    ${name}
    Click Element                      ${BTN_SAVE_CREATE}
    Click If Exists                    ${SWAL_CONFIRM}
    Wait Until Element Is Not Visible  ${CREATE_INPUT}    ${TIMEOUT}

# ===== Search =====
Search Category By Name
    [Arguments]    ${name}
    Wait Until Element Is Visible    ${SEARCH_CATEGORY}    ${TIMEOUT}
    Press Keys                       ${SEARCH_CATEGORY}    CTRL+A
    Press Keys                       ${SEARCH_CATEGORY}    BACKSPACE
    Input Text                       ${SEARCH_CATEGORY}    ${name}
    Press Keys                       ${SEARCH_CATEGORY}    ENTER
    Wait Table Idle
    Wait Until Page Contains         ${name}    ${TIMEOUT}

# ===== Edit =====
Click Edit Category Button
    Wait Until Page Contains Element    ${BTN_EDIT_SINGLE}    ${TIMEOUT}
    Scroll Element Into View            ${BTN_EDIT_SINGLE}
    ${clicked}=    Run Keyword And Return Status    Click Element    ${BTN_EDIT_SINGLE}
    Run Keyword If    not ${clicked}    ${el}=    Get WebElement    ${BTN_EDIT_SINGLE}

Fill Edit Dialog And Save
    [Arguments]    ${new_name}
    Wait Until Element Is Visible      ${EDIT_INPUT}    ${TIMEOUT}
    Clear Element Text                 ${EDIT_INPUT}
    Input Text                         ${EDIT_INPUT}    ${new_name}
    Click Element                      ${BTN_SAVE_EDIT}
    Click If Exists                    ${SWAL_CONFIRM}
    Wait Until Element Is Not Visible  ${EDIT_INPUT}    ${TIMEOUT}

Screenshot Row Containing Text
    [Arguments]    ${text}    ${filename}
    ${ROW}=    Set Variable    xpath=(//tr[.//*[self::td or self::span or self::div][contains(normalize-space(.),"${text}")]])[1]
    Wait Until Element Is Visible    ${ROW}    ${TIMEOUT}
    Scroll Element Into View         ${ROW}
    Create Directory If Not Exists    ${SCREEN_DIR}
    Capture Element Screenshot    ${ROW}    ${SCREEN_DIR}${/}${filename}

# ===== Delete =====
Click Delete Button
    Wait Until Page Contains Element    ${BTN_DELETE_SINGLE}    ${TIMEOUT}
    Scroll Element Into View            ${BTN_DELETE_SINGLE}
    Click Element                       ${BTN_DELETE_SINGLE}
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