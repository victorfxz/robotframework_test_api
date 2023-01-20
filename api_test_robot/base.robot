*** Settings ***
Library     OperatingSystem
Library     JSONLibrary


*** Keywords ***
Get Json
    [Arguments]    ${file_name}
    ${dados}    Load Json From File    ${EXECDIR}/schemas/${file_name}
    RETURN    ${dados}

Get Json Schema
    [Arguments]    ${file_name}
    ${schema_binary}    Get Binary File    ${EXECDIR}/schemas/${file_name}
    ${schema}    evaluate    json.loads('''${schema_binary}''')    json
    RETURN    ${schema}

Update JSON
    [Arguments]    ${file_name}    ${Chave}    ${Valor}
    ${file_content}    Get File    ${EXECDIR}/data/${file_name}
    ${dados}    Update Value To Json    ${file_content}    ${Chave}    ${Valor}
    RETURN    ${dados}
