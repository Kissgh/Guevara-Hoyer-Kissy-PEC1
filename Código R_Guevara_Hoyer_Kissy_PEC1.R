## -------------------------------------------------------------------------------------------------------------
human_cachexia <-
  read.csv("/Users/kissyguevara/Desktop/MASTER/DATOS OMICOS/PEC/PEC 1/human_cachexia.csv", stringsAsFactors=TRUE)


## -------------------------------------------------------------------------------------------------------------
library(SummarizedExperiment)
library(dplyr)
library(ggplot2)


## -------------------------------------------------------------------------------------------------------------
# Metadatos de las muestras
sample_metadata <- human_cachexia[, c("Patient.ID", "Muscle.loss")]

# Datos de características
feature_data <- human_cachexia[, -c(1,2)]
feature_matrix <- t(as.matrix(feature_data))

# Objeto SummarizedExperiment:
se <- SummarizedExperiment(
  assays = list(counts = feature_matrix),
  colData = sample_metadata,
  rowData = data.frame(feature_name = 
                         rownames(feature_matrix))
)

# Información general sobre el conjunto de datos:

metadata(se) <- list(
  description = "human_cachexia",
  source = "Repositorio GitHub",
  date = Sys.Date()
)


## -------------------------------------------------------------------------------------------------------------
se


## -------------------------------------------------------------------------------------------------------------
assay(se)


## -------------------------------------------------------------------------------------------------------------
colData(se)


## -------------------------------------------------------------------------------------------------------------
rowData(se)


## -------------------------------------------------------------------------------------------------------------
metadata(se)


## -------------------------------------------------------------------------------------------------------------
print(se)
cat("Número de características:", nrow(se), "\n")
cat("Número de muestras:", ncol(se), "\n")


## -------------------------------------------------------------------------------------------------------------
assays(se)$counts


## -------------------------------------------------------------------------------------------------------------
head(rownames(se)) # Primeros nombres de características
dimnames(se) # o todos los nombres de características estudiandas


## -------------------------------------------------------------------------------------------------------------
str(colData(se))


## -------------------------------------------------------------------------------------------------------------
str(rowData(se))


## -------------------------------------------------------------------------------------------------------------
summary(colData(se))


## -------------------------------------------------------------------------------------------------------------
summary(rowData(se))


## -------------------------------------------------------------------------------------------------------------
se[, se$Muscle.loss == "cachexic"]


## -------------------------------------------------------------------------------------------------------------
se[, se$Muscle.loss == "control"]


## -------------------------------------------------------------------------------------------------------------
table(colData(se)$Muscle.loss)


## -------------------------------------------------------------------------------------------------------------
ggplot(data.frame(colData(se)), aes(x = Muscle.loss)) +
  geom_bar() +
  labs(title = "Distribución de Muestras por Pérdida Muscular",
       x = "Pérdida Muscular", y = "Número de Muestras")


## -------------------------------------------------------------------------------------------------------------
summary(assay(se)[1:5,])


## -------------------------------------------------------------------------------------------------------------
metabolito <- "Glucose"
ggplot(data.frame(valor = assay(se)[metabolito,], grupo = colData(se)$Muscle.loss), 
       aes(x = grupo, y = valor)) +
  geom_boxplot() +
  labs(title = paste("Distribución de", metabolito, "por Pérdida Muscular"),
       x = "Pérdida Muscular", y = metabolito)


## -------------------------------------------------------------------------------------------------------------
metabolito <- "Pyruvate"
ggplot(data.frame(valor = assay(se)[metabolito,], grupo = colData(se)$Muscle.loss), 
       aes(x = grupo, y = valor)) +
  geom_boxplot() +
  labs(title = paste("Distribución de", metabolito, "por Pérdida Muscular"),
       x = "Pérdida Muscular", y = metabolito)


## -------------------------------------------------------------------------------------------------------------
Datos_Rda <- 
  file.path("/Users", "kissyguevara", "Desktop",
            "MASTER", "DATOS OMICOS", "PEC", "PEC 1")
save(se, file = file.path(Datos_Rda, "human_cachexia_data.Rda"))


## -------------------------------------------------------------------------------------------------------------
library(knitr)
purl("PEC1_ADO.Rmd", output =
       "/Users/kissyguevara/Desktop/MASTER/
     DATOS OMICOS/PEC/PEC 1/Guevara_Hoyer_Kissy_PEC1.R")

