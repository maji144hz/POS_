*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections

*** Keywords ***
# ===== Main Browser & Login =====
Open Browser To Login Page
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Set Selenium Timeout    20 seconds
    Login Page Should Be Open

Login Page Should Be Open
    Wait Until Page Contains Element    xpath=//input[@name='username']
    Wait Until Page Contains Element    xpath=//input[@name='password']
    Wait Until Page Contains Element    xpath=//button[contains(text(), 'เข้าสู่ระบบ')]

Input Username
    [Arguments]    ${username}
    Wait Until Element Is Visible    xpath=//input[@name='username']
    Input Text    xpath=//input[@name='username']    ${username}

Input Password
    [Arguments]    ${password}
    Wait Until Element Is Visible    xpath=//input[@name='password']
    Input Text    xpath=//input[@name='password']    ${password}

Submit Credentials
    Wait Until Element Is Visible    xpath=//button[contains(text(), 'เข้าสู่ระบบ')]
    Click Button    xpath=//button[contains(text(), 'เข้าสู่ระบบ')]

Generate Random String
    ${random}=    Generate Random String    8    [LETTERS][NUMBERS]
    Set Suite Variable    ${RANDOM_STRING}    ${random}
