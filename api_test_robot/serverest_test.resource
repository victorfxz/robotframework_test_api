*** Settings ***
Documentation       Este é um teste simples da api pública serverest,
...                 testando a listagem de produtos.

Resource            base.robot
Library             RequestsLibrary
Library             Collections
Library             FakerLibrary
Library             JSONSchemaLibrary    ${EXECDIR}/schemas/
Library             jsonschema


*** Variables ***
${URL}          https://serverest.dev
${ALIAS}        session_serverest
${admin}        true
${usuario}
${TOKEN}


*** Keywords ***
Criar os dados do usuario
    ${nome}=    Name
    ${email}=    Email
    ${password}=    Password
    ${usuario}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${password}
    ...    administrador=${admin}
    Set Suite Variable    ${usuario}
    Log    ${usuario}

Criar a sessao com a api serverest
    Criar os dados do usuario
    ${HEADER}=    Create Dictionary    Content-Type=application/json
    Create Session    ${ALIAS}    url=${URL}    headers=${HEADER}    disable_warnings=1

Cadastrar o Usuario de Teste
    ${RESPONSE}=    POST On Session    ${ALIAS}    json=${usuario}    url=${URL}/usuarios
    Log    Resposta Retornada: ${RESPONSE.json()}
    Log To Console    Resposta Retornada: ${RESPONSE.json()}
    Request Should Be Successful
    Status Should Be    201    ${RESPONSE}
    Should Be Equal As Strings    Created    ${RESPONSE.reason}
    Should Be Equal    ${RESPONSE.status_code}    ${201}
    Should Not Be Empty    ${RESPONSE.json()}
    Should Be Equal As Strings    ${RESPONSE.headers["Content-Type"]}    application/json; charset=utf-8
    Should Contain    ${RESPONSE.headers["Content-Type"]}    application/json
    Dictionary Should Contain Item    ${RESPONSE.json()}    message    Cadastro realizado com sucesso
    ${count_id}=    Get length    ${RESPONSE.json()["_id"]}
    should be equal as numbers    ${count_id}    16
    Length Should Be    ${RESPONSE.json()["_id"]}    16
    ${ID_PRODUTO_CADASTRADO}=    Get From Dictionary    ${RESPONSE.json()}    _id
    Set Suite Variable    ${ID_PRODUTO_CADASTRADO}
    Log To Console    Resposta ID:    ${ID_PRODUTO_CADASTRADO}
    Validate Json    user.json    ${RESPONSE.json()}

Efetuar o Login
    ${BODY}=    Create Dictionary    email=${usuario.email}    password=${usuario.password}
    ${RESPONSE}=    POST On Session    ${ALIAS}    json=${BODY}    url=${URL}/login
    Log    Resposta : ${RESPONSE.json()}
    Log To Console    Resposta : ${RESPONSE.json()}
    Request Should Be Successful
    Dictionary Should Contain Item    ${RESPONSE.json()}    message    Login realizado com sucesso
    Should Not Be Empty    ${RESPONSE.json()["authorization"]}
    ${TOKEN}=    Get From Dictionary    ${RESPONSE.json()}    authorization
    Set Suite Variable    ${TOKEN}
    Validate Json    login.json    ${RESPONSE.json()}
