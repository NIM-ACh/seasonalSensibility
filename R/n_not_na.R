#' Cuenta el número de elementos que no son valores perdidos
#'
#' @description
#' `r lifecycle::badge('experimental')`
#'
#' Esta función suma la cantidad de valores que no son NA, utilizando
#' un algoritmo sencillo y fácil de implementar.
#'
#' @param x Un vector numérico.
#'
#' @return Número entero.
#'
#' @export

n_not_na <- function(x) {
  sum(!is.na(x))
}
