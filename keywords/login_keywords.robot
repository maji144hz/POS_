*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
# ===== Login Management =====
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    POSSIBLE

Go To Login Page
    Go To    ${LOGIN_URL}
    Login Page Should Be Open

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
    Location Should Be    ${WELCOME_URL}
    Title Should Be    POSSIBLE

Login Should Have Failed
    Location Should Be    ${ERROR_URL}
    Title Should Be    POSSIBLE
    Page Should Contain    ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง
