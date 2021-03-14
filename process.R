library("readxl")
library("dplyr")
library("tidyr")

municipiosSIAFI <- read_excel(path = "./download/SIAFI.xlsx")
municipiosSIAFI <- municipiosSIAFI %>% filter(`CÓDIGO IBGE` != "0000000")
municipiosSIAFI <- municipiosSIAFI %>% select(`CÓDIGO SIAFI`, `CÓDIGO IBGE`) %>% rename(codigo_siafi = `CÓDIGO SIAFI`, codigo_ibge = `CÓDIGO IBGE`)

municipiosIBGE <- read_excel("download/IBGE.xls")
colnames(municipiosIBGE) <- gsub(" ", "_", tolower(names(municipiosIBGE)))

municipiosIBGE <- municipiosIBGE %>% 
        select(nome_uf, nome_mesorregião, nome_microrregião, nome_município, uf, município, código_município_completo) %>%
        rename(nome_mesorregiao = nome_mesorregião, 
               nome_microrregiao = nome_microrregião, 
               nome_municipio = nome_município, 
               codigo_ibge_municipio = município, 
               codigo_ibge_uf = uf,
               codigo_ibge = código_município_completo
        ) %>% mutate(nome_municipio = toupper(nome_municipio))

municipios <- municipiosIBGE %>% inner_join(municipiosSIAFI)

write.csv(municipios, "output/municipios.csv", na = "", row.names = FALSE)

faixaCeps <- read.csv2("download/CEP.csv", sep = ",", encoding = "UTF-8") %>% select(idIBGE, postalCode_ranges)
faixaCeps <- faixaCeps %>% mutate(postalCode_ranges = gsub("[^[:alnum:] ]", "", postalCode_ranges)) %>% rename(codigo_ibge = idIBGE)
faixaCeps <- faixaCeps %>% separate(postalCode_ranges, c("inicio_cep", "fim_cep"))

write.csv(faixaCeps, "output/ceps.csv", na = "", row.names = FALSE)