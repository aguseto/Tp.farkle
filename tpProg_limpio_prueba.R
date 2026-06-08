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
#install.packages("pak")
#pak::pkg_install("ee-unr/programacion-1/tp/farkle")
library("farkle")

#-------------------------------------------------------------------------------
#=========== CARGAR FUNCIONES ==================================================

source("script_funciones.R")

#=========== PROGRAMA ==================================================

puntos_totales <- c(0,0)
nro_ronda <- 1
juego_activo <- TRUE

#pantalla_inicio()
nombres <- seleccionar_jugadores()

while(juego_activo){
  limpiar_consola()
  
  titulo_ronda(nro_ronda,nombres, puntos_totales)
  
  opcion_menu <- leer_opciones("Elige una opcion:", "Comenzar ronda", "Salir del juego")
  
  if (opcion_menu[1] == "1"){    for(i in 1:2){
    #COMENTAR SOBRE ESTO
    puntos_ganados <- jugar_turno(jugador=nombres[i], puntos_actuales = puntos_totales[i])
    puntos_totales[i] <- puntos_totales[i] + puntos_ganados
  }
    
    hubo_ganador <- verificar_final(puntos_totales, nombres)
    if(hubo_ganador){
      break
    }
    
    pausa("Ronda finalizada.")
    nro_ronda <- nro_ronda + 1
    
  } else if(opcion_menu[1]=="2"){
    break
  }
}




