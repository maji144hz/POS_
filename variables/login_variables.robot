*** Variables ***
# --- Login Configuration ---
${SERVER}                 localhost:5173
${BROWSER}                chrome
${DELAY}                  0.1
${VALID_USER}             1
${VALID_PASSWORD}         123
${LOGIN_URL}              http://${SERVER}/
${WELCOME_URL}            http://${SERVER}/
${ERROR_URL}              http://${SERVER}/

# --- Login (Prefixed aliases) ---
${LOGIN_SERVER}           ${SERVER}
${LOGIN_BROWSER}          ${BROWSER}
${LOGIN_DELAY}            ${DELAY}
${LOGIN_VALID_USER}       ${VALID_USER}
${LOGIN_VALID_PASSWORD}   ${VALID_PASSWORD}
${LOGIN_PAGE_URL}         ${LOGIN_URL}
${LOGIN_WELCOME_URL}      ${WELCOME_URL}
${LOGIN_ERROR_URL}        ${ERROR_URL}
