*** Variables ***
# --- Base Configuration ---
${BASE_URL}           http://localhost:5173
${BROWSER}            chrome
${VALID_USER}         admin
${VALID_PASSWORD}     12345678
${CATEGORY_BASE}      ทดสอบหมวดหมู่
${TIMEOUT}            20s
${SCREEN_DIR}         images/screenshots

# ===== Locators =====
# สร้าง (Create)
${BTN_ADD_CATEGORY}   css=button[data-tip='เพิ่มหมวดหมู่']
${CREATE_INPUT}       xpath=//input[@placeholder='ชื่อประเภทสินค้า']
${BTN_SAVE_CREATE}    xpath=//button[contains(normalize-space(.),'บันทึก')]

# ค้นหา
${SEARCH_CATEGORY}    id=category-search-input

# แก้ไข (Edit)
${BTN_EDIT_SINGLE}    xpath=//button[starts-with(@id,'edit-category-button-')]
${EDIT_INPUT}         id=edit-category-name-input
${BTN_SAVE_EDIT}      xpath=//button[contains(normalize-space(.),'บันทึกข้อมูล')]

# ลบ (Delete)
${BTN_DELETE_SINGLE}  xpath=//button[starts-with(@id,'delete-category-button-')]

# ตัวโหลด/แจ้งเตือน (ถ้ามี)
${SPINNERS}           css=.ant-spin,.loading,.v-overlay--active
${SWAL_CONFIRM}       css=button.swal2-confirm
