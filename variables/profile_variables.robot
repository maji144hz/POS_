*** Variables ***
# --- Base Configuration ---
${BASE_URL}           http://localhost:5173
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SCREEN_DIR}         screenshots

# --- Profile Test Data ---
${PROFILE_NAME}       ทดสอบชื่อ
${PROFILE_EMAIL}      test@example.com
${PROFILE_PHONE}      0812345678

# --- Profile Locators ---
${PROFILE_BTN_EDIT}           css=button[data-tip='แก้ไขโปรไฟล์']
${PROFILE_INPUT_NAME}         id=profile-name-input
${PROFILE_INPUT_EMAIL}        id=profile-email-input
${PROFILE_INPUT_PHONE}        id=profile-phone-input
${PROFILE_BTN_SAVE}           id=save-profile-button
${PROFILE_BTN_CHANGE_AVATAR}  css=button[data-tip='เปลี่ยนรูปโปรไฟล์']
