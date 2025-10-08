*** Settings ***
Resource          ../../variables/login_variables.robot
Resource          ../../keywords/login_keywords.robot
Resource          ../../keywords/common_keywords.robot
Documentation     ชุดทดสอบเข้าสู่ระบบ: positive/negative ด้วย LOGIN_* aliases
Metadata          owner    qa
Metadata          component    login
Force Tags        regression    login
Default Tags      ui

*** Test Cases ***
TC001 - ล็อกอินสำเร็จ
    Initialize Test Logging
    Open Browser To Login Page
    Log Step And Screenshot    เปิดหน้า Login
    Input Username    perth1
    Input Password    1234
    Submit Credentials
    Welcome Page Should Be Open
    Log Step And Screenshot    เข้าสู่ระบบสำเร็จ
    [Teardown]    Run Keywords    Log Step And Screenshot    ปิดเบราว์เซอร์    AND    End Test Logging    AND    Close Browser

TC002 - ล็อกอินไม่สำเร็จ (ชุดกรณีทดสอบด้วย Template)
    [Documentation]    ตัวอย่างการใช้ Test Template เพื่อทดสอบหลายกรณี
    [Setup]    Run Keywords    Initialize Test Logging    AND    Open Browser To Login Page    AND    Log Step And Screenshot    เปิดหน้า Login
    [Template]    Login With Invalid Credentials Should Fail
    Invalid Username                 perth1          ${VALID_PASSWORD}
    Invalid Password                 ${VALID_USER}    122
    Invalid Username And Password    invalid          whatever
    Empty Username                   ${EMPTY}         ${VALID_PASSWORD}
    Empty Password                   ${VALID_USER}    ${EMPTY}
    Empty Username And Password      ${EMPTY}         ${EMPTY}
    [Teardown]    Run Keywords    Log Step And Screenshot    จบชุด Template    AND    End Test Logging    AND    Close Browser

