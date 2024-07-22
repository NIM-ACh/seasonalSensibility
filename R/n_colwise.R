#' Cuantos valores (sin NA) hay por columna
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Obten el tamaño muestral por cada columna de un data.table (es convertido a uno si no lo es), sin
#' contar aquellas observaciones con valores perdidos
#'
#' @param .data Un data.table. Si no lo es debe ser al menos un data.frame y despues es convertido a un data.table.
#' @param .cols Vector de nombre de columnas o función que devuelva un valor lógico evaluando la columna (e.g., is.numeric).
#' @param .by Una variable en base a la cual agrupar los análisis, por defecto no se usa ninguno.
#' @param char.only Lógico. El argumento `.by` debe tratarse como un carácter? Por defecto es `FALSE`. De lo contrario se trata como un nombre sin comillas.
#'
#' @return data.table con tamaños muestrales por cada columna y grupos especificados.
#'
#' @export

n_colwise <- function(.data, .cols = "all", .by, char.only = FALSE) {

  # A data.table si no lo es ya
  if (!"data.table" %chin% class(.data)) {
    .data <- data.table::as.data.table(.data)
  }

  if (identical("all", .cols)) {
    .cols <- rep(TRUE, times = ncol(.data))
  }

  j_lapply <- substitute(lapply(.SD, n_not_na))

  if (missing(.by)) {

    data.table::transpose(
      l = .data[j = eval(j_lapply), .SDcols = .cols],
      keep.names = "vars"
    )

  } else {

    if (isTRUE(char.only)) {
      if (!is.character(match.call()$.by)) {
        stop("when `char.only` = TRUE, `.by` MUST be character!")
      }
      by_chr <- .by

    } else if (isFALSE(char.only)) {

      if (is.character(match.call()$.by)) {
        stop("when `char.only` = FALSE, `.by` can NOT be character!")
      }
      by_chr <- deparse(substitute(.by))

    } else stop("`char.only` must be TRUE of FALSE only")

    data.table::transpose(
      l = .data[j = eval(j_lapply), by = by_chr, .SDcols = .cols],
      keep.names = "vars",
      make.names = by_chr
    )

  }
}

