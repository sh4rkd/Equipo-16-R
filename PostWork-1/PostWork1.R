data <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
datCasa<-data$FTHG
datVisitante<-data$FTAG
?table
####Parte 1
(tablaCasa<-table(datCasa))
#dimnames(tablaCasa)

(totalGoles<-table(datVisitante,datCasa))
(totalFrecAbsoluta <- sum(totalGoles))
(FrecRelCasa<-round (tablaCasa/totalFrecAbsoluta,4))

## Parte 2
(tablaCasa<-table(datVisitante))
(FrecRelVisitante<-round (tablaCasa/totalFrecAbsoluta,4))

###Parte3
(FrecRelCon<-round(totalGoles/totalFrecAbsoluta,4))
