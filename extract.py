import urllib.request
import os, zipfile

urllib.request.urlretrieve("https://www.tesourotransparente.gov.br/ckan/dataset/abb968cb-3710-4f85-89cf-875c91b9c7f6/resource/eebb3bc6-9eea-4496-8bcf-304f33155282/download/TABMUN-SIAFI.xlsx", "./download/SIAFI.xlsx")

urllib.request.urlretrieve("https://geoftp.ibge.gov.br/organizacao_do_territorio/estrutura_territorial/divisao_territorial/2020/DTB_2020_v2.zip", "./download/IBGE.zip")

with zipfile.ZipFile("./download/IBGE.zip") as zf:
       for file in zf.namelist():
            if file.endswith("RELATORIO_DTB_BRASIL_MUNICIPIO.xls"):
                zf.extract(file, "./download/")
os.rename('./download/RELATORIO_DTB_BRASIL_MUNICIPIO.xls', './download/IBGE.xls')
os.remove('./download/IBGE.zip')

urllib.request.urlretrieve("https://raw.githubusercontent.com/datasets-br/city-codes/master/data/br-city-codes.csv", "./download/CEP.csv")