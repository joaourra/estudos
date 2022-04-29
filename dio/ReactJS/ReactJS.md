## Estudos
Baixar e instalar o npm (https://nodejs.org/en/download/) webpack (https://webpack.js.org/)

React é uma biblioteca e não um framework
é uma linguagem declarativa. (apenas para exibir ou não)
10.16 node


React Create App
React Scripts

# comandos
npm init
Enter em tudo e depois Instala a ultima versão
npm install --save react@16.8.6 react-debug@16.8.6 react-scripts@3.0.1


## webpack 4
entry, output, loaders, plugins, mode
production
development

## EsLint
module.exports = {
devtool: 'source-map'}...
verifica os erros  de forma mais clara

LetraMaiusculaInicio.jsx de react
&& // se hasCustomer true faz
? // se existir faz
! //na frente se não existir
const buttonA = <button>Histórico dos clientes</button>
const hasCustomer = false
const App = () => {
    return (
        <div>
        {hasCustomer && ( // se hasCustomer true faz
            {buttonA}
        )}
        </div>
    )
}

lista
{listCotumer.map(renderCostumer)}

# Teste
Manipulação de eventos.. react são nomeados usando camelCase ao inves de letras maiusculas
webpack - entry, output, loaders, plugins, mode
renderização React no DOM ReactDom.render
webpack - é um module bundlers (um empacotador de módulos para js)
if && - {hasCustomer && (<Component>)}
react - biblioteca .. criar varios componentes e elementos...
Loaders - é uma config q webpack gerencia arquivos q nao são js
ciclo de vida de um componente - inicializa - monta - atualiza - desmonta
const numbers = [1, 2, 3, 4, 5]; const listItems = numbers.map((number) =>  <li>{number}</li> ); - adicionar parametro key no elemento <li>
React - uma biblioteca js para criar interfaces de usuário.

# Aplicações p internet com React
TDD - é recomendado que se escrevam os testes primeiro, ou seja, antes das funcionalidades
Redux - a action em redux é como em Flux, com a diferença que ela retorna um objeto de action formatado
Flux - as actions formatam a mensagem a ser enviada para o dispatcher
CSS in JS - A biblioteca styled components é exemplo de uma biblioteca em que se pode usar CSS in JS
fetch API - O fetch fornece suporte a PWAs e tem como principal carac prover uma interface para chamadas HTTP baseada em Promises
conceito de imutabilidade, exceto: - const x = ["Lake"]; const y = x.concat("duck");
BDD - A sintaxe Gherkin aumenta a sinergia entre especificação e testes
componentes Reacts - <textarea> e <select>
valida o teste da subtração de dois números? expect(sub(2,2),toBe(0))
Stateful - Supondo um estado shoe ... this.setState({shoe:'sapatenis'})

# Redux, React
Redux - Um State Container para armazenar os estados das aplicações JS ou outras linguagens
Pilares React - Ser declarativo e baseado em componentes. Com isso, uma vez que o componente é definido/registrado, ele pode ser usado em qualquer lugar do projeto
3 principios da arquitetura Redux - Uma única fonte de verdade, estado disponivel apenas para leitura e mudanças no estado são feitas apenas por funções puras
middlewares - Funções que são capazes de conectar outras funções, ex: um software é capaz de criar mais facilmente e eficientemente a conexão entre aplicações, dados e usuarios
influências da linguagem Elm sobre o Redux? - Imutabilidade, API declarativa, operações deterministicas, controlar side-effects (quando n se pode evita-lo)
React - Uma biblioteca js para contruir interfaces Web
caracteristicas Redux - Previsivel, centralizado, debugavel, flexivel
State Container - Blocos (container) da sua aplicação que armazena um estado de forma centralizada, que pode ser lido por outros blocos da aplicação
prós da criação de State Containers - Simplifica problemas de data-flow complexos e pontos únicos de controle de estado
arquitetura Flux para o Redux - Aprimorou um fluxo direcional para açoes, diminuindoa a complexidade assim evitando perca de dados e gargalos durante as aplicações

# States & Effects no Reactjs

hooks - criar funções reativas nos componentes e dar mais inteligência a eles
renderizar um componente - significa que o elemento sera desenhado com htlm e css ..
componente - são funcionalidades isoladas em um sistema que retornam um elemento visual com comportamento
componente funcional - function component(){return (<div>ola mundo</div>)}
valor inicial do estado -- const [nome, setNome] = useState('sample') - sample
useEffect - uma função que vigia uma variavel/evento e é executada sempre que essa variavel/ev é atualizado
poder utilizar states e effects - import React, {useState, useEffect} from 'react';
hook - uma função associada a uma propriedade ou evento do componente
useState - um hook para gerenciar um estado de um componente
hook - uma função associada a uma propriedade