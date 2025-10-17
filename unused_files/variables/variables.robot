*** Variables ***
${BASE_URL}                  http://localhost:5173
${BROWSER}                   chrome

# --- Timeouts / Dirs ---
${TIMEOUT}                   20s
${SCREEN_DIR}                screenshots

# --- Common spinners/dialogs  ---
${SPINNERS}                  css=.ant-spin,.loading,.v-overlay--active,.swal2-container
${SWAL_CONFIRM}              css=button.swal2-confirm

# --- Products URLs/Locators  ---
${PRODUCT_LIST_URL}          ${BASE_URL}/product
${CREATE_URL}                ${BASE_URL}/products/create-product
${BTN_ADD_PRODUCT}           id=stock-add-product-button

# --- Products (Prefixed aliases) ---
${PRODUCT_LIST_URL_P}        ${PRODUCT_LIST_URL}
${PRODUCT_CREATE_URL}        ${CREATE_URL}
${PRODUCT_BTN_ADD}           ${BTN_ADD_PRODUCT}

# --- Search and Edit ---
${STOCK_SEARCH_INPUT}        id=stock-search-input
${BTN_EDIT_PRODUCT}          css=button.flex-1.bg-orange-50.text-orange-600
${PRODUCT_SEARCH_INPUT}      ${STOCK_SEARCH_INPUT}
${PRODUCT_BTN_EDIT}          ${BTN_EDIT_PRODUCT}

# --- Edit Product Form Fields ---
${EDIT_INPUT_NAME}           id=edit-product-name-input
${EDIT_INPUT_DESC}           id=edit-product-description-input
${EDIT_BTN_SAVE}            id=edit-product-submit-button
${PRODUCT_EDIT_INPUT_NAME}   ${EDIT_INPUT_NAME}
${PRODUCT_EDIT_INPUT_DESC}   ${EDIT_INPUT_DESC}
${PRODUCT_EDIT_BTN_SAVE}     ${EDIT_BTN_SAVE}

# --- Upload Area / File input ---
${UPLOAD_CLICK_AREA}         xpath=//*[contains(@class,'flex') and contains(@class,'flex-col') and contains(.,'เพิ่มรูปภาพ')] | //div[.//span[contains(normalize-space(.),'เพิ่มรูปภาพ')]]
${INPUT_FILE_OPT1}           xpath=//input[@type='file' and (contains(@id,'image') or contains(@name,'image') or contains(@accept,'image'))]
${INPUT_FILE_OPT2}           xpath=//input[@type='file']
${PRODUCT_IMAGE_PATH}        ${EXECDIR}${/}images${/}test_images${/}น้ำยาล้างจาน.jpg
${PRODUCT_UPLOAD_CLICK_AREA}  ${UPLOAD_CLICK_AREA}
${PRODUCT_INPUT_FILE_OPT1}   ${INPUT_FILE_OPT1}
${PRODUCT_INPUT_FILE_OPT2}   ${INPUT_FILE_OPT2}

# --- Form fields ---
${INPUT_NAME}                id=create-product-name-input
${INPUT_DESC}                id=create-product-description-input
${SELECT_CATEGORY}           id=create-product-category-select
${CATEGORY_VALUE}            6855a82ec16f3c50f07fc142
${PRODUCT_INPUT_NAME}        ${INPUT_NAME}
${PRODUCT_INPUT_DESC}        ${INPUT_DESC}
${PRODUCT_SELECT_CATEGORY}   ${SELECT_CATEGORY}
${PRODUCT_CATEGORY_VALUE}    ${CATEGORY_VALUE}

${INPUT_BARCODE_PACK}        id=barcodePack
${INPUT_BARCODE_UNIT}        id=barcodeUnit
${INPUT_PACK_SIZE}           id=packSize
${INPUT_PRICE_UNIT}          id=create-product-sellingpriceperunit-input
${INPUT_PRICE_PACK}          id=create-product-sellingpriceperpack-input
${PRODUCT_INPUT_BARCODE_PACK}  ${INPUT_BARCODE_PACK}
${PRODUCT_INPUT_BARCODE_UNIT}  ${INPUT_BARCODE_UNIT}
${PRODUCT_INPUT_PACK_SIZE}     ${INPUT_PACK_SIZE}
${PRODUCT_INPUT_PRICE_UNIT}    ${INPUT_PRICE_UNIT}
${PRODUCT_INPUT_PRICE_PACK}    ${INPUT_PRICE_PACK}

# --- Initial lot ---
${INPUT_INIT_QTY}            xpath=//input[@name='initialLot.quantity']
${INPUT_INIT_PURCHASE}       xpath=//input[@name='initialLot.purchasePrice']
${INPUT_INIT_EXPDATE}        xpath=//input[@name='initialLot.expirationDate']
${EXPDATE_VALUE}             11-09-2024
${PRODUCT_INPUT_INIT_QTY}        ${INPUT_INIT_QTY}
${PRODUCT_INPUT_INIT_PURCHASE}   ${INPUT_INIT_PURCHASE}
${PRODUCT_INPUT_INIT_EXPDATE}    ${INPUT_INIT_EXPDATE}
${PRODUCT_EXPDATE_VALUE}         ${EXPDATE_VALUE}

# --- Save button (fallback หลายแบบ) ---
${BTN_SAVE_OPT1}             id=create-product-submit-button
${BTN_SAVE_OPT2}             xpath=//button[normalize-space()='บันทึกข้อมูล' or normalize-space()='บันทึก']
${BTN_SAVE_OPT3}             css=button.btn-success, button.bg-green-500
${PRODUCT_BTN_SAVE_OPT1}     ${BTN_SAVE_OPT1}
${PRODUCT_BTN_SAVE_OPT2}     ${BTN_SAVE_OPT2}
${PRODUCT_BTN_SAVE_OPT3}     ${BTN_SAVE_OPT3}

${BTN_CANCEL_PRODUCT}        id=create-product-cancel-button
${PRODUCT_BTN_CANCEL}        ${BTN_CANCEL_PRODUCT}

# --- Orders (selectors) ---
${ORDER_BTN_PAY_NOW}         ${BTN_CHECKOUT_SPECIFIC}
${ORDER_BTN_PAYMENT_CASH}    ${BTN_PAYMENT_CASH}
${ORDER_BTN_PAYMENT_BANK}    ${BTN_PAYMENT_BANK}
${ORDER_BTN_PAYMENT_QR}      ${BTN_PAYMENT_QR}
${ORDER_BTN_CONFIRM_PAY}     ${BTN_CONFIRM_PAY}
${ORDER_SUCCESS_TEXT}        ${SUCCESS_TEXT}
