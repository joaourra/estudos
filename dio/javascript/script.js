//exercicio de map

function getAdmins(map){
    for([key, value] of map){
        if(value === 'Admin'){
            admins.push(key);
        }
    }
    return admins;
}

const usuarios = new Map();

usuarios.set('João','Admin');
usuarios.set('Karine','Admin');
usuarios.set('Rapha','User');
usuarios.set('Manu','Admin');

console.log(getAdmins(usuarios));

//exercicio de set x array

const meuArray = [30,30,40,5,223,2049,3034,5];

function valoresUnicos(arr){
    const mySet = new Set(arr);

    return [...mySet];
}
console.log(valoresUnicos(meuArray));

//coleções chaveadas, usar loop for...of
// .add()Set // .set()Map // Sets são dados unicos
// Sets e Maps são coleções chaveads, enquanto Arrays e Objetos não
// valor no Map retornar .get()
//retornar o tamanho de Sets, acessar a propriedade size
// verificar se Set possui valor .has



//exercicio debug-error
//Atividade: validação de erros por tipo
//O objetivo é que a função receba um array e retorne ele caso o seu tamanho corresponda ao número enviado como parâmetro na função. Caso contrário, um erro será lançado.

//Crie uma função que recebe um array e um número
//Realize as seguintes validações
//Se os parâmetros não forem enviados, lance um erro do tipo ReferenceError
//Se o array não for do tipo 'object', lance um erro do tipo TypeError
//Se o número não for do tipo 'number', lance um erro do tipo TypeError
//Se o tamanho do array for diferente do número enviado como parâmetro, lance um erro do tipo RangeError
//Utilize a declaração try...catch
//Filtre as chamadas de catch por cada tipo de erro utilizando o operador instanceof


function validaArrays(arr, num) {
	try {
		if (!arr && !num) throw new ReferenceError('Envie os parâmetros!');

		if (typeof arr !== 'object')
			throw new TypeError('Envie um elemento do tipo Array!');

		if (typeof num !== 'number')
			throw new TypeError('Envie um elemento do tipo Number!');

		if (arr.length !== num) throw new RangeError('Tamanho do array inválido!');

		return arr;
	} catch (e) {
		if (e instanceof RangeError) {
			console.log('RangeError!');
			console.log(e.stack);
		} else if (e instanceof ReferenceError) {
			console.log('ReferenceError!');
			console.log(e.stack);
		} else {
			console.log('Outro tipo de erro!');
			console.log(e.stack);
		}
	}
}

console.log(validaArrays([1, 2, 3], 0));


/* Novo Erro: Este erro nunca ocorreu
// cath, é executado apenas, erro e possibilita manipulação de um objeto Error
// try.. cath dentro do bloco try ... e caso ocorra erro é tratado no catch
// ECMA de execução... Dom referente a Dom
// validaArray() (outro tipo de erro)
// throw lanca erro, return um valor
// ECMA mensagem, nome, linha e call stack
// catch possibilita manipular 
//filnaly executa sempre.
const MeuErro = new Error */

// Assincronissidade

// Promises 1pending, 2fulfilled e 3Rejected
const myPromise = new Promise((resolve, reject) => {window.setTimeout(( =>{
    resolve(console.log('Resolvida'));
}, 2000); // depois de 2 segundos da um log resolvida
});

await myPromise
    .then((result) => result + ' passando pelo then') // concatena com a mensagem
    .then((result) => result + ' e agora acabou!')
    .catch((err) => console.log(err.message)); //captura o erro caso de

// Após 2 segundos, retornará o valor.. "Resolvida passando pelo then e agora acabou!"

/* async e await (assincrona, espera realizar e continua)
se chamar uma promise() vai retornar Promise{<pendig>}
chamar com o await resolvePromise() e ai retorna
e pode usar try..catch

API tipo JSON object notation
fetch (consumindo apis)
fetch(url, options)
    .then(response => response.json())
    .then(json => console.log(json))
 retorna uma promise
 precisa converter json para strig para ser lida

 Operações no banco de dados (POST, GET, PUT, DELETE, etc)

fetch('https://endereco-api.com/', {
    method:'POST',
    cache:'no-cache',
    body: JSON.stringfy(data)
})
    .then(response => response.json())
    .then(json => console.log(json))

*/
// atividade de carregar fotos de gatinho

const BASE_URL = 'https://thatcopy.pw/catapi/rest/';

const getCats = async () => {

    /* sem o try seria
    const data = await fetch(BASE_URL)
        .then((res) => res.json())
        .catch((e) => console.log(e));

    return data.webpurl;
    */
	try {
		const data = await fetch(BASE_URL);
		const json = await data.json();
		return json.webpurl;
	} catch (e) {
		console.log(e.message);
	}
};

const loadImg = async () => {
	const img = document.getElementsByTagName('img')[0];
	img.src = await getCats();
};

loadImg();

const btn = document.getElementById('change-cat');
btn.addEventListener('click', loadImg);

/* PERGUNTAS
await é um operador especifico para lidar com Promises
falsa - não é possivel saber se uma promise foi rejeitada

Dadas as afirmações abaixo
I. É possível trabalhar com Promises utilizando a
declaração try...catch
II. É uma boa prática trabalhar com Promises em
funções síncronas
III. É necessário utilizar uma biblioteca específica para
utilizá-las em código Javascript
Quais são verdadeiras?
I E II 

API é Acronimo, application programming interface, é uma interface que possibilita a comunicação entre plataformas
fetch retorna uma Promise
*/
const hello = new Promise((res, rej) =&gt; {
res(&#39;Olá, &#39;);
});
async function saudacoes() {
const name = await hello
.then(res =&gt; res + &quot;tudo &quot;)
.then(res =&gt; res + &quot;bem?&quot;)
.catch(e =&gt; console.log(e.message))
return name;
}
await saudacoes();
/*resultado
Olá, tudo bem?

Qual a diferença entre as duas funções abaixo?
Função 1:
function printName() {
const name = nameApi();
return name;
}

Função 2:
async function printName() {
const name = await nameApi();
return name;
}
A primeira n assincrona e a segunda [e, a correta de lidar com primises [e a segunda]]
Promise um objeto javascript 3 estados: pendente, resolvido e rejeitado
JSON é object notation, formato de troca de info, muito na comunicação front-end com api

Promises é  necessatio await para obter o resultado
*/

// ORIENTA;'AO A OBJETOS

/*
Pilares: Herança, Polimorfismo, Encapsulamento, Abstração

Abstração, de algo complexo deixar mais simples 
Herança objetos filhos levam algo dos pais
Encapsulamento só quem ta la que é mexido
Polimorfismo tem a mesma classe pai mas se comportam diferente

OOJS (orientação a objetos com javascript)

Usar o class objeto {}... novo
ainda é um objeto, js não possui classes nativamente. todas as classes são objetos,
e a herança se da por prototipos
*/
/* Polimorfismo - conceito classes complexas herdam metodos de classes abstratas e executam a sua maneira
Pilares - Abstração, Herança, Polimorfismo, Encapsulamento 
protótipos - conceito de Herança em javascript
todas certas
método super()- passa o argumento enviados para classe ascendente
caso parametro tenha getters e setters - nomeado _
I. O método super() 
II. Getters e setters são
III. Getters e setters ferem
I e II verdadeiro
Herança - Classes descendentes herdam cract de classes ascendentes
Encapsulamento - props e metodos de classe q dizem respeito apenas a ela
Abstração - Diminuir complexidade


*/


// Map, Filter e Reduce
/* 
.map(callback, thisArg) callback(item, index, array)
forEach // retorna undefined necessitando de uma função auxiliar
array.map((item) => item *2); // retorna um novo array
array.forEach((item) => item * 2); //
array.filter(callback, thisArg) // cria um novo array com o filtro
reduce Executa uma função em
todos os elementos do array, retornando um valor único
const callbackFn = function(accumulator, currentValue, index, array){

}
array.reduce(callback, initialValue)

Reduce - ele sempre retorna apenas um valor, q pode ou n ser um array
Reduce - percorre um array e acumula o valor de cada operação para retornar um valor unico final
Map - percorre o array e executa uma função em cada um de seus itens
Map - sempre retorna um novo array
map array forEach undefined
filter - sempre retorna um novo array
filter - percorre um array e retorna outro apenas com os itens que passaram pela validação
let array = [1, 2, 3, 4];
array.filter((item) => item % 2 === 0);
Qual será o retorno? [2,4]

let array = [1, 2, 3, 4];
array.map((item) => item * 2);
console.log(array); //[1, 2, 3, 4] 

let array = [1, 2, 3, 4];
array.reduce((current, acc) => current + acc);
//10
*/

/*	DOM e BOM

DOM document object model é um padrão de como acessar e modificar os elementos HTML de uma pg
BOM browser object model Tudo o que está dentro do objeto window (janela, histórico...)

DOM  tag, id, classe
document.getElementById('id');
document.getElementByTagName('p');
document.getElementByClassName('classe');
document.querySelectorAll('.primeira-classe .segunda-classe');
document.querySelectorAll('li .opcao'); // Apenas li com classe opcao
document.querySelectorAll('li .classe #id'); // exemplo de como escrever 
document.createElement(element) - cria um novo elemento HTML
document.removeChild(element) - remove um elemento, (appendChild(element)) adiciona e (replaceChild(new, old))substitui
 
const meuElemento = document.getElementById("meu-elemento")
meuElemento.classList.add("novo-estilo"); //adiciona a classe meu estilo
.remove("classe"); //remove classe classe
.togglet("dark-mode") // adiciona a classe "dark-mode"
// caso não faça parte da lista e remove caso faça.	
document.getElementsByTagName("p").style.color = "blue";

Eventos (mouse over, out, click,dbclik(2clicks))Change (algo mudar) load (a pagina carregar)
const botao = document.getElementById("meuBotao");
botao.addEventListener("click", outraFuncao); //click evento e o que fazer quando o evento acontecer

no html adiciona o on...
<h1 onclik="mudaTexto(this)">Clique aqui!</h1>
<script>
function mudaTexto(id) {
	id.innerHTML = "Mudei!";
}</script>


add classe element.classList.add('classe')
Como poderia ser selecionado o elemento <section id="sobre" class="full-screen">?
document.querySelectorAll('#sobre .full-screen')
Como poderia ser selecionado o elemento <h1>Título principal</h1>?
document.getElementsByTagName('h1')[0]
eventos, listeners...
DOM acessar elementos html...
click, change, load e mouseover
element.classList.remove('classe')
Como poderia ser selecionado o elemento <p class=”paragrafo”>Texto de apresentação</p>?
class name paragrafo
CSS pelo js element.classList
*/

//Testes

/* 
// a função gets é implementada dentro do sistema para ler as entradas(inputs) dos dados
// Abaixo segue um exemplo de código que você pode ou não utilizar

let totalDeDias = parseInt(gets());

let qtdAnos, qtdMeses;

qtdAnos = parseInt(totalDeDias/365);
totalDeDias= totalDeDias % 365 ;

qtdMeses= parseInt(totalDeDias/30);
totalDeDias= totalDeDias % 30;

let resultado = (qtdAnos + " ano(s) " + '\n' + 
qtdMeses +" mes(es)" + '\n' +
totalDeDias + " dia(s)");

console.log(resultado);
*/











