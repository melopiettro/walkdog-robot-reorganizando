*** Settings ***
Documentation         Suite de testes cadastro

Resource              ../resources/base.resource

Test Setup       Start session
Test Teardown    Finish session    


*** Test Cases ***
Deve poder cadastrar um novo dog walker
    [Tags]    cadastro_completo
    #Define as variáveis dos elementos mapeados para realizar o cadastro / criado assim da primeira vez (variáveis simples)
    # ${name}           Set Variable    Piettro Oliveira
    # ${email}          Set Variable    pmelo@gmail.com
    # ${cpf}            Set Variable    00000014141
    # ${cep}            Set Variable    13175653
    # ${rua}            Set Variable    Alameda das Cássias
    # ${numero}         Set Variable    65
    # ${complemento}    Set Variable    apt 123
    # ${bairro}         Set Variable    Parque Villa Flores
    # ${cidadeUf}       Set Variable    Sumaré/SP
    # ${cnh}            Set Variable    toretto.jpg
    
    #Super Variáveis(dicionarios do python) - criar dessa forma, fica mais prático e melhor de fazer manutenção
    ${dog_walker}    Create Dictionary
    ...    name=Piettro Oliveira
    ...    email=pmelo@gmail.com
    ...    cpf=00000014141
    ...    cep=13175653
    ...    rua=Alameda das Cássias
    ...    numero=65
    ...    complemento=apt 123
    ...    bairro=Parque Villa Flores
    ...    cidadeUf=Sumaré/SP
    ...    cnh=toretto.jpg

    #aqui será chamado os steps definidos na sessão de Keywords

    Go to signup page
    Fill signup form    ${dog_walker}
    Submit signup form
    Popup should be    Recebemos o seu cadastro e em breve retornaremos o contato.



Cadastrar um novo dog walker com serviço adicional de cuidado
    [Tags]    servico_adicional_cuidado
    
    #Super Variáveis(dicionarios do python) - criar dessa forma, fica mais prático e melhor de fazer manutenção
    ${dog_walker}    Create Dictionary
    ...    name=Milena Silva
    ...    email=milena@gmail.com
    ...    cpf=00000014141
    ...    cep=13175653
    ...    rua=Alameda das Cássias
    ...    numero=65
    ...    complemento=apt 123
    ...    bairro=Parque Villa Flores
    ...    cidadeUf=Sumaré/SP
    ...    cnh=toretto.jpg

    #aqui será chamado os steps definidos na sessão de Keywords

    Go to signup page
    Fill signup form    ${dog_walker}
    Serviço adicional    Cuidar
    Submit signup form
    Popup should be    Recebemos o seu cadastro e em breve retornaremos o contato.



Cadastrar um novo dog walker com serviço adicional de adestramento
    [Tags]    servico_adicional_adestramento

    
    #Super Variáveis(dicionarios do python) - criar dessa forma, fica mais prático e melhor de fazer manutenção
    ${dog_walker}    Create Dictionary
    ...    name=El Loco
    ...    email=elloco@gmail.com
    ...    cpf=00000014141
    ...    cep=13175653
    ...    rua=Alameda das Cássias
    ...    numero=65
    ...    complemento=apt 123
    ...    bairro=Parque Villa Flores
    ...    cidadeUf=Sumaré/SP
    ...    cnh=toretto.jpg

    #aqui será chamado os steps definidos na sessão de Keywords

    Go to signup page
    Fill signup form     ${dog_walker}
    Serviço adicional    Adestrar
    Submit signup form
    Popup should be      Recebemos o seu cadastro e em breve retornaremos o contato.


Não deve cadastrar se os campos obrigatórios não forem preenchidos
    [Tags]    required
    #aqui será chamado os steps definidos na sessão de Keywords
    Go to signup page
    Submit signup form
    #essa keyword está configurada nas actions/signup.resource
    Alert should be    Informe o seu nome completo
    Alert should be    Informe o seu melhor email
    Alert should be    Informe o seu CPF
    Alert should be    Informe o seu CEP
    Alert should be    Informe um número maior que zero
    Alert should be    Adcione um documento com foto (RG ou CHN)





Não deve cadastrar com CPF invalido
    [Tags]    cpf_incorreto
    
    #Super Variáveis(dicionarios do python) - criar dessa forma, fica mais prático e melhor de fazer manutenção
    ${dog_walker}    Create Dictionary
    ...    name=Piettro Oliveira
    ...    email=pmelo@gmail.com
    ...    cpf=00000014aaa
    ...    cep=13175653
    ...    rua=Alameda das Cássias
    ...    numero=65
    ...    complemento=apt 123
    ...    bairro=Parque Villa Flores
    ...    cidadeUf=Sumaré/SP
    ...    cnh=toretto.jpg

    #aqui será chamado os steps definidos na sessão de Keywords

    Go to signup page
    Fill signup form    ${dog_walker}
    Submit signup form
    Alert should be     CPF inválido