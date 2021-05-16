
rm(list=ls(all=TRUE)) #Remove objetos da memória do R

#Instala bibliotecas necessarias
install.packages('cluster.datasets') #Biblioteca para chamar o conjunto de dados

#Carrega bibliotecas
library(cluster.datasets)

#Carrega o conjunto de dados leite de mamiferos para a memoria
data(all.mammals.milk.1956)
dados <-all.mammals.milk.1956

summary(dados) #Visualiza resumo descritivo das variaveis

rownames(dados) <- dados$name #Adiciona o nome de cada animal ao nome da linha

dados$name <- NULL #Exclui a coluna nome, pois nos algoritmos de clusters so entram variaveis numericas ou factor

set.seed(10)
#Roda kmeans com sete clusters
k_means <- kmeans(dados,7)
k_means

#Observe o valor medio de cada variavel em cada cluster (centroids)
#Uma boa clusterizacao deve ter centroids mais diferentes possiveis de um cluster para outro
#Se os centroidos de dois ou mais clusters estiverem com valores muito parecidos é indicativo que os clusters nao estao bem separados
k_means$centers
k_means$cluster

#Roda algoritmo das componentes principais para reduzir a dimensao do conjunto de dados
pca <- princomp(dados,cor = T)
summary(pca)
pca$scores

#Plota grafico de dispersao com a primeira componente principal no eixo y e segunda componente principal no eixo X e colore por cluster
#Observe pela cor se os pontos estao bem separados, caso nao rode o kmeans novamente com outra quantidade de cluster
plot(y = pca$scores[,1],
     x = pca$scores[,2],
     xlab = 'Dimensao dois',
     ylab = 'Dimensao um',
     col = k_means$cluster,
     pch = 19,
     cex = 1, lty = "solid", lwd = 4)
grid()
text(pca$scores[,2], pca$scores[,1], labels= factor(all.mammals.milk.1956$name),
     cex= 0.7, pos=3)
