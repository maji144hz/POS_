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
เพิ่มสินค้าแบบกดยกเลิกแทนตกลง TC1008
    Create Directory                     ${SCREEN_DIR}
    Go To                               ${PRODUCT_LIST_URL}
    Wait Until Element Is Visible        ${BTN_ADD_PRODUCT}    ${TIMEOUT}
    Click Element                        ${BTN_ADD_PRODUCT}
    Wait Table Idle

    Ensure On Create Product Page
    Upload Product Image                 ${PRODUCT_IMAGE_PATH}

    Type    ${INPUT_NAME}                     น้ำยาล้างจาน
    Type    ${INPUT_DESC}                     น้ำยาล้างจานของดี
    Wait Until Element Is Visible             ${SELECT_CATEGORY}    ${TIMEOUT}
    Select From List By Value                 ${SELECT_CATEGORY}    ${CATEGORY_VALUE}

    Type    ${INPUT_BARCODE_PACK}             0150758695519
    Type    ${INPUT_BARCODE_UNIT}             0646818912454
    Type    ${INPUT_PACK_SIZE}                12
    Type    ${INPUT_PRICE_UNIT}               10
    Type    ${INPUT_PRICE_PACK}               120
    Type    ${INPUT_INIT_QTY}                 120
    Type    ${INPUT_INIT_PURCHASE}            6
    Type    ${INPUT_INIT_EXPDATE}             ${EXPDATE_VALUE}

    Click Save Product
    Click If Exists                      ${BTN_CANCEL_PRODUCT}
    Wait Table Idle
