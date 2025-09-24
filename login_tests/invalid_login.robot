*** Settings ***
Documentation     A test suite containing tests related to invalid login.
...
...               These tests are data-driven by their nature. They use a single
...               keyword, specified with Test Template setting, that is called
...               with different arguments to cover different scenarios.
...
...               This suite also demonstrates using setups and teardowns in
...               different levels.

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page
Test Template     Login With Invalid Credentials Should Fail

Resource          ../variables/login_variables.robot
Resource          ../keywords/login_keywords.robot

*** Test Cases ***               USER NAME        PASSWORD
Invalid Username                 perth1          ${VALID_PASSWORD}
Invalid Password                 ${VALID_USER}    122
Invalid Username And Password    invalid          whatever
Empty Username                   ${EMPTY}         ${VALID_PASSWORD}
Empty Password                   ${VALID_USER}    ${EMPTY}
Empty Username And Password      ${EMPTY}         ${EMPTY}