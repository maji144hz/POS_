*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections


*** Variables ***
# --- Base Configuration ---
${BASE_URL}           http://localhost:5173
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SHORT_TIMEOUT}      5s
${LONG_TIMEOUT}       30s

# --- Dirs ---
${SCREEN_DIR}         screenshots

# --- Common Locators ---
${SPINNERS}           css=.ant-spin,.loading,.v-overlay--active,.swal2-container
${SWAL_CONFIRM}       css=button.swal2-confirm

# --- Misc ---
${HEADLESS}           false

*** Keywords ***
Safe Log
    [Arguments]    @{items}
    Log    Safe Log


# ===== Browser & Login =====
Test Setup Sequence
    Open Browser To Login Page
    Initialize Test Logging
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}

Test Teardown Sequence
    End Test Logging
    Close All Browsers

Open Browser To Login Page
    # สร้าง ChromeOptions แล้วใส่ arguments ตามต้องการ
    ${options}=    Evaluate    __import__('selenium.webdriver').webdriver.ChromeOptions()
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-gcm-driver
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    # ถ้าอยาก headless ให้ uncomment บรรทัดถัดไป
    # Call Method    ${options}    add_argument    --headless=new

    Open Browser    ${BASE_URL}    chrome    options=${options}
    Set Window Size    1400    900
    Set Selenium Timeout    ${TIMEOUT}


Login With Credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    css=input[name='username']
    Input Text    css=input[name='username']    ${username}
    Input Text    css=input[name='password']    ${password}
    Click Button   css=button[type='submit']
    Wait Table Idle

Navigate To Management Menu
    Wait Until Element Is Visible    xpath=//span[contains(text(),'จัดการ')]    ${TIMEOUT}
    Click Element    xpath=//span[contains(text(),'จัดการ')]
    Wait Table Idle

Navigate To Profile Menu
    Wait Until Element Is Visible    xpath=//span[contains(text(),'ตั้งค่า')]    ${TIMEOUT}
    Click Element    xpath=//span[contains(text(),'ตั้งค่า')]
    Wait Table Idle

# ===== Common Utils =====
Wait Table Idle
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    ${SPINNERS}    5s
    Sleep    0.3s

Click If Exists
    [Arguments]    ${locator}
    ${ok}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    2s
    Run Keyword If    ${ok}    Click Element    ${locator}

Generate Random Number
    [Arguments]    ${min}=1000    ${max}=9999
    ${random}=    Evaluate    random.randint(${min}, ${max})    random
    RETURN    ${random}

Create Directory If Not Exists
    [Arguments]    ${directory}
    Run Keyword And Ignore Error    Create Directory    ${directory}

# คลิกแบบทน: เลื่อนให้เห็น/รอ enabled -> Click ธรรมดา -> ถ้า fail ใช้ JS click
Wait And Click
    [Arguments]    ${locator}
    Safe Log    Trying to click: ${locator}
    Run Keyword And Ignore Error    Scroll Element Into View    ${locator}
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${locator}    5s
    Run Keyword And Ignore Error    Wait Until Element Is Enabled    ${locator}    5s
    ${clicked}=    Run Keyword And Return Status    Click Element    ${locator}
    Safe Log    Normal click result: ${clicked}
    IF    not ${clicked}
        JS Click    ${locator}
    END
    IF    not ${clicked}
        Safe Log    Both normal and JS click failed for: ${locator}
    END

# JS click แบบปลอดภัย
JS Click
    [Arguments]    ${locator}
    ${el}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ${el}

# ===== Logging & Screenshots =====
Initialize Test Logging
    ${suite}=    Set Variable    ${SUITE NAME}
    ${test}=     Set Variable    ${TEST NAME}
    ${suite_sanit}=    Replace String    ${suite}    ${SPACE}    _
    ${test_sanit}=     Replace String    ${test}     ${SPACE}    _
    ${dir}=      Set Variable    ${SCREEN_DIR}${/}${suite_sanit}${/}${test_sanit}
    Create Directory If Not Exists    ${dir}
    Set Test Variable    ${TEST_ARTIFACT_DIR}    ${dir}
    Safe Log    Initialized artifacts at: ${dir}

Log Step And Screenshot
    [Arguments]    ${message}    ${filename}=step
    ${rand}=    Generate Random Number    1000    9999
    Safe Log    ${message}
    Run Keyword And Ignore Error    Capture Page Screenshot    ${TEST_ARTIFACT_DIR}${/}${filename}_${rand}.png

End Test Logging
    ${rand}=    Generate Random Number    1000    9999
    Run Keyword And Ignore Error    Capture Page Screenshot    ${TEST_ARTIFACT_DIR}${/}final_${rand}.png
    Safe Log    Completed test: ${TEST NAME}
