library("readxl")
library("dplyr")
library("tidyr")

municipiosSIAFI <- read_excel(path = "./download/SIAFI.xlsx")
municipiosSIAFI <- municipiosSIAFI %>% filter(`C�DIGO IBGE` != "0000000")
municipiosSIAFI <- municipiosSIAFI %>% select(`C�DIGO SIAFI`, `C�DIGO IBGE`) %>% rename(codigo_siafi = `C�DIGO SIAFI`, codigo_ibge = `C�DIGO IBGE`)

municipiosIBGE <- read_excel("download/IBGE.xls")
colnames(municipiosIBGE) <- gsub(" ", "_", tolower(names(municipiosIBGE)))

municipiosIBGE <- municipiosIBGE %>% 
        select(nome_uf, nome_mesorregi�o, nome_microrregi�o, nome_munic�pio, uf, munic�pio, c�digo_munic�pio_completo) %>%
        rename(nome_mesorregiao = nome_mesorregi�o, 
               nome_microrregiao = nome_microrregi�o, 
               nome_municipio = nome_munic�pio, 
               codigo_ibge_municipio = munic�pio, 
               codigo_ibge_uf = uf,
               codigo_ibge = c�digo_munic�pio_completo
        ) %>% mutate(nome_municipio = toupper(nome_municipio))

municipios <- municipiosIBGE %>% inner_join(municipiosSIAFI)

write.csv(municipios, "output/municipios.csv", na = "", row.names = FALSE)

faixaCeps <- read.csv2("download/CEP.csv", sep = ",", encoding = "UTF-8") %>% select(idIBGE, postalCode_ranges)
faixaCeps <- faixaCeps %>% mutate(postalCode_ranges = gsub("[^[:alnum:] ]", "", postalCode_ranges)) %>% rename(codigo_ibge = idIBGE)
faixaCeps <- faixaCeps %>% separate(postalCode_ranges, c("inicio_cep", "fim_cep"))

write.csv(faixaCeps, "output/ceps.csv", na = "", row.names = FALSE)