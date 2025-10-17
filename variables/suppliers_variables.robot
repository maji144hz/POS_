*** Variables ***
# ========================================
# ไฟล์: suppliers_variables.robot
# หน้าที่: เก็บข้อมูลสำหรับเทสซัพพลายเออร์
# ใช้สำหรับ: เทสเพิ่ม/แก้ไข/ลบซัพพลายเออร์
# ========================================

# ข้อมูลพื้นฐานสำหรับ Suppliers
${BASE_URL}           https://frontend-finally-delta.vercel.app/login
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SCREEN_DIR}         screenshots

# Element พื้นฐาน
${SPINNERS}           css=.ant-spin,.loading,.v-overlay--active,.swal2-container
${SWAL_CONFIRM}       css=button.swal2-confirm

# ปุ่มหลักสำหรับ Suppliers
${BTN_ADD_SUPPLIER}           id=create-supplier-button
${INPUT_SUPPLIER_NAME}        id=create-supplier-name-input
${INPUT_SUPPLIER_CONTACT}     id=create-supplier-contact-input
${INPUT_SUPPLIER_PHONE}       id=create-supplier-phone-input
${INPUT_SUPPLIER_ADDRESS}     id=create-supplier-address-input
${BTN_SAVE_SUPPLIER}          id=create-supplier-submit-button
${SEARCH_SUPPLIER}            id=supplier-search-input

# แก้ไขและลบ
${BTN_EDIT_SUPPLIER}          xpath=//button[starts-with(@id,'edit-supplier-button-')]
${BTN_DELETE_SUPPLIER}        xpath=//button[starts-with(@id,'delete-supplier-button-')]
${INPUT_EDIT_SUPPLIER_NAME}   id=edit-supplier-name-input
${BTN_SAVE_EDIT_SUPPLIER}     id=edit-supplier-submit-button
