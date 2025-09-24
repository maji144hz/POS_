*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers
Test Setup        Login Using Resource

Resource          ../variables/common_variables.robot
Resource          ../variables/variables.robot
Resource          ../keywords/common_keywords.robot
Resource          ../keywords/products_keywords.robot

*** Test Cases ***
เพิ่มสินค้าแบบกรอกแค่รูปชื่อกับรายละเอียดสินค้า TC1004
    Create Directory                     ${SCREEN_DIR}
    Go To                               ${PRODUCT_LIST_URL}
    Wait Until Element Is Visible        ${BTN_ADD_PRODUCT}    ${TIMEOUT}
    Click Element                        ${BTN_ADD_PRODUCT}
    Wait Table Idle

    Ensure On Create Product Page
    Upload Product Image                 ${PRODUCT_IMAGE_PATH}

    Type    ${INPUT_NAME}                     น้ำยาล้างจาน
    Type    ${INPUT_DESC}                     น้ำยาล้างจานของดี

    Click Save Product
    Click If Exists                      ${SWAL_CONFIRM}
    Wait Table Idle
