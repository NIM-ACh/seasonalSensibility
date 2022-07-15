
# Cargamos los paquetes -----------------------------------------------------------------------

  library(data.table) # Tratamiento y exportación intermedia de datos
  library(readxl)     # Leer archivo Excel

# Importamos los datos ------------------------------------------------------------------------

  ## Importamos desde el archivo excel (*.xlsx)
  dataset <- readxl::read_excel(path = "data-raw/raw_data.xlsx", sheet = "prep")

  ## Transformación a data.table
  data.table::setDT(dataset)

# Corrección de errores -----------------------------------------------------------------------

  ## La variable deporte debiera tener solo dos niveles, 1 y 0, sin embargo aparece un tercer ni-
  ## vel (2), que realmente corresponde a 0.
  dataset[, unique(deporte)] # Inspección y comprobación
  dataset[deporte == 2, deporte := 0] # Modificación
  dataset[, unique(deporte)] # Inspección y comprobación

  ## Para aquellos que relataron deporte 0, no debiera haber respuesta en otras respuestas rela-
  ## cionadas con el deporte.
  ind <- c("deporte_dias_semana", "deporte_intensidad", "deporte_minutos_sesion")
  lapply(dataset[deporte != 1 | is.na(deporte), .SD, .SDcols = ind], unique) # Inspección y comprobación
  dataset[deporte != 1 | is.na(deporte), (ind) := NA] # Modificación
  lapply(dataset[deporte != 1 | is.na(deporte), .SD, .SDcols = ind], unique) # Inspección y comprobación

# Manipulacion de variables -------------------------------------------------------------------

  ## Variables sociodemograficas
  dataset[, `:=`(
    genero              = factor(genero,              levels = 1:2, labels = c("Masculino", "Femenino")),
    edad                = factor(edad,                levels = 1:2, labels = c("18-35", "> 35")),
    deporte             = factor(deporte,             levels = 1:0, labels = c("Si", "No")),
    deporte_dias_semana = factor(deporte_dias_semana, levels = 1:3, labels = c("1 vez", "2 veces", "> 2 veces")),
    deporte_intensidad  = factor(deporte_intensidad,  levels = 1:3, labels = c("Baja", "Media", "Alta"))
  )]

  ## Sensibilidad estacional
  dataset[, `:=`(
    ss_patron_tipo = factor(ss_patron_tipo, levels = 1:3, labels = c("Verano", "Invierno", "Mixto")),
    ss_index       = factor(ss_index,       levels = 1:3, labels = c("Normal", "Winter blues", "SAD")),
    ss_severidad   = factor(ss_severidad,   levels = 0:5, labels = c("No es problema", "Leve", "Moderado", "Importante", "Severo", "Grave"))
  )]

  ## Adicion de etiquetas para tablas usando gtsummary
  dataset[, `:=`(
    # Variable                        # Idem                     # Atributo # Valor
    id                        = `attr<-`(id,                        "label", "ID"),
    genero                    = `attr<-`(genero,                    "label", "Genero"),
    edad                      = `attr<-`(edad,                      "label", "Edad"),
    deporte                   = `attr<-`(deporte,                   "label", "Realiza deporte"),
    deporte_dias_semana       = `attr<-`(deporte_dias_semana,       "label", "Sesiones por semana"),
    deporte_intensidad        = `attr<-`(deporte_intensidad,        "label", "Intensidad deporte"),
    deporte_minutos_sesion    = `attr<-`(deporte_minutos_sesion,    "label", "Duracion sesion (minutos)"),
    ss_patron_verano          = `attr<-`(ss_patron_verano,          "label", "Patron de verano"),
    ss_patron_invierno        = `attr<-`(ss_patron_invierno,        "label", "Patron de invierno"),
    ss_patron_tipo            = `attr<-`(ss_patron_tipo,            "label", "Tipo de patron"),
    ss_index                  = `attr<-`(ss_index,                  "label", "Seasonal Score Index"),
    ss_severidad              = `attr<-`(ss_severidad,              "label", "Severidad estacionaldiad"),
    riff_autoaceptacion       = `attr<-`(riff_autoaceptacion,       "label", "Autoaceptacion"),
    riff_relaciones_positivas = `attr<-`(riff_relaciones_positivas, "label", "Relaciones Positivas"),
    riff_autonomia            = `attr<-`(riff_autonomia,            "label", "Autonomia"),
    riff_dominio_entorno      = `attr<-`(riff_dominio_entorno,      "label", "Dominio Entorno"),
    riff_crecimiento_personal = `attr<-`(riff_crecimiento_personal, "label", "Crecimiento Personal"),
    riff_proposito_vida       = `attr<-`(riff_proposito_vida,       "label", "Proposito Vida")
  )]

# Guardamos los datos procesados --------------------------------------------------------------

  ## En forma de un CSV para exportación a otros programas
  data.table::fwrite(dataset, "data-raw/dataset.csv")

  ## De manera interna en el paquete
  usethis::use_data(dataset, overwrite = TRUE)
