# Atividade Final - Programação de Software Básico
## Turma 2 - Equipe 16
![Imagem do tema Assembly.]()

### Tópicos

* [Descrição da Atividade](#descrição-da-atividade)

* [Questões Resolvidas](#questões-resolvidas)

* [Acesso](#acesso)

* [Pré-requisitos](#pré-requisitos)

* [Orientações Para a Execução](#orientações-para-a-execução)

* [Desenvolvedores](#desenvolvedores)

## Descrição da Atividade
Exercício realizado com o intuito de consolidar os conhecimentos adquiridos ao longo do semestre letivo cursado do componente curricular ***MATA49*** da **Universidade Federal da Bahia**.

Os códigos desenvolvidos resolvem duas das dezesseis questões propostas na ***Atividade Final*** da disciplina ***Programação de Software Básico***.

### Questões Resolvidas:
- 1) Escreva um programa em _Assembly_ que calcule a área do círculo, o programa deve permitir ao usuário escolher se a entrada é o raio ou o diâmetro. ***OBS***: Utilizar ponto flutuante.

- 16) Escreva um programa em _Assembly_ que receba um número inteiro **N** e verifique se é um número de _Armstrong_ (um número é um número de _Armstrong_ se a soma dos seus dígitos elevados ao número de dígitos é igual ao próprio número). Imprima uma mensagem indicando se **N** é um número de _Armstrong_ ou não.

### Acesso
Você pode acessar diretamente os códigos desenvolvidos através da plataforma ***Replit*** clicando [aqui](https://replit.com/@zebaufba/FilipeFreitasandJoaoZeba-AtividadeFinal).

## Pré-requisitos
Para conseguir compilar e executar os programas, o usuário deve realizar as seguintes instalações em seu sistema operacional, ou máquina virtual, _Linux_ via terminal:

- **NASM:** ***sudo apt-get install nasm***;
- **LINKER:** ***sudo apt-get install binutils***;
- **GCC:** ***sudo apt-get install gcc***.

## Orientações Para a Execução
Inicie o terminal no diretório em que estão armazenados os arquivos com extensão **.asm** e execute o comando **nasm -f elf64 nomearquivo.asm && gcc nomearquivo.o -o nomearquivo -no-pie -lm**. Esse processo vai gerar o código objeto e o arquivo executável desejado.

Por fim, realize a execução do programa com o comando: **./nomearquivo**

**Obs.**: Substitua _"nomearquivo"_ de acordo com a questão que queira testar, ou seja, troque por _"questao1"_ ou _"questao16"_ ao executar os comandos descritos anteriormente.

## Desenvolvedores:
- Filipe dos Santos Freitas 
- João Gabriel Zeba de Souza
