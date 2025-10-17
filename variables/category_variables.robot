*** Variables ***
# ========================================
# ไฟล์: category_variables.robot
# หน้าที่: เก็บข้อมูลสำหรับเทสหมวดหมู่สินค้า
# ใช้สำหรับ: เทสเพิ่ม/แก้ไข/ลบหมวดหมู่สินค้า
# ========================================

# ข้อมูลพื้นฐานสำหรับ Category
${BASE_URL}           https://frontend-finally-delta.vercel.app/login
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SCREEN_DIR}         screenshots

# Element พื้นฐาน
${SPINNERS}           css=.ant-spin,.loading,.v-overlay--active,.swal2-container
${SWAL_CONFIRM}       css=button.swal2-confirm

# ปุ่มหลักสำหรับ Category
${CATEGORY_BTN_ADD}          id=create-category-button
${CATEGORY_INPUT_NAME}       xpath=//input[@placeholder='ชื่อประเภทสินค้า']
${CATEGORY_BTN_SAVE}         xpath=//button[contains(normalize-space(.),'บันทึก')]
${CATEGORY_INPUT_SEARCH}     id=category-search-input

# แก้ไข Category
${CATEGORY_EDIT_INPUT_NAME}  id=edit-category-name-input
${CATEGORY_BTN_SAVE_EDIT}    xpath=//button[contains(normalize-space(.),'บันทึกข้อมูล')]