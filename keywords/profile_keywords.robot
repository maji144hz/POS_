*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
# ===== Profile Management =====
Login And Go To Profile Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Navigate To Profile Menu
    Wait Until Element Is Visible    ${BTN_EDIT_PROFILE}

Edit Profile Information
    [Arguments]    ${name}    ${email}    ${phone}
    Click Element    ${BTN_EDIT_PROFILE}
    Wait Until Element Is Visible    ${INPUT_PROFILE_NAME}
    
    Clear Element Text    ${INPUT_PROFILE_NAME}
    Input Text            ${INPUT_PROFILE_NAME}    ${name}
    
    Clear Element Text    ${INPUT_PROFILE_EMAIL}
    Input Text            ${INPUT_PROFILE_EMAIL}    ${email}
    
    Clear Element Text    ${INPUT_PROFILE_PHONE}
    Input Text            ${INPUT_PROFILE_PHONE}    ${phone}
    
    Click Element         ${BTN_SAVE_PROFILE}
    Click If Exists       css=button.swal2-confirm
    Wait Until Element Is Not Visible    ${INPUT_PROFILE_NAME}    ${TIMEOUT}

Change Profile Avatar
    [Arguments]    ${image_path}
    Click Element    ${BTN_CHANGE_AVATAR}
    Wait Until Element Is Visible    xpath=//input[@type='file']
    Choose File    xpath=//input[@type='file']    ${image_path}
    Click If Exists       css=button.swal2-confirm
    Wait Until Element Is Not Visible    xpath=//input[@type='file']    ${TIMEOUT}
