library(seasonalSensitivity)
library(ggstatsplot)
library(ggplot2)


# Figure 1 ----------------------------------------------------------------

fig1 <- ggstatsplot::ggbarstats(
  data = dataset,
  x = ss_index,
  y = deporte_intensidad,
  results.subtitle = FALSE,
  caption = NULL,
  xlab = "Intensity",
  legend.title = "",
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = ggplot2::theme(plot.caption = ggplot2::element_blank(),
                                    legend.position = "top")
)

tiff(filename = "manuscript/figures/fig1.TIFF", width = 5, height = 7.5, units = "in", res = 450)
print(fig1)
dev.off()

pdf(file = "manuscript/figures/fig1.pdf", width = 5, height = 7.5)
print(fig1)
dev.off()

# Figure 2 ------------------------------------------------------------------------------------

xlevels <- c("No problem", "Mild", "Moderate", "Major", "Serious", "Severe")
a <- ggstatsplot::ggbarstats(
  data = data.table::copy(dataset)[, ss_severidad := `levels<-`(ss_severidad, xlevels)][],
  x = ss_index,
  y = ss_severidad,
  results.subtitle = FALSE,
  bf.message = FALSE,
  legend.title = "",
  xlab = "Severity",
  package = "ggsci",
  palette = "default_jama"
)

xlevels <- c("Summer", "Winter", "Mixed")
b <- ggstatsplot::ggbarstats(
  data = data.table::copy(dataset)[, ss_patron_tipo := `levels<-`(ss_patron_tipo, xlevels)][],
  x = ss_index,
  y = ss_patron_tipo,
  results.subtitle = FALSE,
  bf.message = FALSE,
  legend.title = NA,
  xlab = "Pattern",
  package = "ggsci",
  palette = "default_jama"
)

fig2 <- ggpubr::ggarrange(
  plotlist = list(a, b),
  nrow = 1,
  align = "hv",
  labels = paste0(LETTERS[1:2], "."),
  common.legend = TRUE
)

tiff(filename = "manuscript/figures/fig2.TIFF", width = 10, height = 7.5, units = "in", res = 450)
print(fig2)
dev.off()

pdf(file = "manuscript/figures/fig2.pdf", width = 10, height = 7.5)
print(fig2)
dev.off()

# Figure 3 ------------------------------------------------------------------------------------

a <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_autoaceptacion,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Self-acceptance",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
)

b <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_relaciones_positivas,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Positive relationships",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
)

c <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_autonomia,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Autonomy",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
)

d <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_dominio_entorno,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Environmental control",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
)

e <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_crecimiento_personal,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Personal growth",
  results.subtitle = FALSE,
  package = "ggsci",
  palette = "default_jama",
  ggplot.component = theme(plot.caption = element_blank())
)

f <- ggstatsplot::ggbetweenstats(
  data = dataset,
  x = ss_index,
  y = riff_proposito_vida,
  type = "np",
  p.adjust.method = "none",
  xlab = "",
  ylab = "Life purpose",
  package = "ggsci",
  palette = "default_jama",
  results.subtitle = FALSE
)

fig3 <- ggpubr::ggarrange(
  plotlist = list(a, b, c, d, e, f),
  ncol = 2, nrow = 3,
  align = "hv",
  labels = paste0(LETTERS[1:6], ".")
)

tiff(filename = "manuscript/figures/fig3.TIFF", width = 12, height = 16, units = "in", res = 450)
print(fig3)
dev.off()

pdf(file = "manuscript/figures/fig3.pdf", width = 12, height = 16)
print(fig3)
dev.off()

zip(
  zipfile = "manuscript/figures/figures.zip",
  files = list.files(
    path = "manuscript/figures/",
    pattern = "pdf$|tiff$",
    ignore.case = TRUE,
    full.names = TRUE
  )
)
