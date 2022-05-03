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

/* JAVA
não é uma palavra reservada Java - global
JVM (Java Virtual Machine) - e a maquina virtual do java responsavel.. ByteCodes .. compilador Java (Javac)
soft skill e uma hard skill respectivamente? - Liderança e Java 11
OpenJDK - Java SE
Java não possui - Não é orientada a objetos
documentar o código-fonte - pq facilita a manutenção e a leitura docodigo por outros devs
modificadores de acesso é correto - Protected - qualquer classe definida no msm pacoteou subclasse pode acessar um atributo ou método
estrutura de condição - é responsável por fazer o sedvio do fluxo de execução de um codigo de acordo com uma dada condição
Javadoc - é uma ferramenteta para documentação no formato HTML que se baseia nos comentários do codigo-fonte
estrutura de repetição - Repetir a execução de uma instrução ou um bloco de instruções até uma condição estiver sendo satisfeita
*/
/* 
vantagem da plataforma Java - não depender de apenas um unico software ou hardware, podendo se emulada por uma maquina virtual
Java JDK - é um kit de desenvolvimento java que inclui td o que é necessario para a construção de soluções nessa linguagem de programação
JVM - A Java virtual machina é a maquina virtuaç do java responsável por executar o bytecode (.class).
a importancia de um IDE - Prover um ambiente de dev completo, visando o ganho de produtividade e sinergia com os principais padrões e convenções do mercado
IDE - Ambiente de desenvolvimento integrado é um software que combina ferramentas comuns de dev em uma unica interface grafica do usuario (GUI) facilitando o dev de aps
outras linguagens da plataforma Java - Groovy, Jython e JRuby
IDEs Java - Intellij, eclipse e VSCode
JRE - Java Runtime Environment é o ambiente de execução multiplataforma que fornece as bibliotecas padrões do java para o jdk compilar o seu codigo a JVM executalo posteriormente
edições da distribuição Java - JAVA SE (Standar Edition), EE (Enterprise Edition), ME Micro Edition
JDK - Java Development Kit
*/
/* variaveis tipos de dados e operadores java
correta - "QUANTIDADE_$_OPCOES" é uma definição válida de variavél em java
correta aritmetico - Atribuições possuem a menor precedencia
tipo incorreto de dados - String é um tipo de dado primitivo
variaveis - o tipo de variavel é obrigatório
tipo de variaveis - classe pertencem a classe
não é uma variável aceita pela linguagem Java - 1abc
incorreto em dados - tipos de dado primitivos são heterogeneo
valor default errado - float é 0.0d
erro de compilação - float f = double
“10 - 5 * 2 + --i”, onde i = 3 é - 2
*/

/* Métodos java 
Um método deve ser público, sem retorno, se chamar xpto, tem um int como parâmetro  e ter corpo vazio. 
Baseado nessa especificação, qual é a definição correta?
- public void xpto(int i){}

CORRETA:
public void verifica(int i) {
   if (i > 1) {
     return “Maior”;
   } else {
     return “Menor”;   
   }
}
- Ocorre um erro de compilação, pois métodos "void" não têm retorno

qual não é uma sobrecarga válida?
public int avaliar()
- public int avalia(double i)

método INCORRETO
- Os parênteses são opcionais na definição de métodos

CORRETA:
public int verifica(int i) {...}
- "{return 0;}" é uma implementação vpalida

métodos INCORRETO
- métodos só podem ser utilizados a partir de classes, de forma estática

INCORRETO:
public double calcularTotalNota() {…}
- ele pode retornar um valor do tipo texto

método VERDADE
- tODO MÉTODO DEVE TER UM NOME

INCORRETA:
public String verifica(int idade) 
   if (idade > 18) {
     return “Maior de idade”;
   } else {
     return “Menor de idade”;   
   }
- O CORPO DO MÉTODO ESTÁ DEFINIDO CORRETAMENTE

Assinatura método CORRETO
- é constituida do nome e lista de parâmetros do método
*/
/* 
controle de fluxo - if não suporta expressões aritméticas

correto afirmar:
if (!b2)
              System.out.println("Verdade");
else {
           System.out.println("Mentira");
           System.out.println("Mentira");
}
- como o "if" tem só uma linha as {} são opcionais

controle de fluxo INCORRETO
- switch avalia expressões booleanas

int i1 = 10; float f1 = 4.5f; char c1 = "x";
boolean b1 = true;
Qual operação é válida?
- c1>i1

operadores relacionais - igualdade e menor

correta:

if ((10 + 15) < 20)
    System.out.println("Verdade");
else
    System.out.println("Mentira");
- O texto 	"Mentira" deve ser exibido

operadores lógicos, é correto - "!" corresponde a operação lógica "inversão"

expressões lógicas a seguir é válida
- (10>15)&&true
operadores relacionais INCORRETA
- = é o operador de igualdade
verdadeira - true ||false é true
*/
/*ARRAYs 
int[][] numeros = {{4, 9, 8, 5}, {3, 0, 1, 5}, {1, 2, 7, 4}};
System.out.print(numeros[2][2]);
será impresso - 7

String[] nomes = {"Camila", "Venilton", "Leonardo", "Renan", "Rafael"};
System.out.print(nomes.length);
será impresso - 5

int num = 5, count = 1;
        do {
            num += count;
            System.out.println(num);
        } while (count <= 3);
- looping infinito

int i, num = 5;
        for (i = 0; i < 3; i++) {
            num += i;
            System.out.print(i);
        }
- 012

int num = 5, count = 1;
        while(count <= 3) {
            ++count;
            num += count;
        }
        System.out.println(num);
- 14

arrays - permanecem com o mesmo tamanho em que foram criados

“É um objeto utilizado para armazenar sequencialmente dados do mesmo tipo.”
- array

As estruturas de repetição podem ser classificadas em:
- rept com teste no inicio (while), rept com teste no final (do-while), respt contada (for)

Estruturas de repetição
- uma estrutura que permite e execução de uma sequencia repetidamente caso determinadas condições sejam satisfeitas

Estruturas de repetição INCORRETA
- As estruturas de repetição podem ser classificadas em "while","do-while" e "array"
*/
/* Orientada a objetos
visibilidades - um método privado só é acessivel dentro da classe onde é definido
herança - é uma relação entre classes
interface é - uma forma de abstrair implementações, mas criar acordos de comunicação
sobre classes - pode não possuir atributos, métodos ou ambos
atributos tem ocmo finalidade - representar as caracteristicas das entidades do mundo real
associação - pode ocorrer em atributos e métodos
métodos - ações/serviços que as entidades podem fornecer
incorreto - objetos são intãncias de métodos e atributos
sobrecarga de métodos - para ocorrer, cria-se novos métodos com o mesmo nome, mas com parâmetros diferentes
Pacotes servem para - separar classes
*/
/* debugging na IDE Eclipse
Para interromper o Debug e fazer com que a execução prossiga até o final ou próximo breakpoint no IntelliJ
- Resume Program (F9)
onde é exibido as variáveis
- Variables
Sobre os atalhos da ferramenta de Debug no IntelliJ, julgue a alternativa correta:
- Debug (Shift+F9) - Step Over (F8) - Step Into (F7)
“Esta ferramenta provê acabamento de código como no editor, desta maneira é muito fácil introduzir qualquer expressão.”
- Evalue Expression
“Debugar o código” - depurar o codigo
principal funcionalidade da ferramenta de Debug
- Depurar a execução linha a linha do programa

correta acerca de Debugging:
I. Erros de Sintaxe: É um erro na "lógica do código".
II. Erros de Semântica: É um erro nas regras estabelecidas da linguagem.
III. Pilha de Execução: Toda invocação de método é empilhada em uma estrutura de dados que isola a área de memória de cada um.
- III está correta

usar o modo de Debug na IDE IntelliJ
- Executar o programa na opção "Debug as"
ponto de parada para fazer o Debug
- Breakpoints
"É a matriz onde encontramos a pilha de execução da exceção."
- Stack Trace
*/
/*
 “Unchecked Exception” 
 - O compilador não verifica o código para ver se a excessão foi tratada ou propagada
“Checked Exception”
- Se lançada, o compilador assegura que a exceção seré tratada (try/catch) ou propagada (throws)
hierarquia das exceptions, julgue a alternativa INCORRETA:
- IOException estende de RuntimeException
classe FileReader, qual das exceções abaixo precisamos tratar ou lançar?
- FileNotFoundException
I. Região onde se encontra o possível tratamento da exceção.
II. Região onde se encontra o código que queremos verificar se irá ou não lançar uma exceção.
III. Geralmente utilizado quando precisamos executar algum código independente se ocorrer exception ou não.
- catch, try, finally
"Usado pela JVM, serve para indicar quando existe algum problema em um recurso do programa, tornando a execução impossível de continuar."
- Error
String nome = "Camila";	
int nome2 = Integer.parseInt(nome);
qual Exception o programa irá apresentar?
- NumberFormatException
“É um evento que interrompe o fluxo normal de processamento de uma classe.”
- Exception
Sobre as “Exceptions Customizadas”, assinale a alternativa INCORRETA:
- Uma nova classe de exceção não precisa necessariamente estender de uma classe de exceção existente
alternativa que representa características apenas da cláusula “throws”:
I. É usada na assinatura do método
II. Necessária apenas para exceções checked.
III. É usada para lançar explicitamente uma exceção de um método ou de qualquer bloco de código.
IV. Informa ao chamador do método que este método pode lançar uma das exceções listadas no escopo do método.
- I, II, IV
*/
/* spring boot 
Qual conjunto de anotações define condições para injeção de dependências em uma classe por meio do conceito de auto configuration?
- Classes com a anotação @Conditional e nivel de classe, seguida das anotações do conjuntos de @Conditional (@ConditionalOnClass, @ConditionalonMissingBean, @ConditionalOnProperty)
Qual das alternativas abaixo não é verdadeira sobre o Spring Boot?
- Gera automaticamente um arquivo war como executável
Como é conhecido o arquivo gerado após o build do nosso projeto Spring Boot, que engloba todas dependências de projeto e está pronto para a execução ?
- fat/uber jar
Qual a finalidade da anotação @ConfigurationProperties em uma classe de configuração Java?
- Mapear propriedades que tem chaves e comum em um arquivo de configuração java
Quais são as formas de atribuir um valor de propriedade em um projeto Spring Boot, além do arquivo application.properties?
- Todas as alternativas estão corretas
Em um projeto Spring Boot, é necessário adicionar a URL de conexão com o banco de dados através da variável de ambiente DB_URL. Como podemos usar este valor no nosso arquivo application.properties?
- spring.datasource.url=${DB_URL}
No arquivo padrão application.properties, qual propriedade configuramos para indicar que desejamos utilizar o profile para o ambiente de desenvolvimento?
- spring.profiles.activate=dev
Em qual o diretório o application.properties é localizado por padrão em um projeto Spring Boot?
- src/main/resources
Qual dos problemas abaixo o Spring Boot resolve?
- Produtividade: disponibiliza, desde o começo, um projeto pronto para desenvolvimento e execução. Nenhuma configuração extra de arquivos web, banco de dados e suporte a transações é requerido
Ao subir nosso projeto Spring Boot é possível ver no log como o Auto Configuration detecta um recurso auto configurável. Como fazer para habilitar este recurso de visualização do log?
- Alterar a verbosidade no(s) pacote/s do spring para DEBUG ou TRACE. alem disso, podemos também incluir a propriedade "debug" igual a "true" no arquivo application.properties ou application.yml
*/
/* simplificando-projetos-java-com-o-spring-boot
Assinale a alternativa correta que melhor resume o Spring Boot?
- O Spring Boot é a soma do Spring Framework + Servidor Embutido (Tomcat ou Jetty) - XML <bean> Configuration ou @Configuraiton
O que melhor define um Bean?
- Uma bean é um objeto que é instanciado, montado e gerenciado por um container do Spring
Com base na pirâmide de testes podemos concluir que?
- testes de unidade requer um número maior de testes e tem baixo custo
O que é o Feign? Assinale a alternativa incorreta.
- O Feign é uma anotação do Spring Cloud que torna possivel realizar o consumo e integrações de APIs
O que melhor define o Spring Initializr
- O Spring Initializr fornece uma API extensível para gerar projetos baseados em JVM (JAva Virtual Machine) é onde podemos criar um projeto Spring Boot
O Auto-configuration do Spring Boot é responsável por?
- Configurar automaticamente a aplicação Spring com base nas dependencias jar adicionadas ao projeto
Ao utilizar o Swagger em nossa aplicação precisa definir as apis e caminhos disponíveis para documentar uma API, para isso usamos o?
- Docket
Quais as formas possíveis para aplicar injeção de dependências em projetos Spring?
- construtor, interface e setter
Qual o módulo do Spring Framework é responsável pela IoC/DI do Spring?
- Spring Core
O que a anotação @SpringBootTest faz?
- Diz ao Spring Boot para procurar uma classe de configuração principal e usá-lá para iniciar um contexto de aplicativo Spring
*/
/* Spring Framework com Spring Boot
Para que serve a annotation @Query?
- Serve para executar consultas SQL e SQL natival
Qual das opções abaixo é uma extensão de arquivo de configuração padrão do aplicativo quando estamos trabalhando com Spring Boot?
- .properties
Qual é a definição do Spring Data JPA?
- É parte da família maior do Spring Data, torna mais fácil implementar repositórios baseados em JPA
O que são os Starters do Spring Boot?
- São dependências que agrupam outras dependencias com um proposito em comum
Para que serve a annotation @Value?
- Para podermos atribuir valor padrão a uma propriedade de classe
Para que serve a annotation @ConfigurationProperties(prefix)?
- Uma maneira de incluir uma configuração externalizada e de fácil acesso a propriedades definidas em arquivos de propriedads
Sobre os conceitos bases do Java Persistence API, analise as afirmações abaixo e marque a alternativa correta:
I. É um recurso para aproximar o POO ao contexto de Bancos de Dados Relacionais.
II. É uma especificação baseada em interfaces, que através de um framework realiza operações de persistência de objetos em Java.
III. Hibernate, Eclipse link, Top Link, Open JPA.
- ORM, JPA, implementações JPA
Qual das alternativas abaixo contém o Starter correto para importarmos a dependência do SGBD PostgreSQL?
- <dependency><groupId>org.postgresql</groupld><artifactId>postgresql</artifa...></dependency>
Sobre os conceitos bases do Spring Framework, analise as afirmações abaixo e marque a alternativa correta:
I. O container do Spring IoC define uma instância do  objeto.
II. Será criado um novo objeto a cada solicitação ao container.
III. Um bean será criado para cada requisição HTTP.
IV. Cria um bean para o ciclo de vida do contexto da aplicação.
- Singleton, prototype, Http-Request,Http-Session, Application Scope
Para que serve a annotation @Scope?
- Utilizada para marcar o tempo de vida de um objeto gerenciado pelo container
*/
// - - - - - - DESAFIO 1 - - - - - - - - -

const PI = 3.14159;

let R = parseFloat(gets());

let Vol = (4.0/3)*PI*(R**3);

//TODO: Complete os espaços em branco com uma possível solução para o desafio

console.log("VOLUME = ", Vol.toFixed(3) );

// - - - - - - DESAFIO 2 - - - - - - - - -

let R = parseInt(gets());
let V = 0;

// Complete os espaços em branco com uma possível solução para o problema

while(true){
  V = parseInt(gets())
  if(R < V){
    break
  }
}

let cont = 1;
let it = R + 1;
while(true){
  cont++
  R = R + it;  
  if(V < R){
    //print(         )
    console.log(cont);
    break;
  }
  it++  
  
}

// - - - - - - DESAFIO 3 - - - - - - - - -

let totalItems = parseInt(gets());
let pares = [];
let impares = [];

for (let i = 0; i < totalItems ; i++) {
  let number = parseInt(gets());
  if (number % 2 === 0){
    pares.push(number);
  }
  else {
    impares.push(number);
  }
}
pares.sort((a, b) => a -  b );
impares.sort((a, b) => b -  a);
for(let i = 0; i < pares.length;i++){
  print(pares[i])
}
for(let i = 0; i < impares.length;i++){
  print(impares[i])
}

// - - - - - - JAVA - DESAFIO 1 - - - - - - - - -

import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int A, B, PROD;
		
		A = sc.nextInt();
		B = sc.nextInt();
		
		PROD =  A * B  ; //implemente o código que representa a multiplicação.
		
		System.out.println("PROD = " + PROD);
		
		sc.close();
		
	}
}

// - - - - - - JAVA - DESAFIO 2 - - - - - - - - -

import java.io.IOException;
import java.util.Scanner;

public class Desafio {
	
    public static void main(String[] args) throws IOException {
        Scanner leitor = new Scanner(System.in);
        int a = leitor.nextInt();
        int b = leitor.nextInt();
        int c = leitor.nextInt();
        int d = leitor.nextInt();
        int DIFERENCA;
        DIFERENCA = a * b - c * d;
        System.out.println("DIFERENCA = " + DIFERENCA);//complete
    }
	
}

// - - - - - - JAVA - DESAFIO 3 - - - - - - - - -

import java.io.IOException;
import java.util.Scanner;

public class  Desafio {
	
    public static void main(String[] args) throws IOException {
        Scanner leitor = new Scanner(System.in);
      //  int n = 0;
        double cont = 0, soma = 0, n = 0;
        n = leitor.nextInt();
        
        while(n > 0) {
          soma += n;
          cont++;
          n = leitor.nextInt();
        }
        double media = soma / cont;
        System.out.println(String.format("%.2f", media));
        // System.out.println("cont " + cont + " soma " + soma + " n " + n);
    }

}

// - - - - - - JAVA INTERMEDIARIO - DESAFIO 1 - - - - - - - - -

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
      Scanner sc = new Scanner(System.in);
      int a = sc.nextInt();
      if(a == 61){
          System.out.printf("Brasilia\n");
      }
      else if(a == 71){
          System.out.printf("Salvador\n");
      }
      else if(a == 11){
          System.out.printf("Sao Paulo\n");
      }
       else if(a == 21){
          System.out.printf("Rio de Janeiro\n");
      }
       else if(a == 32){
          System.out.printf("Juiz de Fora\n");
      }
       else if(a == 19){
          System.out.printf("Campinas\n");
      }
       else if(a == 27){
          System.out.printf("Vitoria\n");
      }
       else if(a == 31){
          System.out.printf("Belo Horizonte\n");
      }
       else{
           System.out.printf("DDD nao cadastrado\n");
       }
    }
    
}

// - - - - - - JAVA INTERMEDIARIO - DESAFIO 2 - - - - - - - - -
import java.io.IOException;
import java.util.Scanner;

public class Desafio {
	
    public static void main(String[] args) throws IOException {
        Scanner leitor = new Scanner(System.in);
        int x = leitor.nextInt();
        int cont = 0, soma = 0;

//continue a solucao de acordo com o solicitado no enunciado

        if (x % 2 == 0){    // se x for par aumenta 1 se for impar continua
        	x++;
        } 
        
        while (cont < 6) {
        cont++; 
         if (cont == 1) {               // se cont 1 executa
        		System.out.println(x);
        	} else {                      // demais soma 2
        		System.out.println(x+= 2);
            }
        }
    }
}

// - - - - - - JAVA INTERMEDIARIO - DESAFIO 3 - - - - - - - - -

import java.io.IOException;
import java.util.Scanner;

public class minhaClasse {
	
    public static void main(String[] args) throws IOException {
        Scanner leitor = new Scanner(System.in);
//declare suas variaveis corretamente
        int a = leitor.nextInt();
        int b = leitor.nextInt();
        int c = leitor.nextInt();
        int d = leitor.nextInt();        
        int e = leitor.nextInt();

        int par = 0, impar = 0, positivo = 0, negativo = 0;
        
        int[] n = {a, b, c, d, e};
        
      // remover e adicionar comentario, SHIFT ALT A (no vs)

/*  
  int[] n = new int[5]
  for(int i = 0; i < n.length; i++)
  int count = 0, numero;
  do {
    numero = leitor.nextInt();
    n.push(numero);
    count++;
  } while (count<5); */


//continue a solução
        for (int i : n){
          
        	if (i > 0){ // valor positivo ou negatio (0 não soma)
        	  positivo++;
        	} else if (i == 0){} else {
        	  negativo++;
        	}
        	if (i % 2 == 0){ // valor par ou impar (0 como par)
        	  par++;
        	} else {
        	  impar++;
        	}
        }
//insira suas variaveis corretamente
        System.out.println(par + " par(es)");
        System.out.println(impar + " impar(es)");
        System.out.println(positivo + " positivo(s)");
        System.out.println(negativo + " negativo(s)");
    }
	
}

// - - - - - - Projeto do Covid 19 PWA Progressive Web Application - - - - - - - - -

