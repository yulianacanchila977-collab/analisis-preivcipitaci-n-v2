# ANÁLISIS DE PRECIPITACIÓN - INGENIERÍA
# ------------------------------------
# 1. Cargar librerías
# Si no están instaladas, la primera vez debes correr: install.packages("tidyverse")
library(tidyverse)
library(lubridate)
# 2. Cargar los datos
datos_lluvia <- read_csv("data/precipitacion_sucre.csv")
# 3. Procesamiento y análisis
analisis_mensual <- datos_lluvia %>%
  mutate(Mes = month(Fecha, label = TRUE, abbr = FALSE)) %>%
  group_by(Mes) %>%
  summarise(PrecipitacionTotal_mm = sum(Precipitacion_mm))
print("Resumen de precipitación mensual:")
print(analisis_mensual)
# 4. Visualización
grafico_precipitacion <- ggplot(analisis_mensual, aes(x = Mes, y = PrecipitacionTotal_mm)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(
    title = "Precipitación Mensual Total en la Estación 'La Mojana'",
    subtitle = "Año 2024 (Datos parciales)",
    x = "Mes",
    y = "Precipitación Total (mm)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(grafico_precipitacion)
# 5. Guardar el gráfico
if (!dir.exists("output")) dir.create("output")
ggsave("output/grafico_precipitacion_mensual.png", plot = grafico_precipitacion, width = 8, height = 6)
print("¡Análisis completado! El gráfico se ha guardado en la carpeta 'output'.")
