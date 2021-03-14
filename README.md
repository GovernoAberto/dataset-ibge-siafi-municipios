# O que é?

Script que realiza o tratamento de dados do IBGE e do SIFIA unificando em uma tabela de municípios e outra de ceps

Fontes originais: 
    - https://www.tesourotransparente.gov.br/ckan/dataset/lista-de-municipios-do-siafi
    - https://www.ibge.gov.br/geociencias/organizacao-do-territorio/estrutura-territorial/23701-divisao-territorial-brasileira.html
    - https://github.com/datasets-br/city-codes

# Como executar

1) Executar o comando "python extract.py" para extrair os arquivos zipados da pasta /download
2) Executar o comando "Rscript process.R" para gerar um único arquivo em /output
3) Renomear .env.example para .env e preencher as variáveis 
4) Executar o comando "python save.py" para salvar o arquivo em duas tabelas
