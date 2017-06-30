
## Archivo donde se pintaran graficas de las variables del dataset con el fin de analizarlas.

setwd("C:/Users/epifanio.mayorga/Desktop/Master/TFM") ## ruta curro
#setwd("C:/Users/Emoli/Desktop/Master/TFM/Dataset") ## ruta portatil


## Apertura del dataset
vuelos <- read.table("vuelosDeparted.csv", header = T, sep = ",")

str(vuelos)

## Eliminamos variables creadas al guardar el fichero
vuelos$X <- NULL

str(vuelos)
summary(vuelos)








## Graficas de variables
library(ggplot2)


#### VARIABLES CATEGORICAS 

## Funcion que calcula el retraso medio de los valores indicados en la variable de entrada numVuelos e informa
## de la cantidad de vuelos que ha realizado un avion.
## Devuelve un dataframe que almacena el valor de entrada, su retraso medio y el numero de apariciones (o vuelos)
mediasRetrasos <- function(numVuelos, muestra){
  vectorCodigos <- vector()
  vectorRetrasos <- vector()
  vectorNumeroVuelos <- vector()
  
  ## bucle for por cada codigo de vuelo
  for(i in 1:length(numVuelos)){
    
    vuelos <- muestra[muestra[,2]==numVuelos[i],]
    retrasoMedio <- 0
    
    if(length(vuelos[,1])>0){
      retrasoMedio <- mean(vuelos[,1])
    }
    
    vectorCodigos[i] = as.character(numVuelos[i])
    vectorRetrasos[i] = as.numeric(retrasoMedio)    
    vectorNumeroVuelos[i] <- length(vuelos[,1])
    
  }
  df <- as.data.frame(list(vectorCodigos,vectorRetrasos,vectorNumeroVuelos), col.names = c("codigo","retrasoMedio","numeroVuelos"))
  return(df)
}


#Airline_code
ggplot(vuelos,aes(airline_code,arrival_delay)) + geom_violin(scale = "count")


# Flight_number
df <- subset(vuelos, select = c("arrival_delay","flight_number"))
variables <- unique(df$flight_number)
mediaFlightNumber <- mediasRetrasos(variables,df)

barplot(mediaFlightNumber$retrasoMedio, names.arg = "Retraso Medio Flight_Number")
boxplot(mediaFlightNumber$retrasoMedio)
summary(mediaFlightNumber$retrasoMedio)
barplot(mediaFlightNumber$numeroVuelos, names.arg = "Numero Vuelos Flight_Number")
boxplot(mediaFlightNumber$numeroVuelos)
summary(mediaFlightNumber$numeroVuelos)

## APARTADO1: ¿El retraso medio de un numero de vuelo es mayor cuantos mas vuelos haya realizado?

## Probamos con numeros de vuelos con mas de 300 vuelos y con numeros de vuelos con menos de 12 vuelos
FNMayor300 <- mediaFlightNumber[mediaFlightNumber$numeroVuelos>300,]
barplot(FNMayor300$retrasoMedio, names.arg = "Retraso Medio Numeros Vuelo más de 300 vuelos")

FNMenor12 <- mediaFlightNumber[mediaFlightNumber$numeroVuelos<12,]
barplot(FNMenor12$retrasoMedio, names.arg = "Retraso Medio Numeros Vuelo menos de 12 vuelos")

summary(FNMayor300$retrasoMedio)
summary(FNMenor12$retrasoMedio)

## Nos damos cuenta de que a mayor numeros de vuelos realizados menor es el retraso medio para la variable Flight_Number
## Los retrasos medios para variables con mas de 300 vuelos se situan entre -11 y 11 minutos
## Los retrasos medios para variables con menos de 12 vuelos se situan entre -35 y 50 minutos


## APARTADO 2: ¿Un mayor retraso medio implica mayor cantidad de vuelos y viceversa?

summary(mediaFlightNumber$retrasoMedio)
## Obtenemos aquellos vuelos que tienen un retraso superior e inferior de lo normal (superior a 20 minutos e inferior
## a -15 minutos)
FNRetrasoSup20 <- mediaFlightNumber[mediaFlightNumber$retrasoMedio>20,]
FNRetrasoInf10 <- mediaFlightNumber[mediaFlightNumber$retrasoMedio<(-10),]

barplot(FNRetrasoSup20$numeroVuelos)
barplot(FNRetrasoInf10$numeroVuelos)

summary(FNRetrasoSup20$numeroVuelos)
summary(FNRetrasoInf10$numeroVuelos)
summary(mediaFlightNumber$numeroVuelos)

## Podemos afirmar que el numero de vuelos no afecta en el retraso medio ya que los datos analizados se encuentran fuera
## de la media de vuelos realizados por un avion y no son concluyentes.



# BoardPoint
df <- subset(vuelos, select = c("arrival_delay","board_point"))
variables <- unique(df$board_point)
mediaBoardPoint <- mediasRetrasos(variables,df)

# BoardLat
df <- subset(vuelos, select = c("arrival_delay","board_lat"))
variables <- unique(df$board_lat)
mediaBoardLat <- mediasRetrasos(variables,df)

# BoardLon
df <- subset(vuelos, select = c("arrival_delay","board_lon"))
variables <- unique(df$board_lon)
mediaBoardLon <- mediasRetrasos(variables,df)

# BoardCountryCode  
df <- subset(vuelos, select = c("arrival_delay","board_country_code"))
variables <- unique(df$board_country_code)
mediaBoardCC <- mediasRetrasos(variables,df)
  
# OffPoint 
df <- subset(vuelos, select = c("arrival_delay","off_point"))
variables <- unique(df$off_point)
mediaOffPoint <- mediasRetrasos(variables,df)

# OffLat
df <- subset(vuelos, select = c("arrival_delay","off_lat"))
variables <- unique(df$off_lat)
mediaOffLat <- mediasRetrasos(variables,df)

# OffLon
df <- subset(vuelos, select = c("arrival_delay","off_lon"))
variables <- unique(df$off_lon)
mediaOffLon <- mediasRetrasos(variables,df)
  
# OffCountryCode
df <- subset(vuelos, select = c("arrival_delay","off_country_code"))
variables <- unique(df$off_country_code)
mediaOffCC <- mediasRetrasos(variables,df)
  

# actual_time_of_departure

# actual_time_of_arrival


# AircraftType
df <- subset(vuelos, select = c("arrival_delay","aircraft_type"))
variables <- unique(df$aircraft_type)
mediaAircraftType <- mediasRetrasos(variables,df)

ggplot(vuelos,aes(aircraft_type,arrival_delay)) + geom_violin(scale = "count")
  
# AircraftRegistrationNumber
df <- subset(vuelos, select = c("arrival_delay","aircraft_registration_number"))
variables <- unique(df$aircraft_registration_number)
mediaAircraftRegistratioNumber <- mediasRetrasos(variables,df)
  
# Routing
df <- subset(vuelos, select = c("arrival_delay","routing"))
variables <- unique(df$routing)
mediaRouting <- mediasRetrasos(variables,df)

# MesSalida
df <- subset(vuelos, select = c("arrival_delay","mesSalida"))
variables <- unique(df$mesSalida)
mediaMesSalida <- mediasRetrasos(variables,df)
  
# DiaSalida
df <- subset(vuelos, select = c("arrival_delay","diaSalida"))
variables <- unique(df$diaSalida)
mediaDiaSalida <- mediasRetrasos(variables,df)

# HoraSalida 
df <- subset(vuelos, select = c("arrival_delay","horaSalida"))
variables <- unique(df$horaSalida)
mediaHoraSalida <- mediasRetrasos(variables,df)
  
# MesLlegada
df <- subset(vuelos, select = c("arrival_delay","mesLlegada"))
variables <- unique(df$mesLlegada)
mediaMesLlegada <- mediasRetrasos(variables,df)
  
# DiaLlegada
df <- subset(vuelos, select = c("arrival_delay","diaLlegada"))
variables <- unique(df$diaLlegada)
mediaDiaLlegada <- mediasRetrasos(variables,df)

# HoraLlegada
df <- subset(vuelos, select = c("arrival_delay","horaLlegada"))
variables <- unique(df$horaLlegada)
mediaHoraLlegada <- mediasRetrasos(variables,df)
  
# DiaSemanaSalida
df <- subset(vuelos, select = c("arrival_delay","diaSemanaSalida"))
variables <- unique(df$diaSemanaSalida)  
mediaDiaSemanaSalida <- mediasRetrasos(variables,df)

# DiaSemanaLlegada
df <- subset(vuelos, select = c("arrival_delay","diaSemanaLlegada"))
variables <- unique(df$diaSemanaLlegada)
mediaDiaSemanaLlegada <- mediasRetrasos(variables,df)










# Variables numericas
## graficas de retraso en base a variables numericas

# distance 

# departure_delay

# arrival_delay 

# act_blocktime 

# cabin_1_fitted_configuration 

# cabin_1_saleable   

# cabin_1_pax_boarded 

# cabin_1_rpk    

# cabin_1_ask   

# cabin_2_fitted_configuration 

# cabin_2_saleable

# cabin_2_pax_boarded  

# cabin_2_rpk   

# cabin_2_ask

# total_rpk  

# total_ask   

# load_factor 

# total_pax   

# total_no_shows   

# total_cabin_crew 

# total_technical_crew    

# total_baggage_weight 

# number_of_baggage_pieces  


ggplot(vuelos, aes(y = board_lat, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = board_lon, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = off_lat, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = off_lon, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = distance, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(x = arrival_delay, y = departure_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = act_blocktime, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = cabin_1_fitted_configuration, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = cabin_1_saleable, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = cabin_1_pax_boarded, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = cabin_1_rpk, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = cabin_1_ask, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = load_factor, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = total_pax, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = total_no_shows, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = total_cabin_crew, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = total_technical_crew, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = total_baggage_weight, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)
ggplot(vuelos, aes(y = number_of_baggage_pieces, x = arrival_delay)) + geom_point() + geom_smooth(method = "lm", se=TRUE, color="red", formula = y ~ x)


   