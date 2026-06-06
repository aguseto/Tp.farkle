#-------------------------------------------------------------------------------
#       PROGRAMACIÓN 1 - TRABAJO PRÁCTICO - AÑO 2026
#-------------------------------------------------------------------------------
# 
# EQUIPO Nº xx:
# 
# - Apellido, nombre
# - Apellido, nombre
# - Apellido, nombre
# - Apellido, nombre
#
# ARCHIVO: jugar.R
#
# Este archivo debe ser ejecutado desde una terminal con la instrucción Rscript
# jugar.R, desde el directorio en el que esté guardado junto con cualquier otro
# archivo que sea creado como parte de la solución.
# 
# Agregar aquí cualquier comentario que consideren importante sobre la
# resolución del TP o sobre este archivo de código.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Paquete "farkle"
#-------------------------------------------------------------------------------

# El paquete "farkle" ofrece funciones auxiliares que simplifican muchas partes
# de la solución de este trabajo. Se recomienda leer la documentación con
# atención y correr los ejemplos.
# Las líneas de código que se encargan de la instalación del paquete no deben
# quedar en este script, pero sí la sentencia library para cargarlo.

# Instalación
install.packages("pak")
pak::pkg_install("ee-unr/programacion-1/tp/farkle")
library("farkle")

#-------------------------------------------------------------------------------
pantalla_inicio<- function(){
  titulo("Farkle")
  texto_lento("BIENVENIDOS

    Farkle es un juego de dados de estrategia y gestión de riesgo en el que dos juga
    dores
    
    compiten por alcanzar el puntaie máximo de 1000 puntos antes que su rival.
    La partida se desarrolla a lo largo de múltiples rondas. En cada una de estas rc
    ndas,
    
    los jugadores participan por turnos respetando un orden. Dentro de su turno,
    cada jugador puede lanzar los dados una o más veces, dependiendo del resultado c
    e cada tirada.
    
    REGLAS
    
    - Cada jugador comienza lanzando cinco dados.
    
    - Los (1) suman 100 puntos, y los (5) suman 50.
    
    - Luego de cada tirada, el jugador decide si plantarse o seguir tirando.
    - Si el jugador sigue tirando, lanza los dados que no sumaron puntos en la tira
    da anterior." )
}
###########################################################################################
###########################################################################################
seleccionar_jugadores<-function(){
  texto_lento("Antes de comenzar, ingrese los nombres de los jugadores\n")
  cat("Nombre jugador 1: ")
  jugador_1 <- leer_palabra()
  cat("Nombre jugador 2: ")
  jugador_2 <- leer_palabra()
  texto_lento("!Perfecto!")
  frase_con_nombres<- paste0("Van a jugar ", jugador_1, " contra ", jugador_2)
  texto_lento(frase_con_nombres)
  texto_lento("Estan listos?")
  
  continuar<-""
  while(tolower(continuar)!= "c"){
    texto_lento("Ingresa la tecla (c) para continuar.")
    continuar<-leer_palabra()
  }
  return(c(jugador_1, jugador_2))
}
###########################################################################################
###########################################################################################
titulo_ronda <- function(nro_ronda, nombres, puntos_totales){
  titulo(paste("RONDA", nro_ronda))
  cat("INFORMACION DE LA PARTIDA", "\n")
  cat("Jugador\tPuntos\n")
  cat("------\t------\n")
  cat(nombres[1], "\t", puntos_totales[1],"\n")
  cat(nombres[2], "\t", puntos_totales[2],"\n")
}
###########################################################################################
###########################################################################################
tirada_dado <- function(cantidad_dados){
  tirada <- tirar_dados(cantidad_dados)
  texto_lento("Salieron los siguientes dados:", mostrar_dados(tirada))
  unos <- contar_dados(tirada, 1)
  cincos <- contar_dados(tirada, 5)
  resultado <- (unos * 100)+(cincos * 50)
  #texto_lento("Sacaste", resultado, "puntos")
  dados_que_suman <- unos + cincos
  return(list(puntos = resultado, dados_usados = dados_que_suman))
}
###########################################################################################
###########################################################################################
turno2 <- function(jugador, puntos, tiradas = 0, acumulado = 0, dados_disponibles = 5){
  titulo_turno <-paste0("Turno de ", jugador," con ", puntos, " puntos." )
  titulo(titulo_turno) #Habria que utilizar variables para el nombre y el puntaje si no me equivoco
  cat("INFORMACION DEL TURNO", "\n")
  cat("Tiradas\tAcumulado\tDados disponibles\n")
  cat("------\t------\t-----------------\n")
  cat(tiradas, "\t", acumulado,"\t",dados_disponibles,"\n") #Tambien deberian ser variables, es provisorio
}
###########################################################################################
###########################################################################################
jugar_turno <- function(jugador, puntos_actuales){
  tiradas<-0
  acumulado <- 0
  dados_disponibles <- 5
  turno_activo <- TRUE
  
  while(turno_activo){
    limpiar_consola()
    
    turno2(jugador, puntos_actuales, tiradas, acumulado, dados_disponibles)
    
    cat("Tirar dados?\n - 1. Si\n - 2. No\n")
    cat("Ingresa un numero entre (1) y (2):\n")
    tirar <- leer_palabra()
    
    if (tirar=="2"){
      if((puntos_actuales + acumulado) > 1000){
        cat("\nTe pasaste de los 1000 puntos! El acumulado de este turno se pierde.\n")
        acumulado <- 0
      }
      turno_activo <- FALSE
      pausa("")
    }
    else if (tirar =="1"){
      resultado_dados <- tirada_dado(dados_disponibles)
      puntos_tirada <- resultado_dados$puntos
      dados_usados <- resultado_dados$dados_usados
      
      if(puntos_tirada == 0){
        cat("Sacate 0 puntos. \n No salieron ni 1 ni 5\n\n")
        acumulado <- 0
        turno_activo <- FALSE
      }
      else{
        cat("Sacaste", puntos_tirada, "puntos.\n\n")
        acumulado <- acumulado + puntos_tirada
        tiradas <- tiradas + 1
        dados_disponibles <- dados_disponibles - dados_usados
        
        if(dados_disponibles==0){
          cat("\n¡Usaste todos los dados! Recuperas los 5 para tu próxima tirada.\n")
          dados_disponibles <- 5
        }
      }
      pausa("Tiro finalizado.")
    }
  }
  return(acumulado)
}

###########################################################################################
###########################################################################################

nombres <- seleccionar_jugadores()
puntos_totales <- c(0,0)
nro_ronda <- 1
juego_activo <- TRUE

while(juego_activo){
  limpiar_consola()
  
  titulo_ronda(nro_ronda,nombres, puntos_totales)
  
  cat("Elige una opcion:\n - 1. Comenzar ronda\n - 2. Salir del juego\n")
  cat("Ingrese un numero entre (1) y (2):\n")
  opcion_menu <- leer_palabra()
  
  if (opcion_menu == "1"){
    for(i in 1:2){
      puntos_ganados <- jugar_turno(jugador=nombres[i], puntos_actuales = puntos_totales[i])
      puntos_totales[i] <- puntos_totales[i] + puntos_ganados
    }
    if(i==2){
      pausa("\nRonda finalizada.\n")
    }
  }
  nro_ronda <- nro_ronda + 1
}