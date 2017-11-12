#Creación del entorno de trabajo
if (!file.exists("D:/practicas_R/m3_actividad_colaborativa")){
  dir.create("D:/practicas_R/m3_actividad_colaborativa")
}

setwd("D:/practicas_R/m3_actividad_colaborativa")
getwd()

#Creación del directorio de datos
if (!file.exists("../datos")) {
 dir.create("../datos")
}

#Descarga del fichero
fileURL <- "http://www.nasdap.net/estadisticas/datos/Pesca_evolbajura_8516.csv"
download.file(fileURL,destfile="../datos/Pesca_evolbajura_8516.csv",method="auto")
list.files("../datos")

fechaDescarga <- date()

#Lectura del fichero
library(knitr)
pescaBajura <- head(read.table("../datos/Pesca_evolbajura_8516.csv",  skip = 1, row.names=NULL, sep=";", header=TRUE), -3)
head(pescaBajura)

#Limpieza de nombre de columnas
names(pescaBajura) <- gsub("X","",names(pescaBajura))
names(pescaBajura)

#Unpivot del dataset
library(reshape)
pescaBajuraUnpivot <- melt(pescaBajura, id=c("Unitatea.Unidad","Portuak.Puertos"))
head(pescaBajuraUnpivot)

#Cambio de nombre de columnas
names(pescaBajuraUnpivot)[3] <- c("Anio")
names(pescaBajuraUnpivot)[4] <- c("Valor")
head(pescaBajuraUnpivot)

#Creación del directorio de salida
if (!file.exists("../datos/output")) {
 dir.create("../datos/output")
 }

#Ecritura del fichero
write.table(pescaBajuraUnpivot,file="../datos/output/pescaBajuraTidy.csv", sep=";")

list.files("../datos/output")

#Comprobación
pescaBajuraTidyRead <- read.csv2("../datos/output/pescaBajuraTidy.csv")
head(pescaBajuraTidyRead)