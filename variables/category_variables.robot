*** Variables ***
# --- Base Configuration ---
${BASE_URL}           http://localhost:5173
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SCREEN_DIR}         screenshots

# --- Category Test Data ---
${CATEGORY_NAME_BASE}      ทดสอบหมวดหมู่

# --- Category Locators ---
${CATEGORY_BTN_ADD}          id=create-category-button
${CATEGORY_INPUT_NAME}       xpath=//input[@placeholder='ชื่อประเภทสินค้า']
${CATEGORY_BTN_SAVE}         xpath=//button[contains(normalize-space(.),'บันทึก')]
${CATEGORY_INPUT_SEARCH}     id=category-search-input

# --- Edit Category Locators ---
${CATEGORY_EDIT_INPUT_NAME}  id=edit-category-name-input
${CATEGORY_BTN_SAVE_EDIT}    xpath=//button[contains(normalize-space(.),'บันทึกข้อมูล')]
${SWAL_CONFIRM}              css=button.swal2-confirm