*** Variables ***
${BASE_URL}                  http://localhost:5173
${BROWSER}                   chrome

# --- Timeouts / Dirs ---
${TIMEOUT}                   20s
${SCREEN_DIR}                images/screenshots

# --- Common spinners/dialogs  ---
${SPINNERS}                  css=.ant-spin,.loading,.v-overlay--active,.swal2-container
${SWAL_CONFIRM}              css=button.swal2-confirm

# --- Products URLs/Locators  ---
${PRODUCT_LIST_URL}          ${BASE_URL}/product
${CREATE_URL}                ${BASE_URL}/products/create-product
${BTN_ADD_PRODUCT}           id=stock-add-product-button

# --- Search and Edit ---
${STOCK_SEARCH_INPUT}        id=stock-search-input
${BTN_EDIT_PRODUCT}          css=button.flex-1.bg-orange-50.text-orange-600

# --- Edit Product Form Fields ---
${EDIT_INPUT_NAME}           id=edit-product-name-input
${EDIT_INPUT_DESC}           id=edit-product-description-input
${EDIT_BTN_SAVE}            id=edit-product-submit-button

# --- Upload Area / File input ---
${UPLOAD_CLICK_AREA}         xpath=//*[contains(@class,'flex') and contains(@class,'flex-col') and contains(.,'เพิ่มรูปภาพ')] | //div[.//span[contains(normalize-space(.),'เพิ่มรูปภาพ')]]
${INPUT_FILE_OPT1}           xpath=//input[@type='file' and (contains(@id,'image') or contains(@name,'image') or contains(@accept,'image'))]
${INPUT_FILE_OPT2}           xpath=//input[@type='file']
${PRODUCT_IMAGE_PATH}        ${EXECDIR}${/}images${/}test_images${/}น้ำยาล้างจาน.jpg

# --- Form fields ---
${INPUT_NAME}                id=create-product-name-input
${INPUT_DESC}                id=create-product-description-input
${SELECT_CATEGORY}           id=create-product-category-select
${CATEGORY_VALUE}            6855a82ec16f3c50f07fc142

${INPUT_BARCODE_PACK}        id=barcodePack
${INPUT_BARCODE_UNIT}        id=barcodeUnit
${INPUT_PACK_SIZE}           id=packSize
${INPUT_PRICE_UNIT}          id=create-product-sellingpriceperunit-input
${INPUT_PRICE_PACK}          id=create-product-sellingpriceperpack-input

# --- Initial lot ---
${INPUT_INIT_QTY}            xpath=//input[@name='initialLot.quantity']
${INPUT_INIT_PURCHASE}       xpath=//input[@name='initialLot.purchasePrice']
${INPUT_INIT_EXPDATE}        xpath=//input[@name='initialLot.expirationDate']
${EXPDATE_VALUE}             11-09-2024

# --- Save button (fallback หลายแบบ) ---
${BTN_SAVE_OPT1}             id=create-product-submit-button
${BTN_SAVE_OPT2}             xpath=//button[normalize-space()='บันทึกข้อมูล' or normalize-space()='บันทึก']
${BTN_SAVE_OPT3}             css=button.btn-success, button.bg-green-500

${BTN_CANCEL_PRODUCT}        id=create-product-cancel-button
