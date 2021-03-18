#Base R, Principios Basicos.

install.packages(c("ggvis", "tm", "dplyr", "plyr", "sqldf", 'rbenchmark', 'tidyr', "ggplot2"))
library(ggvis)
library(tm)
library(dplyr)
library(plyr)
require(sqldf)
library(rbenchmark)
library(tidyr)
library(ggplot2)

# Funções Built-in
abs(-43)
sum(c(1:5))  #soma
mean(c(1:5)) #media
round(c(1.1:5.8)) #arredondar
rev(c(1:5)) #inverte
seq(1:5)
sort(rev(c(1:5))) #ordena
append(c(1:5), 6) #adciona


#Criando um vetor
vetor1 <- c(8,10,5,19,3,33,14,41,47,35,22,13)
vetorA <- c(20:30)
vetorB <- c(35:50)
class(vetor1)

#Criando matriz
matriz1 <- matrix(1:16,nrow = 4,ncol = 4, byrow = T)
class(matrix1)

#desfazendo e manipulando uma lista
lista1 <- list(vetor1,matriz1)
class(lista1)
lista2 <- list(a1 <- 3, a2 <- list(34, 23, 13, 16, 90, 56), a3 <- c(4, 67, 35, 67))
listaA <- list(vetorA, vetorB)
vetor2 <- unlist(lista2)
mean(unlist(lista2))
round(mean(unlist(lista2)))
class(lista2)
class(vetor2)

#Criando um D.Frame com arquivos importados
tabela1 <- data.frame(read.csv(file = "http://data.princeton.edu/wws509/datasets/effort.dat", header = TRUE, sep = ","))
##Analisando um D.Frame
iris
##Ver qnts dimenções tem o D.frame
dim(iris)
str(iris)
length(iris)

#Criando um plot"Grafico" especifico
plot(iris$Sepal.Length, iris$Sepal.Width)

#Criando subset
subset(iris, Sepal.Length > 7)
##opiando o D.Frame e criando um subset com os 15 primeiros registros e depois 15 linhas no meio
iris2 <- iris
iris1a15 <- subset(iris2[1:15,])
iris1a15.2 <- subset(iris2[8:23,])
#Usando o filtro
RSiteSearch("filter")
filter(iris2, Sepal.Length >	6)

## uma forma mais pratica de fazer loops, apply family

# apply()  - arrays e matrizes
# tapply() - os vetores podem ser divididos em diferentes subsets
# lapply() - vetores e listas
# sapply() - versõo amigÃ¡vel da lapply
# vapply() - similar a sapply, com valor de retorno modificado
# rapply() - similar a lapply()
# eapply() - gera uma lista
# mapply() - similar a sapply, multivariada
# by

## Se você estiver trabalhando com os objetos dica: 

# list, numeric, character (list/vecor) -> sapply ou lapply
# matrix, data.frame (agregação por coluna) -> by / tapply
# Operações por linha ou operações especificas -> apply

##Exemplo 1

##Criando função
listaC <- list(la = (10:20), lb = (35:50))

valor_a = 0
valor_b = 0
for (i in listaC$la){
  valor_a = valor_a + i
}
for (j in listaC$lb){
  valor_b = valor_b + j
}
print(valor_a)
print(valor_b)

ou
##sapply()
#list, numeric, character (list/vecor) -> sapply ou lapply
listaC
sapply(listaC, sum)
sapply(listaC, mean)

##apply() usado matriz ou d.frame, orientação e 1 para linha ou 2 coluna.
#Operaçõees por linha ou operaÃ§Ãµes especificas
matriz2 <- matrix(rnorm(9), nr = 4, byrow = T)
apply(matriz2, 1, sum) #soma linha
apply(matriz2, 2, sum) #soma colunas
apply(matriz2, 2, mean) 
apply(matriz2, 2, plot) 

##tapply
#matrix, data.frame (agregação por coluna)
#Criando d.frame
mediaEscola <- data.frame(
  Aluno = c("Rai","João","Lia","Maria","Carlos","Bia","Carla","Bento","Tici","Edu"),
  Nota1 = c(6,7,4,9,5,8,3,7,7,6),
  Nota2 = c(10,7,8,9,2,5,8,4,3,10),
  Nota3 = c(6,7,4,9,5,7,6,8,6,7),
  Nota4 = c(6,7,4,9,7,8,1,6,4,5)
  )
#adicionando coluna
mediaEscola$Media = NA
mediaEscola$Media = apply(mediaEscola[, c(2, 3, 4,5)], 1, mean)

#tapply() vs sqldf
mediaEscola2 <- data.frame(
  Aluno = c("Rai","João","Lia","Maria","Carlos","Rai","João","Lia","Maria","Carlos"),
  Semestre = c(1,1,1,1,1,2,2,2,2,2),
  Nota1 = c(6,7,4,9,5,8,3,7,7,6),
  Nota2 = c(10,7,8,9,2,5,8,4,3,10),
  Nota3 = c(6,7,4,9,5,7,6,8,6,7),
  Nota4 = c(6,7,4,9,7,8,1,6,4,5)
)
sqldf("select aluno, sum(Nota1), sum(Nota2), sum(Nota3), sum(Nota4) from mediaEscola2 group by aluno")
tapply(c(mediaEscola2$Nota1), mediaEscola2$Aluno, sum)

##by
sqldf("select aluno, sum(Nota1), sum(Nota2), sum(Nota3), sum(Nota4) from mediaEscola2 group by semestre")
by(mediaEscola2[, c(2, 3, 4, 5, 6)], mediaEscola2$Semestre, colSums)

##lapply()
lista4 <- list(a = (1:10), b = (45:77))
lista4
lapply(lista4, sum)
sapply(lista4, sum) #a diferénça e so a apresentação do formato


# vapply()
##A diferença e que eu formato a saida
##
?vapply
vapply(lista4, fivenum, c(Min. = 0, "1stQu." = 0, Median = 0, "3rd Qu." = 0, Max = 0))

##replicate
?replicate
replicate(7, runif(10))

##mapply()
?mapply
mapply(rep, 1:4, 4:1)

##rapply()
?rapply

lista2 <- list(a = c(1:5), b = c(6:10))
lista2

rapply(lista2, sum)
rapply(lista2, sum, how = "vetor")

#base exercicio2
#	Exercício	1	- Crie	uma	função	que	receba vetores	como	parâmetro,
# converta-os	em	um d.frame	e	imprima
funcao1 <- function(){
  vetor1.0 <- c("João","Rui","Ivo")
  vetor1.1 <- c(35,38,20)
  df1.0 <- data.frame(vetor1.0, vetor1.1)
  df1.0
}
funcao1()
#	Exercício	2	- Crie	uma	matriz	com	4	linhas	e	4	colunas	preenchida	com	números	inteiros
#e calcule	a	media	de	cada	linha
matriz1
mean(matriz1[1,])
mean(matriz1[2,])
mean(matriz1[3,])
mean(matriz1[4,])
#	Exercício	3	- Considere	o	dataframe	abaixo.	Calcule	a	media	por	disciplina
escola	<- data.frame(
  Aluno	=	c('Alan',	'Alice',	'Alana',	'Aline',	'Alex',	'Ajay'),
  Matemática	=	c(90,	80,	85,	87,	56,	79),
  Geografia	=	c(100,	78,	86,	90,	98,	67),
  Química	=	c(76,	56,	89,	90,	100,	87)
  )
mean(escola$Matemática)
mean(escola$Geografia)
mean(escola$Química)
#	Exercício	4	- Cria	uma	lista	com	3	elementos,	todos	numéricos	e	calcule	a	soma	de	todos	os	
#elementos	da	lista
elist1 <- list(c(4,9,6))
sum(elist1[[1]])

#	Exercício	5	- Transforme	a	lista	anterior	um	vetor
unelist1 <- unlist(elist1)
class(unelist1)
typeof(unelist1)

#	Exercício	6	- Considere	a	string	abaixo.	Substitua	a	palavra	textos	por	frases
str	<- c("Expressoes",	"regulares",	"em	linguagem	R",	
         "permitem	a	busca	de	padroes",	"e	exploracao	de	textos",
         "podemos	buscar	padroes	em	digitos",
         "como	por	exemplo",
         "10992451280")
str[5] <- "e	exploracao	de	frases"

#	Exercício 7	- Usando	o	dataset	mtcars,	crie	um	gráfico com	ggplot	do	tipo	scatter	plot.	Use	as	
#colunas	disp	e	mpg	nos	eixos	x	e	y	respectivamente
mtcars
ggplot(mtcars, aes(x=disp, y=mpg)) + 
  geom_point(
    color="blue",
    fill="#69b3a2",
    shape= 19,
    alpha= 0.6,
    size= 4,
    stroke = 2) +
  geom_point(
    color="grey",
    fill="#69b3a2",
    shape= 19,
    alpha= 0.6,
    size= 5,
    stroke = 2
  )

plot(wt, vs, main="Res. Exercicio")

#	Exercício 8	- Usando	o	exemplo	anterior,	explore	outros	tipos	de	gráfico
mtcars

ggplot(mtcars, aes(x=mpg, y=drat)) + 
  geom_point (color = "black" , size = 4.5 ) + 
  geom_point (color = "pink" , size = 4 ) + 
  geom_point ( aes (shape = factor ( cyl )))

plot(wt, qsec, panel.first = grid(8, 8), main="Res. Exercicio", pch=7, col = "purple")

plot(cyl,ylab="Cilindradas", panel.first = grid(8, 8), main="Res. Exercicio", pch=11, col = "red")



