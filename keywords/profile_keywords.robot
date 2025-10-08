*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
# ===== Profile Management =====
Login And Go To Profile Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Navigate To Profile Menu
    Wait Until Element Is Visible    ${PROFILE_BTN_EDIT}

Login And Go To Profile
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Navigate To Profile Menu
    Wait Until Element Is Visible    ${PROFILE_BTN_EDIT}

Edit Profile Information
    [Arguments]    ${name}    ${email}    ${phone}
    Click Element    ${PROFILE_BTN_EDIT}
    Wait Until Element Is Visible    ${PROFILE_INPUT_NAME}
    
    Clear Element Text    ${PROFILE_INPUT_NAME}
    Input Text            ${PROFILE_INPUT_NAME}    ${name}
    
    Clear Element Text    ${PROFILE_INPUT_EMAIL}
    Input Text            ${PROFILE_INPUT_EMAIL}    ${email}
    
    Clear Element Text    ${PROFILE_INPUT_PHONE}
    Input Text            ${PROFILE_INPUT_PHONE}    ${phone}
    
    Click Element         ${PROFILE_BTN_SAVE}
    Click If Exists       css=button.swal2-confirm
    Wait Until Element Is Not Visible    ${PROFILE_INPUT_NAME}    ${TIMEOUT}

Change Profile Avatar
    [Arguments]    ${image_path}
    Click Element    ${PROFILE_BTN_CHANGE_AVATAR}
    Wait Until Element Is Visible    xpath=//input[@type='file']
    Choose File    xpath=//input[@type='file']    ${image_path}
    Click If Exists       css=button.swal2-confirm
    Wait Until Element Is Not Visible    xpath=//input[@type='file']    ${TIMEOUT}

Upload Avatar From Path
    [Arguments]    ${image_path}
    Wait Until Element Is Visible    xpath=//input[@type='file']    ${TIMEOUT}
    Choose File    xpath=//input[@type='file']    ${image_path}
    Wait Table Idle