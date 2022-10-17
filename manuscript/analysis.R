# Cargamos paquetes y datos ----

library(seasonalSensitivity)
data("dataset", package = "seasonalSensitivity")


n_total <-  dataset[, .N]
print(n_total)
#> [1] 358

names(dataset)
#>  [1] "id"                        "genero"
#>  [3] "edad"                      "deporte"
#>  [5] "deporte_dias_semana"       "deporte_intensidad"
#>  [7] "deporte_minutos_sesion"    "ss_patron_verano"
#>  [9] "ss_patron_invierno"        "ss_patron_tipo"
#> [11] "ss_index"                  "ss_severidad"
#> [13] "riff_autoaceptacion"       "riff_relaciones_positivas"
#> [15] "riff_autonomia"            "riff_dominio_entorno"
#> [17] "riff_crecimiento_personal" "riff_proposito_vida"

# Clasificación de sensibilidad estacional ----

dataset[, list("n" = .N, "%" = round(.N/n_total, 3) * 100), ss_index]
#>        ss_index   n    %
#> 1:       Normal  86 24.0
#> 2:          SAD 216 60.3
#> 3: Winter blues  55 15.4
#> 4:         <NA>   1  0.3

# Realiza deporte ----

dataset[, list("n" = .N, "%" = round(.N/n_total, 3) * 100), deporte]
#>    deporte   n    %
#> 1:      Si 194 54.2
#> 2:      No 159 44.4
#> 3:    <NA>   5  1.4

# Age groups

dataset[, list("n" = .N, "%" = round(.N/n_total, 3) * 100), edad]
