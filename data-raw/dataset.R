
# Cargamos los paquetes -----------------------------------------------------------------------

library(usethis)    # Exportación de datos para uso final
library(data.table) # Tratamiento y exportación intermedia de datos
library(readxl)     # Leer archivo Excel

# Importamos los datos ------------------------------------------------------------------------

raw <- readxl::read_excel(path = "data-raw/raw_data.xlsx", sheet = "prep")

# Transformación a data.table -----------------------------------------------------------------

dataset <- data.table::as.data.table(raw)

# Error en la base de datos -------------------------------------------------------------------

## Se reporta

dataset[deporte == 2, deporte := 0]

# Manipulacion de variables -------------------------------------------------------------------

dataset[, `:=`(
  # Variables sociodemograficas
  genero              = factor(genero,              levels = 1:2, labels = c("Masculino", "Femenino")),
  edad                = factor(edad,                levels = 1:2, labels = c("18-35", "> 35")),
  deporte             = factor(deporte,             levels = 1:0, labels = c("Si", "No")),
  deporte_dias_semana = factor(deporte_dias_semana, levels = 1:3, labels = c("1 vez", "2 veces", "> 2 veces")),
  deporte_intensidad  = factor(deporte_intensidad,  levels = 1:3, labels = c("Baja", "Media", "Alta"))
)]

dataset[, `:=`(
  # Sensibilidad estacional
  ss_patron_tipo = factor(ss_patron_tipo, levels = 1:3, labels = c("Verano", "Invierno", "Mixto")),
  ss_index       = factor(ss_index,       levels = 1:3, labels = c("Normal", "Winter blues", "SAD")),
  ss_severidad   = factor(ss_severidad,   levels = 0:5, labels = c("No es problema", "Leve", "Moderado", "Importante", "Severo", "Grave"))
)]

dataset[, `:=`(
  # Adicion de etiquetas para tablas usando gtsummary
  # Variable                        # Idem                     # Atributo # Etiqueta
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

remove(raw)

# Guardamos los datos procesados --------------------------------------------------------------

data.table::fwrite(dataset, "data-raw/dataset.csv")
usethis::use_data(dataset, overwrite = TRUE)
