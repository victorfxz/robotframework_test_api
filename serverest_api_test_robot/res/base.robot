*** Settings ***
Library     OperatingSystem
Library     JSONLibrary


*** Keywords ***
Get Json Schema
    [Arguments]    ${file_name}
    ${schema_binary}    Get Binary File    ${EXECDIR}/res/schemas/${file_name}
    ${schema}    evaluate    json.loads('''${schema_binary}''')    json
    RETURN    ${schema}
