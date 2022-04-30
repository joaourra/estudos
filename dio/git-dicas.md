# Aprendendo git
git init (inicializa/ instala os arquivos repositórios do git
clear (limpa a tela)


ls (mostra o que tem dentro da pasta)
dir (lista com cnteudo = ls)
ls -a (mostra pastas ocultas tbm)
cd receitas/ (entra na pasta
cd .. (volta uma pasta)

echo > README.md (cria um arquivo ou pasta)
mkdir receitas (cria a pasta receitas)
mv TAB... (move o arquivo ou pasta)

git config --list (lista de configurações)
git config --global user.name "..." 

git add * "..." (modified para stagy)(ou git add .)
git commit -m "mensagem" (resolve conflitos..)

git remote add origin "https://...." (salva origin link do gitHub)
git remote -v (lista as ações)

git push origin master (atualiza o gitHub)
git pull origin master (pucha pra sua maquina e ve onde tem orientação

## clonando repositório do github
git clone https://github.com/python/.....




md = Markdown
# Strogonoff de Palmito (=h1)
**Negrito** _italico_

### Ingredientes (=h3)
 - Lista
 - Lista


# Instalando

## Open JDK zulu busca no google
https://www.azul.com/downloads

## Instalando a JVM
**comando**
sudo apt install curl

## Instalando Java Version Manager (varias verções do java)
**site**
https://github.com/shyiko/jabba
**comando** macOS/Linux
curl -sl https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh

**comandos para usar**
jabba ls-remote

jabba install openjdk@1.11

jabba use openjdk@1.11

java -version

**Executando um programa em java**
_simples_
javac PrimeiroPrograma.java         // compila no mesmo local

java PrimeiroPrograma               // executa o programa


_criando pasta_
javac (compila -d joga pra pasta target) -source pasta

javac -d target/ -sourcepath src/ src/..caminhodo/MeuPrograma.java

vai para a pasta onde esta 
cd target/

e executa (com a referencia completa)
java com.dio.MyFirstProgram

