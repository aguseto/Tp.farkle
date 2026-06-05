library("farkle")

############################################################################################
#Tirar dado
############################################################################################

tirada_dado <- function(){
  tirada <- tirar_dados(5)
  texto_lento("Salieron los siguientes dados:", mostrar_dados(tirada))
  unos <- contar_dados(tirada, 1)
  cincos <- contar_dados(tirada, 5)
  resultado <- (unos * 100)+(cincos * 50)
  texto_lento("Sacaste", resultado, "puntos")
  }

tirada_dado()

############################################################################################
#Turno
############################################################################################

turno1 <- function(){
  titulo("Turno de Jugador_1 con 0 puntos") #Habria que utilizar variables para el nombre y el puntaje si no me equivoco
  cat("INFORMACION DEL TURNO", "\n")
  cat("Tiradas\tAcumulado\tDados.disponibles\n")
  cat("------\t------\t-----------------\n")
  cat("0\t0\t5\n") #Tambien deberian ser variables, es provisorio
}


turno1()

############################################################################################
#Ronda
############################################################################################

titulo_ronda <- function(){
  titulo("RONDA 1")
  cat("INFORMACION DE LA PARTIDA", "\n")
  cat("Jugador\tPuntos\n")
  cat("------\t------\n")
  cat("Jugador1\t0\n")
  cat("Jugador2\t0\n")
}

titulo_ronda()

# 
# Si encuentran una mejor forma de separar las cadenas de texto de una forma mas prolija proponganlo
# 
############################################################################################
#Comenzar ronda
############################################################################################

comenzar_ronda <- function(){
  opcion <- leer_opciones("Elige una opcion", "Comenzar ronda", "Salir del juego")
  if(opcion == 1){
    limpiar_consola()
    turno1() #Se deberia ejecutar la totalidad del turno, tanto titulo como opcion de tirar dados y tirada de dados
  }else { #Esta incompleto, no vi o me pase un ejemplo en el caso de que se quiera salir del juego
  quit()  #Asumo que se cerrara el programa, con alguna funcion como quit o q()
  }
}

comenzar_ronda()
