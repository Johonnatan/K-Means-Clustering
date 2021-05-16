#Remove objetos da memória do R
rm(list=ls(all=TRUE))

#Instala bibliotecas necessarias
install.packages('cluster.datasets') #Biblioteca para chamar o conjunto de dataframe

#Carrega bibliotecas
library(cluster.datasets)

#Carrega o conjunto de dataframe
data(all.mammals.milk.1956)
dataframe <-all.mammals.milk.1956

#Visualiza sumario dos dados
summary(dataframe) 

#Adiciona o nome de cada animal ao nome da linha
rownames(dataframe) <- dataframe$name

#Exclui a coluna nome
dataframe$name <- NULL 

#Planta a semente
set.seed(1)

#Roda kmeans com sete clusters
k_means <- kmeans(dataframe,7)

#Observe os centroids
k_means$centers
k_means$cluster

#Roda algoritmo das componentes principais para reduzir a dimensao do conjunto de dataframe
pca <- princomp(dataframe,cor = T)
summary(pca)

#Plota grafico de dispersao
plot(y = pca$scores[,1],
     x = pca$scores[,2],
     xlab = 'Dimensao dois',
     ylab = 'Dimensao um',
     col = k_means$cluster,
     pch = 19,
     cex = 1, lty = "solid", lwd = 4)

#Traca linha de grade
grid()

#Rotula os pontos
text(pca$scores[,2], pca$scores[,1], labels= factor(all.mammals.milk.1956$name),
     cex= 0.7, pos=3)
