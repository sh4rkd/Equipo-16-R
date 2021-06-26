library(dplyr)
library(ggplot2)
df <- read.csv("https://github.com/sh4rkd/Equipo-16-R/raw/master/PostWork-2/csv/total.csv")
datCasa<-df$FTHG
datVis<-df$FTAG
FrecAbs<-table(datVis,datCasa)
sumaFrecAbs<-sum(FrecAbs)
FrecRel<-round(FrecAbs/sumaFrecAbs,4)
ProbCasa<-round(table(datCasa)/sumaFrecAbs,4)
ProbVis<-round(table(datVis)/sumaFrecAbs,4)
listaCasa <- as.vector(ProbCasa)
listaVis <- as.vector(ProbVis)

#PostWork4 
#Parte1
M <- matrix(0,nrow = length(listaCasa), ncol = length(listaVis))
for (i in 1:9) {
  for (j in 1:7) {
    M[i,j] = round(listaCasa[i]*listaVis[j],4)
  }
}
(ProbCon<-as.matrix(FrecRel))

#class(ProbCon)
(ProbCon<-t(ProbCon))
##############################################
#Parte 2 
#Limpieza de Datos para obtener la media, cambiamos infty y NAN por la media 
IndepEst<-(round(M/ProbCon,3))
(IndepEst<-as.data.frame(IndepEst))
IndepEst <- IndepEst %>% mutate_if(is.numeric, function(x) ifelse(is.infinite(x), 0, x))
IndepEst$Freq[which(is.na(IndepEst$Freq))]<-mean(IndepEst$Freq,na.rm = TRUE)
IndepEst$Freq[IndepEst$Freq == 0]<-mean(IndepEst$Freq)
media = mean(IndepEst$Freq)
varianza = var(IndepEst$Freq)
##Bootstrap muestreo con reemplazo Suponiendo que la muestra de
#La frecuencia viene de una distribución normal 
set.seed(1200)
muestra<- rnorm(n=200,mean=media, sd=sqrt(varianza))
xbarra = mean(muestra)
bootstrap <- replicate(n=1000, sample(muestra,replace=TRUE))
(medias<-apply(bootstrap, MARGIN = 2, FUN = mean))

ggplot()+
  geom_histogram(aes(x=medias), bins = 50, color="black", fill = "cyan")+
  geom_vline(xintercept = xbarra, size = 1, color="darkred")
(var_estimada = sum((medias-xbarra)^2)/ncol(bootstrap))
media
xbarra
#De las muestras generadas aleatoriamente se puede concluir que al valor que tiende la
#media es a 0.8235 por lo tanto, los cocientes que estén cercanos a esta relación 
#se les puede considerar indpendientes estadísticamente hablando.
# Es decir, si son independientes quiere decir que la probabilidad de que el 
#equipo visitante anote 6 goles no depende de la probabilidad de que la casa anote 1 gol; 
#Sin embargo, en un sentido estricto, aunque la varianza muestral haya sido peque�a (0.00058) 
#y la media 0.82. Esto no asegura que Sean completamente independientes ya que estrictamente 
#se requiere que el cociente sea 1.
