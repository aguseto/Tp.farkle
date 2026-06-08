# Farkle — Trabajo Práctico de Programación 1

**Equipo Nº 34** · Programación 1 · FCEyE · Universidad Nacional de Rosario · 2026

**Integrantes:**
- Assales, Giuliano Nicolas
- Leguizamon, Agustín Marcos
- Mondino, Franco
- Naiviat, Mauro

---

## ¿Qué es este proyecto?

Implementación en R del juego de dados **Farkle**, jugable desde la terminal entre dos jugadores. El juego combina suerte y toma de decisiones: en cada turno el jugador puede seguir tirando para acumular más puntos, pero se arriesga a perderlos todos si no saca ningún 1 ni 5.

El objetivo es llegar exactamente a **1000 puntos** antes que el rival.

---

## Reglas rápidas

- Cada jugador tira **5 dados** por turno.
- Un **1** vale 100 puntos, un **5** vale 50 puntos.
- Los dados que sumaron puntos se retiran; con los restantes se puede seguir tirando.
- Si una tirada no produce ningún 1 ni 5 -> **se pierden todos los puntos del turno**.
- Si se retiran todos los dados -> se puede volver a tirar con 5 dados o retirarse.
- Si el puntaje acumulado en el turno supera los 1000 -> **se pierde lo acumulado ese turno**.
- Si ambos jugadores llegan a 1000 en la misma ronda -> **empate**.

---

## Estructura del proyecto

```
proyecto/
├ ─ ─ jugar.R                    # Script principal, punto de entrada del programa
└ ─ ─ script_funciones_TP.R      # Definición de todas las funciones del juego
```

### Funciones implementadas

| Función | Descripción |
|---|---|
| `pantalla_inicio()` | Muestra bienvenida y reglas del juego |
| `seleccionar_jugadores()` | Solicita los nombres de los dos jugadores |
| `titulo_ronda()` | Muestra el estado de la ronda con puntajes actuales |
| `turno()` | Muestra el panel de información del turno en curso |
| `tirada_dado()` | Ejecuta una tirada y calcula los puntos obtenidos |
| `jugar_turno()` | Controla el ciclo completo del turno de un jugador |
| `verificar_final()` | Detecta si hay ganador o empate al final de cada ronda |

Todas las funciones están documentadas con el sistema **Roxygen**.

---

## Requisitos

- **R** ≥ 4.0 -> https://cran.r-project.org/bin/windows/base/
- **Rtools45** (Windows) -> https://cran.r-project.org/bin/windows/Rtools/rtools45/rtools.html
- Paquete **farkle** de la cátedra (ver instalación abajo)

---

## Instalación de dependencias

Ejecutar en la consola de R, en este orden:

```r
# 1. Instalar pak (gestor de paquetes)
install.packages("pak")

# 2. Instalar el paquete farkle de la cátedra
pak::pkg_install("ee-unr/programacion-1/tp/farkle")
```

---

## Cómo ejecutar el juego

1. Abrir una terminal en la carpeta del proyecto.
2. Ejecutar:

```bash
Rscript jugar.R
```

3. Seguir las instrucciones en pantalla para ingresar nombres y jugar.

---

## Notas de implementación

- El código está organizado de forma modular: `jugar.R` solo contiene el flujo principal del programa, mientras que toda la lógica del juego vive en `script_funciones_TP.R`.
- Se respeta la regla de empate: `verificar_final()` se llama siempre **después** de que ambos jugadores terminaron su turno en la ronda, de modo que el jugador 2 siempre tiene chance de igualar al jugador 1.
- La función `jugar_turno()` recibe el parámetro `es_ultimo` para manejar correctamente la pausa al final del turno según el orden de juego, sin depender de variables del entorno global.
