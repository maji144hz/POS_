*** Variables ***
# ========================================
# ไฟล์: order_variables.robot
# หน้าที่: เก็บข้อมูลสำหรับเทสการขายสินค้า
# ใช้สำหรับ: เทสขายสินค้า, จ่ายเงิน, ใส่สินค้าในตะกร้า
# ========================================

# ข้อมูลพื้นฐานสำหรับ Order
${BASE_URL}           https://frontend-finally-delta.vercel.app/login
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SCREEN_DIR}         screenshots

# Element พื้นฐาน
${SPINNERS}           css=.ant-spin,.loading,.v-overlay--active,.swal2-container
${SWAL_CONFIRM}       css=button.swal2-confirm

# ปุ่มหลักสำหรับ Order
${BTN_CHECKOUT}             css=button[data-tip='ชำระเงิน']
${BTN_PAYMENT_CASH}         xpath=//button[.//h3[contains(normalize-space(.), 'เงินสด')]]
${BTN_PAYMENT_QR}           xpath=//button[.//h3[contains(normalize-space(.), 'QR Code')]]
${BTN_CONFIRM_PAY}          xpath=//button[contains(., 'ยืนยันการชำระเงิน')]
${SUCCESS_TEXT}             สร้างคำสั่งซื้อสำเร็จ

# ตะกร้าสินค้า
${BTN_OPEN_CART_ID}         css=button#open-cart-btn
${CART_HEADING}             xpath=//h2[normalize-space()='ตะกร้าสินค้า']

# ค้นหาสินค้า
${SEARCH_INPUT}             xpath=//input[@type='search']

# สำหรับทดสอบ
${ORDER_BTN_PAYMENT_CASH}     ${BTN_PAYMENT_CASH}
${ORDER_BTN_PAYMENT_QR}       ${BTN_PAYMENT_QR}
${ORDER_BTN_CONFIRM_PAY}      ${BTN_CONFIRM_PAY}
${ORDER_SUCCESS_TEXT}         ${SUCCESS_TEXT}
