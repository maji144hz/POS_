*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
# ===== Settings Management =====
Login And Go To Settings Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Navigate To Settings Menu
    Click Element    xpath=//a[contains(text(),'ข้อมูลร้าน')]
    Wait Until Element Is Visible    ${BTN_EDIT_SHOP}

Edit Shop Settings
    [Arguments]    ${name}    ${address}    ${phone}
    Click Element    ${BTN_EDIT_SHOP}
    Wait Until Element Is Visible    ${INPUT_SHOP_NAME}
    
    Clear Element Text    ${INPUT_SHOP_NAME}
    Input Text            ${INPUT_SHOP_NAME}    ${name}
    
    Clear Element Text    ${INPUT_SHOP_ADDRESS}
    Input Text            ${INPUT_SHOP_ADDRESS}    ${address}
    
    Clear Element Text    ${INPUT_SHOP_PHONE}
    Input Text            ${INPUT_SHOP_PHONE}    ${phone}
    
    Click Element         ${BTN_SAVE_SHOP}
    Click If Exists       css=button.swal2-confirm
    Wait Until Element Is Not Visible    ${INPUT_SHOP_NAME}    ${TIMEOUT}
