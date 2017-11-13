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
names(pescaBajura) <- tolower(gsub("X","",names(pescaBajura)))
names(pescaBajura)

#Trim y casting de columnas numéricas con loop
library(stringr)
for (i in 3:14) {
  pescaBajura[[i]] <- str_trim(pescaBajura[[i]])
  class(pescaBajura[[i]]) <- "numeric"
}

#Unpivot del dataset
library(reshape2)
pescaBajuraUnpivot <- melt(pescaBajura, id.vars=c("unitatea.unidad","portuak.puertos"), variable.name = "anio", value.name = "valor")
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