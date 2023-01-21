*** Settings ***
Documentation       Este é um teste simples da api pública serverest,
...                 testando cadastro de usuário, login, cadastro de produtos.

Resource            api_test.resource

Suite Setup         Criar a sessao na api serverest


*** Test Cases ***
Testar Cadastrar Produtos
    [Tags]    cadastrarclienteproduto
    Cadastrar o Usuario de Teste
    Efetuar o Login
    Cadastrar um Produto
