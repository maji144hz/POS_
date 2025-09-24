*** Variables ***
# --- Base Configuration ---
${BASE_URL}           http://localhost:5173
${BROWSER}            chrome
${VALID_USER}         1
${VALID_PASSWORD}     123
${TIMEOUT}            15s
${SCREEN_DIR}         screenshots

# --- Settings Locators ---
${BTN_EDIT_SHOP}      css=button[data-tip='แก้ไขข้อมูลร้าน']
${INPUT_SHOP_NAME}    id=shop-name-input
${INPUT_SHOP_ADDRESS} id=shop-address-input
${INPUT_SHOP_PHONE}   id=shop-phone-input
${BTN_SAVE_SHOP}      id=save-shop-button
