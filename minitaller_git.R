#### new modification
#### testing with multiple accounts in same pc
# minitaller Git
# Example to use with Git
# Marco A. Ámez
# MUE team
# Project SAP
# IEO

# load libraries
library(sapmuebase)
library(dplyr)
library(ggplot2)

# ═> Import catches table ----
# This dataset contains fictional data of fisheries catches
ficticional_catches <- importCsvSAPMUE("fictional_catches.csv")
ficticional_catches$COD_ESP_MUE <- as.factor(ficticional_catches$COD_ESP_MUE)
ficticional_catches$COD_PUERTO <- gsub("\\s", "0", format(ficticional_catches$COD_PUERTO, width=4, justify="right"))
ficticional_catches$COD_PUERTO <- as.factor(ficticional_catches$COD_PUERTO)
  
# ═> Select the 10 species with more catches ----
ranking <- ficticional_catches %>%
  select(COD_ESP_MUE, P_DESEM) %>%
  group_by(COD_ESP_MUE) %>%
  summarise(P_DESEM = sum(P_DESEM)) %>%
  arrange(desc(P_DESEM))

species_10 <- ranking[1:10, "COD_ESP_MUE"]$COD_ESP_MUE

# ═> get the catches of this species_10 ----
catches_10 <- ficticional_catches[which(ficticional_catches$COD_ESP_MUE %in% species_10),]

# ═> Plot catch by species_10 ----
ggplot(data = catches_10, aes(x=COD_ESP_MUE, y=P_DESEM)) +
  geom_bar(stat="identity") + 
  ggtitle("Catches by species")

# ═> Plot catch by harbour ----
ggplot(data = catches_10, aes(x=COD_PUERTO, y=P_DESEM)) +
  geom_bar(stat="identity") + 
  ggtitle("Catches by harbour")





