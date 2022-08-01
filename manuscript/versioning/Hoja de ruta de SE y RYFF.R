library(seasonalSensitivity)
library(pairwiseComparisons)

get_label <- function(test, md = FALSE) {
  z <- ifelse(md, "$Z_{~Dunn}_$ =", "Z =")
  p <- ifelse(md, "*p*", "p")
  test$statistic <- round(test$statistic, 2)
  test$p.value <- round(test$p.value, 3)
  test$statistic_label <- paste(z, test$statistic)
  test$p.value_label <- ifelse(test$p.value < 0.001, paste(p,"< 0.001"), paste(p, "=", test$p.value))
  test$label <- paste(test$statistic_label, test$p.value_label, sep = ", ")
  test[, c("group1", "group2", "label")]
}


# Significancias ------------------------------------------------------------------------------

## Autoaceptación
pairwiseComparisons::pairwise_comparisons(
  data = dataset,
  x = ss_index,
  y = riff_autoaceptacion,
  type = "np",
  p.adjust.method = "none"
) |> get_label()

## Autonomía
statsExpressions::oneway_anova(
  data = dataset,
  x = ss_index,
  y = riff_autonomia,
  type = "np"
)[, c("statistic", "df.error", "p.value", "method")]

pairwiseComparisons::pairwise_comparisons(
  data = dataset,
  x = ss_index,
  y = riff_autonomia,
  type = "np",
  p.adjust.method = "none"
) |> get_label()

# Dominio del entorno
pairwiseComparisons::pairwise_comparisons(
  data = dataset,
  x = ss_index,
  y = riff_dominio_entorno,
  type = "np",
  p.adjust.method = "none"
) |> get_label()

# Crecimiento personal
pairwiseComparisons::pairwise_comparisons(
  data = dataset,
  x = ss_index,
  y = riff_crecimiento_personal,
  type = "np",
  p.adjust.method = "none"
) |> get_label()

# Propósito de vida
pairwiseComparisons::pairwise_comparisons(
  data = dataset,
  x = ss_index,
  y = riff_proposito_vida,
  type = "np",
  p.adjust.method = "none"
) |> get_label()
