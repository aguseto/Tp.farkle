#-------------------------------------------------------------------------------
#       PROGRAMACIÓN 1 - TRABAJO PRÁCTICO - AÑO 2026
#-------------------------------------------------------------------------------
# 
# EQUIPO Nº 34:
# 
# - Assales, Giuliano Nicolas
# - Leguizamon, Agustín Marcos
# - Mondino, Franco
# - Naiviat, Mauro
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
#install.packages("pak")
#pak::pkg_install("ee-unr/programacion-1/tp/farkle")
library("farkle")

#-------------------------------------------------------------------------------
#=========== CARGAR FUNCIONES ==================================================

source("script_funciones_TP.R")

#=========== PROGRAMA ==================================================

pantalla_inicio()


###########################################################################################
###########################################################################################
jugar_turno <- function(jugador, puntos_actuales){
  tiradas<-0
  acumulado <- 0
  dados_disponibles <- 5
  turno_activo <- TRUE
  
  while(turno_activo){
    limpiar_consola()
    
    turno(jugador, puntos_actuales, tiradas, acumulado, dados_disponibles)
    
    tirar <- leer_opciones("¿Tirar dados?", "Si", "No")
    
    if (tirar == "2"){
      if((puntos_actuales + acumulado) > 1000){
        cat("\nTe pasaste de los 1000 puntos! El acumulado de este turno se pierde.\n")
        acumulado <- 0
      }
      turno_activo <- FALSE
      if(jugador != nombres[2]){
        pausa("Turno finalizado.")
      }
    }
    else if (tirar =="1"){
      resultado_dados <- tirada_dado(dados_disponibles)
      puntos_tirada <- resultado_dados$puntos
      dados_usados <- resultado_dados$dados_usados
      
      if(puntos_tirada == 0){
        cat("Sacaste 0 puntos. \nNo salieron ni 1 ni 5\n\n")
        acumulado <- 0
        turno_activo <- FALSE
        if(jugador != nombres[2]){
          pausa("Turno finalizado")
        }
      }
      else{
        acumulado <- acumulado + puntos_tirada
        tiradas <- tiradas + 1
        dados_disponibles <- dados_disponibles - dados_usados
        
        if((puntos_actuales + acumulado) > 1000){
          cat("Sacaste", puntos_tirada, "puntos.\n\n")
          cat("\nTe pasaste del puntaje maximo!\n")
          acumulado <- 0
          turno_activo <- FALSE
          if(jugador != nombres[2]){
            pausa("Turno finalizado")
          }
        }
        else{
          cat("Sacaste", puntos_tirada, "puntos.\n\n")
          
          if(dados_disponibles == 0){
            cat("\n¡Usaste todos los dados! Recuperas los 5 para tu próxima tirada.\n")
            dados_disponibles <- 5
            pausa("Tiro finalizado")
          }
          else{
            pausa("Tiro finalizado")
          }
        }
      }
    }
  }
  return(acumulado)
}
###########################################################################################
###########################################################################################

###########################################################################################
###########################################################################################

puntos_totales <- c(0,0)
nro_ronda <- 1
juego_activo <- TRUE

pantalla_inicio()
nombres <- seleccionar_jugadores()

while(juego_activo){
  limpiar_consola()
  
  titulo_ronda(nro_ronda,nombres, puntos_totales)
  
  opcion_menu <- leer_opciones("Elige una opcion:", "Comenzar ronda", "Salir del juego")
  
  if (opcion_menu[1] == "1"){    for(i in 1:2){
    puntos_ganados <- jugar_turno(jugador=nombres[i], puntos_actuales = puntos_totales[i])
    puntos_totales[i] <- puntos_totales[i] + puntos_ganados
  }
    
    hubo_ganador <- verificar_final(puntos_totales, nombres)
    if(hubo_ganador){
      break
    }
    
    pausa("\nRonda finalizada.")
    nro_ronda <- nro_ronda + 1
    
  } else if(opcion_menu[1]=="2"){
    break
  }
}




