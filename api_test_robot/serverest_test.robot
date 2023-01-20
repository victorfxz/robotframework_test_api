*** Settings ***
Documentation       Este é um teste simples da api pública serverest,
...                 testando a listagem de produtos.

Resource            serverest_test.resource

Suite Setup         Criar a sessao com a api serverest


*** Test Cases ***
Testar Listar Produtos
    [Tags]    listarproduto
    Cadastrar o Usuario de Teste
    Efetuar o Login
