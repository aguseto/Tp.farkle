#=========== DEFINICIÓN DE FUNCIONES ===========================================

#' Selección de jugadores
#' 
#' @description
#' Permite a los jugadores elegir el nombre que los va a representar durante el juego.
#' 
#' @details
#' Emite un mensaje indicandole a los jugadores que deben ingresar sus nombres, luego espera el input de los jugadores, seguido de un mensaje de confirmación de inicio.  
#'  
#' @returns
#' Vector de caracteres con los nombres de los jugadores.
#' 
seleccionar_jugadores<-function(){
  texto_lento("Antes de comenzar, ingrese los nombres de los jugadores\n")
  cat("Nombre jugador 1: ")
  jugador_1 <- leer_palabra()
  cat("Nombre jugador 2: ")
  jugador_2 <- leer_palabra()
  texto_lento("\n!Perfecto!")
  frase_con_nombres<- paste("Van a jugar", jugador_1, "contra", jugador_2)
  texto_lento(frase_con_nombres)
  pausa("Estan listos?")
  return(c(jugador_1, jugador_2))
}

#===============================================================================

#' Pantalla de información de ronda.
#'
#' @description 
#' Muestra una pantalla con información sobre el número de ronda actual y los nombres de los jugadores junto con sus respectivos puntos actuales.
#' 
#' @param nro_ronda Valor numérico con el número de ronda actual.
#' @param nombres Vector de caracteres con los nombres de los jugadores. 
#' @param puntos_totales Vector numérico con los puntos totales. 
#' 
#' @example 
#' titulo_ronda(2, c("Ana" , "Ale"), c(150, 500))
#'
titulo_ronda <- function(nro_ronda, nombres, puntos_totales){
  titulo(paste("RONDA", nro_ronda))
  cat("INFORMACION DE LA PARTIDA\n\n")
  cat("Jugador\tPuntos\n")
  cat("------\t------\n")
  cat(nombres[1], "\t", puntos_totales[1],"\n")
  cat(nombres[2], "\t", puntos_totales[2],"\n")
  cat("\n")
}

#===============================================================================

#' Tirada de dados
#' 
#' @description
#' Muestra una tirada con la cantidad de dados determinada y calcula la cantidad de puntos generados en la misma.
#'
#' @param cantidad_dados Valor numérico con el número de dados a lanzar.
#'
#' @returns
#' Entrega una lista de dos elementos, puntos (suma de puntos de la tirada) y dados usados (cantidad de dados que salieron 1 y/o 5)
#'
#' @examples
#' tirada_dado(5)
#' 
tirada_dado <- function(cantidad_dados){
  tirada <- tirar_dados(cantidad_dados)
  texto_lento("Salieron los siguientes dados:", mostrar_dados(tirada))
  unos <- contar_dados(tirada, 1)
  cincos <- contar_dados(tirada, 5)
  resultado <- (unos * 100)+(cincos * 50)
  dados_que_suman <- unos + cincos
  return(list(puntos = resultado, dados_usados = dados_que_suman))
}

#===============================================================================

#' Pantalla de información de turno
#' 
#' @description
#' Muestra una pantalla con el nombre del jugador e información sobre sus puntos totales, acumulados, número de tirada actual y dados disponibles para lanzar.
#'
#' @param jugador Caracteres con el nombre del jugador.
#' @param puntos  Valor numérico con los puntos totales actuales del jugador. 
#' @param tiradas Valor numérico con el numero de tirada.
#' @param acumulado Valor numérico con la cantidad de puntos acumulados en la ronda actual.
#' @param dados_disponibles Valor numérico con la cantidad de dados disponibles para lanzar.
#'
#' @examples
#' turno("Ana", 150)
turno <- function(jugador, puntos, tiradas = 0, acumulado = 0, dados_disponibles = 5){
  titulo_turno <-paste0("Turno de ", jugador," con ", puntos, " puntos." )
  titulo(titulo_turno) 
  cat("INFORMACION DEL TURNO\n\n")
  cat("Tiradas\tAcumulado\tDados disponibles\n")
  cat("--------\t--------\t-----------------\n")
  cat(tiradas, "\t", acumulado,"\t",dados_disponibles,"\n\n")
}

#===============================================================================

#' Verificación de ganador.
#' 
#' @description
#' Determina si hay un ganador o empate.
#' 
#' @details
#' Evalua si uno o ambos jugadores tienen 1000 puntos totales, entrega un TRUE o FALSE en funcion de ello, e imprime un mensaje de victoria en caso de ser verdadero. 
#'
#' @param puntos_totales Vector numérico con la cantidad de puntos totales de los jugadores.
#' @param nombres Vector de caracteres con los nombres de los jugadores.
#'
#' @returns
#' BOOLEANO (TRUE O FALSE)
#'
#' @examples
#' verificar_final(c(1000, 750), c("Ana" , "Ale"))
#' 
verificar_final <- function(puntos_totales, nombres) {
  if (puntos_totales[1] == 1000 && puntos_totales[2] == 1000) {
    titulo("EMPATE")
    return(TRUE)
  } else if (puntos_totales[1] == 1000) {
    titulo(paste("GANO", nombres[1]))
    return(TRUE)
  } else if (puntos_totales[2] == 1000) {
    titulo(paste("GANO", nombres[2]))
    return(TRUE)
  }
  return(FALSE)
}

#===============================================================================

#' Pantalla de inicio.
#' 
#' @description
#' Muestra un mensaje de bienvenida junto con la introducción y reglas del juego Farkle.
#' 
pantalla_inicio<- function(){
  titulo("F A R K L E")
  texto_lento("BIENVENIDOS
Farkle es un juego de dados de estrategia y gestión de riesgo en el que dos jugadores
compiten por alcanzar el puntaje máximo de 1000 puntos antes que su rival.
La partida se desarrolla a lo largo de múltiples rondas. En cada una de estas rondas,
los jugadores participan por turnos respetando un orden. Dentro de su turno,
cada jugador puede lanzar los dados una o más veces, dependiendo del resultado de cada tirada.\n\n
REGLAS
 - Cada jugador comienza lanzando cinco dados.
 - Los (1) suman 100 puntos, y los (5) suman 50.
 - Luego de cada tirada, el jugador decide si plantarse o seguir tirando.
 - Si el jugador sigue tirando, lanza los dados que no sumaron puntos en la tira
da anterior.
 - Si en una tirada el jugador no suma puntos, pierde todo lo acumulado en ese turno.\n\n
EVENTOS ESPECIALES
 - Si en una tirada todos los dados suman puntos, el jugador puede volver a tirar con cinco dados.
 - Si en una tirada el jugador supera el puntaje maximo, pierde todo lo acumulado en ese turno.
 - Si ambos jugadores alcanzan el puntaje maximo en la misma ronda, se considera empate.\n")
}
