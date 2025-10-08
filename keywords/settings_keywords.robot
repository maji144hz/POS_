*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
# ===== Settings Management =====
Login And Go To Settings Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Navigate To Settings Menu
    Click Element    xpath=//a[contains(text(),'ข้อมูลร้าน')]
    Wait Until Element Is Visible    ${SETTINGS_BTN_EDIT_SHOP}

Edit Shop Settings
    [Arguments]    ${name}    ${address}    ${phone}
    Click Element    ${SETTINGS_BTN_EDIT_SHOP}
    Wait Until Element Is Visible    ${SETTINGS_INPUT_SHOP_NAME}
    
    Clear Element Text    ${SETTINGS_INPUT_SHOP_NAME}
    Input Text            ${SETTINGS_INPUT_SHOP_NAME}    ${name}
    
    Clear Element Text    ${SETTINGS_INPUT_SHOP_ADDRESS}
    Input Text            ${SETTINGS_INPUT_SHOP_ADDRESS}    ${address}
    
    Clear Element Text    ${SETTINGS_INPUT_SHOP_PHONE}
    Input Text            ${SETTINGS_INPUT_SHOP_PHONE}    ${phone}
    
    Click Element         ${SETTINGS_BTN_SAVE_SHOP}
    Click If Exists       css=button.swal2-confirm
    Wait Until Element Is Not Visible    ${SETTINGS_INPUT_SHOP_NAME}    ${TIMEOUT}
