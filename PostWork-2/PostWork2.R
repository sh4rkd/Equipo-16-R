df2017<- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
df2018<-read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
df2019<-read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
(lista <-list(df2017,df2018,df2019))
#lapply(lista,summary)
#lapply(lista,head)
library(dplyr)
lista_nueva <-lapply(lista, select, Date, HomeTeam, AwayTeam, FTHG, FTAG , FTR)

lapply(lista_nueva,head)
lista_nueva[[1]] <-rename(lista_nueva[[1]], Fecha = Date)
lista_nueva[[2]] <-rename(lista_nueva[[2]], Fecha = Date)
lista_nueva[[3]] <-rename(lista_nueva[[3]], Fecha = Date)

lista_nueva[[1]]<-mutate(lista_nueva[[1]],Fecha = as.Date(Fecha,"%d/%m/%Y"))
lista_nueva[[2]]<-mutate(lista_nueva[[2]],Fecha = as.Date(Fecha,"%d/%m/%Y"))
lista_nueva[[3]]<-mutate(lista_nueva[[3]],Fecha = as.Date(Fecha,"%d/%m/%Y"))


newData<-do.call(rbind,lista_nueva)
##install.packages("lubridate")
##library(lubridate)
##df1<-mutate(df1,Fecha = dmy(Fecha))
            