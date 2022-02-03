library(seasonalSensitivity)
library(ggstatsplot)
library(ggplot2)

a <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_autoaceptacion,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Autoaceptación",
  ggplot.component = theme(plot.caption = element_blank())
)

b <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_relaciones_positivas,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Relaciones positivas",
  ggplot.component = theme(plot.caption = element_blank())
)

c <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_autonomia,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Autonomía",
  ggplot.component = theme(plot.caption = element_blank())
)

d <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_dominio_entorno,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Dominio del entorno",
  ggplot.component = theme(plot.caption = element_blank())
)

e <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_crecimiento_personal,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Crecimiento personal",
  ggplot.component = theme(plot.caption = element_blank())
)

f <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_proposito_vida,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Propósito de vida"
)

fig1 <- ggpubr::ggarrange(plotlist = list(a, b, c, d, e, f), ncol = 2, nrow = 3, align = "hv", labels = paste0(LETTERS[1:6], "."))

tiff(filename = "manuscript/figures/fig1.TIFF", width = 12, height = 16, units = "in", res = 450)
print(fig1)
dev.off()

pdf(file = "manuscript/figures/fig1.pdf", width = 12, height = 16)
print(fig1)
dev.off()
