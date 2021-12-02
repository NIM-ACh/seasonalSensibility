#' Sensibilidad estacional
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Datos del estudio de sensibilidad estacional que contiene variables sociodemográficas,
#' sensibilidad estacional, y de bienestar evaluadas mediante el cuestionario de bienestar
#' de Ryff
#'
#' @format Un data frame con 358 filas y 18 variables:
#'
#'   - \code{id}: Número identificador.
#'   - \code{genero}: Género del o la participante, Masculino o Femenino.
#'   - \code{edad}: Factor. Edad en años, 18-35 años o > 35 años.
#'   - \code{deporte}: Factor. Realiza deporte, Sí o no.
#'   - \code{deporte_dias_semana}: Factor. Cuantas veces a la semana realiza deporte, 1 vez,
#'   2 veces o ≥ 3 veces.
#'   - \code{deporte_intensidad}: Factor. Con que intensidad entrenas, Baja, Media o Alta.
#'   - \code{deporte_minutos_sesion}: Duración de la sesión en minutos.
#'   - \code{ss_patron_verano}: Patrón de verano, unidad adimensional.
#'   - \code{ss_patron_invierno}: Patrón de invierno, unidad adimensional.
#'   - \code{ss_patron_tipo}: Factor. Tipo de patrón estacional, Verano, Invierno o Mixto.
#'   - \code{ss_index}: Factor. Índice de puntaje estacional (SSI), Normal, Winter blues o SAD.
#'   - \code{ss_severidad}: Factor. Severidad del patrón estacional, No es problema, Leve,
#'   Moderado, Importante, Severo o Grave.
#'   - \code{riff_*}: Dominios del cuestionario de bienestar de Ryff. Entre los dominios se
#'   encuentran la 'Autoaceptacion' (`riff_autoaceptacion`), 'Relaciones positivas' (`riff_relaciones_positivas`),
#'   'Autonomía' (`riff_autonomia`), 'Dominio del entorno' (`riff_dominio_entorno`), 'Crecimiento personal'
#'   (`riff_crecimiento_personal`), así como 'Propósito en la vida' (`riff_proposito_vida`).
#'
#' @source Los datos son parte del estudio de sensibilidad estacional llevado a cabo por Matías Castillo-Aguilar y Cristián Núñez-Espinosa.
"dataset"
