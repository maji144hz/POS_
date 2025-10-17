*** Variables ***
# ========================================
# ไฟล์: common_variables.robot
# หน้าที่: เก็บข้อมูลพื้นฐานที่ทุกเทสต้องใช้
# ใช้สำหรับ: URL เว็บไซต์, ข้อมูล login, เวลารอ
# ========================================

# ข้อมูลพื้นฐาน
${BASE_URL}           https://frontend-finally-delta.vercel.app/login
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SCREEN_DIR}         screenshots

# Element พื้นฐาน
${SPINNERS}           css=.ant-spin,.loading,.v-overlay--active,.swal2-container
${SWAL_CONFIRM}       css=button.swal2-confirm
