df <- read.csv("https://github.com/sh4rkd/Equipo-16-R/raw/master/PostWork-2/csv/total.csv")
datCasa<-df$FTHG
datVis<-df$FTAG
(FrecAbs<-table(datVis,datCasa))
sumaFrecAbs<-sum(FrecAbs)
(FrecRel<-round(FrecAbs/sumaFrecAbs,4))
#Pregunta 1.1
(ProbCasa<-round(table(datCasa)/sumaFrecAbs,4))
#Pregunta 1.2
(ProbVis<-round(table(datVis)/sumaFrecAbs,4))
#pregunta 1.3
FrecRel

#Pregunta 2.1
library(ggplot2)
barplot(ProbCasa,xlab="Goles anotados", ylab="Probabilidad", 
        main = "Probabilidad de anotar goles por el equipo de la casa",
        ylim =c(0,0.5),
        col = rgb(0.8,0.1,0.1,0.6))

#Pregunta 2.2
barplot(ProbVis,xlab="Goles anotados", ylab="Probabilidad", 
        main = "Probabilidad de anotar goles por el equipo visitante",
        ylim =c(0,0.5),
        col = rgb(0.8,0.1,0.1,0.6))

goles<-as.data.frame(FrecRel)

ggplot(goles, aes(x=datCasa, y=datVis,fill = Freq))+ 
  geom_tile()+ 
  geom_text(aes(label=round(Freq,4)))+
  scale_fill_gradient(low="white", high="blue") +
  labs(x="Numero de Goles de la Casa")+
  labs(y="Numero de Goles del Visitante")+
  labs(fill="Probabilidad")
