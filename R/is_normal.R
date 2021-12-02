#' Comprueba si un vector numérico sigue una distribución normal
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Basado en el tamaño muestral, comprueba analíticamente si un vector numérico
#' sigue una distribución normal, para el rechazo de la hipótesis nula usa un alfa
#' del 0.05 o 5%. Si el tamaño muestral es menor o igual a 50 usa la prueba de
#' Shapiro-Wilk, y en caso contrario la prueba de Kolmogorov-Smirnov con corrección
#' de Lilliefors del paquete `nortest`
#'
#' @param x Un vector numérico.
#' @param alpha El valor de alfa para el rechazo de la hipótesis nula de normalidad. Por defecto es 0.05.
#' @param test Una función que acepte a `x` y devuelva un valor-p para ser contrastado con `alpha`. Por
#' defecto se escoge basado en el tamaño muestral.
#'
#' @export

is_normal <- function(x, alpha = 0.05, test = NULL) {
  x <- x[!is.na(x)]
  if (is.null(test)) {
    if (length(x) <= 50) {
      test <- function(i) stats::shapiro.test(i)$p.value
    } else {
      test <- function(i) ks_test(i)$p.value
    }
  }
  test(x) > alpha
}

#' Comprueba si las columnas de un conjunto de datos siguen una distribución normal
#'
#' @description
#' `r lifecycle::badge('experimental')`
#'
#' Wrapper alrededor de `is_normal` aplicando la función de manera iterativa sobre un
#' conjunto de datos, especificamente sobre las variables numéricas. Se puede aplicar
#' agrupando por un factor
#'
#' @param .data Un data.table. Si no lo es debe ser al menos un data.frame y despues es convertido a un data.table.
#' @param ... Argumentos traspasados a `is_normal`.
#' @param .by Una variable en base a la cual agrupar los análisis, por defecto no se usa ninguna.
#' @param char.only Lógico. El argumento `.by` debe tratarse como un carácter? Por defecto es `FALSE`. De lo contrario se trata como un nombre sin comillas.
#'
#' @return Logical
#'
#' @export

is_normal_colwise <- function(.data, ..., .by, char.only = FALSE) {

  # A data.table si no lo es ya
  if (!"data.table" %chin% class(.data)) {
    .data <- data.table::as.data.table(.data)
  }

  j_lapply <- substitute(lapply(.SD, is_normal, ...))

  if (missing(.by)) {

    data.table::transpose(
      l = .data[j = eval(j_lapply), .SDcols = is.numeric],
      keep.names = "vars"
    )

  } else {

    if (isTRUE(char.only)) {
      if (!is.character(match.call()$.by)) {
        stop("when `char.only` = TRUE, `.by` MUST be character!")
      }
      by_chr <- .by
      .by <- as.name(.by)
    } else if (isFALSE(char.only)) {
      if (is.character(match.call()$.by)) {
        stop("when `char.only` = FALSE, `.by` can NOT be character!")
      }
      by_chr <- deparse(substitute(.by))
    } else stop("`char.only` must be TRUE of FALSE only")

    i_arg <- substitute(!is.na(.by))

    data.table::transpose(
      l = .data[i = eval(i_arg), j = eval(j_lapply), by = by_chr, .SDcols = is.numeric],
      make.names = by_chr,
      keep.names = "vars"
    )
  }
}

