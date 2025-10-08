*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Documentation     ชุดทดสอบสินค้า: สร้าง/แก้ไข/ยกเลิก/ตรวจสอบ ด้วย PRODUCT_* locators
Metadata          owner    qa
Metadata          component    products
Force Tags        regression    products
Default Tags      ui

Suite Setup       NONE
Suite Teardown    NONE
Test Setup        Run Keywords    Open Browser To Login Page    AND    Initialize Test Logging    AND    Login Using Resource
Test Teardown     Run Keywords    End Test Logging    AND    Close All Browsers

Resource          ../../variables/common_variables.robot
Resource          ../../variables/variables.robot
Resource          ../../keywords/common_keywords.robot
Resource          ../../keywords/products_keywords.robot

*** Test Cases ***
TC001 - เพิ่มสินค้าแบบไม่กรอกล็อตกับวันหมดอายุ
    Log Step And Screenshot              เริ่มต้น TC001
    Go To                               ${PRODUCT_LIST_URL_P}
    Wait Until Element Is Visible        ${PRODUCT_BTN_ADD}    ${TIMEOUT}
    Click Element                        ${PRODUCT_BTN_ADD}
    Wait Table Idle
    Ensure On Create Product Page
    Upload Product Image                 ${PRODUCT_IMAGE_PATH}
    Type    ${PRODUCT_INPUT_NAME}                     น้ำยาล้างจาน
    Type    ${PRODUCT_INPUT_DESC}                     น้ำยาล้างจานของดี
    Wait Until Element Is Visible             ${PRODUCT_SELECT_CATEGORY}    ${TIMEOUT}
    Select From List By Value                 ${PRODUCT_SELECT_CATEGORY}    ${PRODUCT_CATEGORY_VALUE}
    Type    ${PRODUCT_INPUT_BARCODE_PACK}     0150758695519
    Type    ${PRODUCT_INPUT_BARCODE_UNIT}     0646818912454
    Type    ${PRODUCT_INPUT_PACK_SIZE}        12
    Type    ${PRODUCT_INPUT_PRICE_UNIT}       10
    Type    ${PRODUCT_INPUT_PRICE_PACK}       120
    Execute Javascript    window.scrollTo(0, 0)
    Log Step And Screenshot              ก่อนเลื่อนลง
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Log Step And Screenshot              หลังเลื่อนลง
    Click Save Product
    Click If Exists                      ${SWAL_CONFIRM}
    Log Step And Screenshot              บันทึกสินค้าแล้ว
    Wait Table Idle

TC002 - เพิ่มสินค้าแบบกรอกล็อตและวันหมดอายุ
    Log Step And Screenshot              เริ่มต้น TC002
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
    Type    ${PRODUCT_INPUT_INIT_QTY}         120
    Type    ${PRODUCT_INPUT_INIT_PURCHASE}    6
    Type    ${PRODUCT_INPUT_INIT_EXPDATE}     ${PRODUCT_EXPDATE_VALUE}
    Click Save Product
    Click If Exists                      ${SWAL_CONFIRM}
    Log Step And Screenshot              บันทึกสินค้าแล้ว
    Wait Table Idle

TC003 - เพิ่มสินค้าแบบกรอกล็อตแต่ไม่กรอกวันหมดอายุ
    Log Step And Screenshot              เริ่มต้น TC003
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
    Click Save Product
    Click If Exists                      ${SWAL_CONFIRM}
    Log Step And Screenshot              บันทึกสินค้าแล้ว
    Wait Table Idle

TC004 - เพิ่มสินค้าแบบกรอกแค่รูปชื่อกับรายละเอียดสินค้า
    Log Step And Screenshot              เริ่มต้น TC004
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
    Log Step And Screenshot              บันทึกสินค้าแล้ว
    Wait Table Idle

TC005 - เพิ่มสินค้าแบบกรอกเพิ่มสินค้าติดลบ
    Log Step And Screenshot              เริ่มต้น TC005
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
    Type    ${INPUT_INIT_QTY}                 -120
    Type    ${INPUT_INIT_PURCHASE}            6
    Type    ${INPUT_INIT_EXPDATE}             ${EXPDATE_VALUE}
    Click Save Product
    Click If Exists                      ${SWAL_CONFIRM}
    Log Step And Screenshot              บันทึกสินค้าแล้ว
    Wait Table Idle

TC006 - เพิ่มสินค้าแบบราคาซื้อมากกว่าขาย
    Log Step And Screenshot              เริ่มต้น TC006
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
    Type    ${INPUT_INIT_PURCHASE}            60
    Type    ${INPUT_INIT_EXPDATE}             ${EXPDATE_VALUE}
    Click Save Product
    Click If Exists                      ${SWAL_CONFIRM}
    Log Step And Screenshot              บันทึกสินค้าแล้ว
    Wait Table Idle

TC007 - เพิ่มสินค้าแบบกรอกวันที่หมดอายุไปแล้ว
    Log Step And Screenshot              เริ่มต้น TC007
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
    Type    ${INPUT_INIT_EXPDATE}             11/01/2014
    Click Save Product
    Click If Exists                      ${SWAL_CONFIRM}
    Log Step And Screenshot              บันทึกสินค้าแล้ว
    Wait Table Idle

TC008 - เพิ่มสินค้าแบบกดยกเลิกแทนตกลง
    Log Step And Screenshot              เริ่มต้น TC008
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
    Click If Exists                      ${PRODUCT_BTN_CANCEL}
    Log Step And Screenshot              กดยกเลิกสำเร็จ
    Wait Table Idle

TC009 - เพิ่มสินค้าแบบกรอกบาร์โค้ดซ้ำ
    Log Step And Screenshot              เริ่มต้น TC009
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
    Click If Exists                      ${SWAL_CONFIRM}
    Log Step And Screenshot              บันทึกสินค้าแล้ว
    Wait Table Idle

TC010 - แก้ไขสินค้า
    Log Step And Screenshot              เริ่มต้น TC010
    Go To                               ${PRODUCT_LIST_URL}
    Wait Until Element Is Visible        ${PRODUCT_SEARCH_INPUT}    ${TIMEOUT}
    Input Text                          ${PRODUCT_SEARCH_INPUT}    น้ำยาล้างจาน
    Press Keys                          ${PRODUCT_SEARCH_INPUT}    ENTER
    Wait Table Idle
    Wait Until Element Is Visible        ${PRODUCT_BTN_EDIT}    ${TIMEOUT}
    Click Element                        ${PRODUCT_BTN_EDIT}
    Wait Table Idle
    Wait Until Element Is Visible        ${PRODUCT_EDIT_INPUT_NAME}    ${TIMEOUT}
    ${current_name}=    Get Element Attribute    ${PRODUCT_EDIT_INPUT_NAME}    value
    ${new_name}=    Set Variable    ${current_name} แก้ไข
    Clear Element Text                  ${PRODUCT_EDIT_INPUT_NAME}
    Input Text                          ${PRODUCT_EDIT_INPUT_NAME}    ${new_name}
    ${current_desc}=    Get Element Attribute    ${PRODUCT_EDIT_INPUT_DESC}    value
    ${new_desc}=    Set Variable    ${current_desc} แก้ไข
    Clear Element Text                  ${PRODUCT_EDIT_INPUT_DESC}
    Input Text                          ${PRODUCT_EDIT_INPUT_DESC}    ${new_desc}
    Click Element                        ${PRODUCT_EDIT_BTN_SAVE}
    Click If Exists                      ${SWAL_CONFIRM}
    Wait Table Idle
    Wait Until Element Is Visible        ${PRODUCT_SEARCH_INPUT}    ${TIMEOUT}
    Input Text                          ${PRODUCT_SEARCH_INPUT}    ${new_name}
    Press Keys                          ${PRODUCT_SEARCH_INPUT}    ENTER
    Wait Table Idle
    Page Should Contain                 ${new_name}
    Log Step And Screenshot            ตรวจสอบชื่อใหม่บนหน้ารายการ

