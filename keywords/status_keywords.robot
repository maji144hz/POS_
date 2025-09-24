*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
# ===== Status Management =====
Login And Go To Status Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Navigate To Management Menu
    Click Element    xpath=//a[contains(text(),'สถานะสินค้า')]
    Wait Until Element Is Visible    ${BTN_ADD_STATUS}

Create Status
    [Arguments]    ${name}
    Click Element    ${BTN_ADD_STATUS}
    Wait Until Element Is Visible    ${INPUT_STATUS}
    Clear Element Text    ${INPUT_STATUS}
    Input Text            ${INPUT_STATUS}    ${name}
    Click Element         ${BTN_SAVE_STATUS}
    Click If Exists       css=button.swal2-confirm
    Wait Until Element Is Not Visible    ${INPUT_STATUS}    ${TIMEOUT}

Search Status By Name
    [Arguments]    ${name}
    Wait Until Element Is Visible    ${SEARCH_STATUS}    ${TIMEOUT}
    Clear Element Text    ${SEARCH_STATUS}
    Input Text            ${SEARCH_STATUS}    ${name}
    Press Keys            ${SEARCH_STATUS}    ENTER
    Wait Table Idle
    Wait Until Page Contains    ${name}    ${TIMEOUT}

Screenshot Latest Status Row
    [Arguments]    ${name}
    ${ROW}=    Set Variable    xpath=(//tr[.//*[self::td or self::span or self::div][contains(normalize-space(.),"${name}")]])[1]
    Wait Until Element Is Visible    ${ROW}    ${TIMEOUT}
    Scroll Element Into View         ${ROW}
    Create Directory If Not Exists    ${SCREEN_DIR}
    Capture Element Screenshot    ${ROW}    ${SCREEN_DIR}${/}latest_status.png

Click Status Edit Button
    Wait Until Page Contains Element    ${BTN_EDIT_STATUS}    ${TIMEOUT}
    Scroll Element Into View            ${BTN_EDIT_STATUS}
    Click Element                       ${BTN_EDIT_STATUS}
    Wait Table Idle

Fill Status Edit And Save
    [Arguments]    ${new_name}
    Wait Until Element Is Visible       ${EDIT_INPUT_STATUS}    ${TIMEOUT}
    Clear Element Text                  ${EDIT_INPUT_STATUS}
    Input Text                          ${EDIT_INPUT_STATUS}    ${new_name}
    Click Element                       ${BTN_SAVE_EDIT_STATUS}
    Click If Exists                     ${SWAL_CONFIRM}
    Wait Until Element Is Not Visible   ${EDIT_INPUT_STATUS}    ${TIMEOUT}
    Wait Table Idle

Apply Status Search Filter
    [Arguments]    ${name}
    Wait Until Element Is Visible    ${SEARCH_STATUS}    ${TIMEOUT}
    Press Keys                       ${SEARCH_STATUS}    CTRL+A
    Press Keys                       ${SEARCH_STATUS}    BACKSPACE
    Input Text                       ${SEARCH_STATUS}    ${name}
    Press Keys                       ${SEARCH_STATUS}    ENTER
    Wait Table Idle

Click Delete Button
    Wait Until Page Contains Element    ${BTN_DELETE_STATUS}    ${TIMEOUT}
    Scroll Element Into View            ${BTN_DELETE_STATUS}
    Click Element                       ${BTN_DELETE_STATUS}
    Wait Table Idle

Confirm Delete Dialog
    ${ok}=    Run Keyword And Return Status    Wait Until Page Contains Element    ${SWAL_CONFIRM}    5s
    Run Keyword If    ${ok}    Click Element    ${SWAL_CONFIRM}
    ${ok2}=   Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//button[normalize-space()='ยืนยัน' or normalize-space()='ตกลง' or normalize-space()='OK']    3s
    Run Keyword If    ${ok2}   Click Element    xpath=//button[normalize-space()='ยืนยัน' or normalize-space()='ตกลง' or normalize-space()='OK']
    Wait Table Idle

Apply Search Filter
    [Arguments]    ${name}
    Wait Until Element Is Visible    ${SEARCH_STATUS}    ${TIMEOUT}
    Press Keys                       ${SEARCH_STATUS}    CTRL+A
    Press Keys                       ${SEARCH_STATUS}    BACKSPACE
    Input Text                       ${SEARCH_STATUS}    ${name}
    Press Keys                       ${SEARCH_STATUS}    ENTER
    Wait Table Idle

Verify Category Not Exists
    [Arguments]    ${name}
    Wait Until Page Does Not Contain    ${name}    ${TIMEOUT}
