### aqui ficam todas as palavras chaves que representam steps e ações da funcionalidade de cadastro (custom actions)

*** Settings ***
Documentation    Ações, steps e elementos da funcionalidade de cadastro

Library    Browser

*** Keywords ***
Go to signup page
    Click                      css=a[href="/signup"]
    #aguarda o elemento ficar visivel até 5 segundos e valida o texto = checkpoint para saber se está no lugar certo
    Wait For Elements State    form h1    visible    5000
    Get Text                   form h1    equal      Faça seu cadastro
    
Fill signup form
    [Arguments]    ${dog_walker}
    #propriedade da biblioteca browser para preencher os campos do cadastro
    Fill Text       css=input[name=name]                 ${dog_walker}[name]
    Fill Text       css=input[name=email]                ${dog_walker}[email]
    Fill Text       css=input[name=cpf]                  ${dog_walker}[cpf]
    Fill Text       css=input[name=cep]                  ${dog_walker}[cep]
    
    #clica em um botão
    Click           css=input[type=button][value$=CEP]
    
    #esse trecho valida os campos que foram preenchidos automaticamente após preencher o CEP e clicar no botão de pesquisa
    Get Property    css=input[name=addressStreet]      value    equal    ${dog_walker}[rua]
    Get Property    css=input[name=addressDistrict]    value    equal    ${dog_walker}[bairro]
    Get Property    css=input[name=addressCityUf]      value    equal    ${dog_walker}[cidadeUf]
    
    #... continuação da library browser para preencher os campos
    Fill Text       css=input[name=addressNumber]        ${dog_walker}[numero]
    Fill Text       css=input[name=addressDetails]       ${dog_walker}[complemento]
    
    #esse elemento é o botão responsável por abrir a caixa para fazer upload do arquivo
    #por padrão, ele fica oculto e para ser exibido, precisa desmarcar na aba style do 'element.style' => diplay
    #apos fazer isso, o elemento 'type=file' aparece.
    #dps disso, precisa usar a palavra reservada 'EXECDIR' para ir no diretório onde o arq está e concatenar com o nome do arq
    Upload File By Selector    css=input[type=file]    ${EXECDIR}/resources/fixtures/${dog_walker}[cnh]


Serviço adicional
    [Arguments]    ${servico_adicional}

    Click                xpath=//span[text()="${servico_adicional}"]/..
    Take Screenshot      selector=//span[text()="${servico_adicional}"]/..

Submit signup form
    #clica no botão "Cadastrar"
    Click    css=.button-register
    
Popup should be
    [Arguments]    ${expected_text}
    #nesse momento, abre uma caixa e foi usado o wait para aguardar 5 segundos
    Wait For Elements State    css=.swal2-html-container    visible    5
    Get Text                   css=.swal2-html-container    equal      ${expected_text}


Alert should be
    [Arguments]    ${expected_text}

    Wait For Elements State    css=.alert-error >> text=${expected_text}    visible    5


