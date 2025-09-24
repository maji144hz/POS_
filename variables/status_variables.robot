*** Variables ***
# --- Base Configuration ---
${BASE_URL}           http://localhost:5173
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SCREEN_DIR}         screenshots

# --- Status Test Data ---
${STATUS_BASE}        ทดสอบสถานะ

# --- Status Locators ---
${BTN_ADD_STATUS}     id=create-status-button
${INPUT_STATUS}       xpath=//input[@placeholder='ชื่อสถานะสินค้า']
${BTN_SAVE_STATUS}    xpath=//button[contains(normalize-space(.),'บันทึก')]
${SEARCH_STATUS}      id=status-search-input

# --- Edit and Delete Buttons ---
${BTN_EDIT_STATUS}          xpath=//button[starts-with(@id,'edit-status-button-')]
${BTN_DELETE_STATUS}        xpath=//button[starts-with(@id,'delete-status-button-')]
${EDIT_INPUT_STATUS}        id=edit-status-name-input
${BTN_SAVE_EDIT_STATUS}     id=edit-status-submit-button

# --- Common Elements ---
${SPINNERS}                 css=.ant-spin,.loading,.v-overlay--active
${SWAL_CONFIRM}             css=button.swal2-confirm