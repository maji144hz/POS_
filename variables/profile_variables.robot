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
${BTN_EDIT_PROFILE}   css=button[data-tip='แก้ไขโปรไฟล์']
${INPUT_PROFILE_NAME} id=profile-name-input
${INPUT_PROFILE_EMAIL} id=profile-email-input
${INPUT_PROFILE_PHONE} id=profile-phone-input
${BTN_SAVE_PROFILE}   id=save-profile-button
${BTN_CHANGE_AVATAR}  css=button[data-tip='เปลี่ยนรูปโปรไฟล์']
