
<h1 align="center">

  <a href="https://desmatazonia.netlify.app/"><img 
width=30% src="https://github.com/unb-mds/2023-2-Squad02-Desmatazonia/blob/main/licitam/public/images/logo-desmatazonia.png" /> </a>
  <br>
  Extrator
    <br>
</h1>
<h4 align="center">Extrator do desmatamento nos municípios do Amazonas e apurador dos dados recolhidos dos anos 2000 a 2022 pelo  <a href="http://terrabrasilis.dpi.inpe.br/en/home-page/" target="_blank">Instituto Nacional de Pesquisas Espaciais (INPE)</a>.</h4>

<p align="center">
    <img src="https://img.shields.io/badge/python-%230095D5.svg?&style=for-the-badge&logo=python&logoColor=white"/>
</p>

<p align="center">
  <a href="#sobre">Sobre</a> •
  <a href="#manual">Manual</a> •
  <a href="#como-usar">Como Usar</a> •
  <a href="#testes">Testes</a> 
</p>

## Sobre

O principal objetivo do projeto é coletar, converter em texto e organizar por municípios os dados provenientes do projeto PRODES, que realiza o monitoramento do desmatamento por corte raso na Amazônia Legal por meio de satélites. Utilizamos a base de dados tratada disponível no site [basedosdados.org](https://basedosdados.org/dataset/e5c87240-ecce-4856-97c5-e6b84984bf42?table=d7a76d45-c363-4494-826d-1580e997ebf0), a qual nos proporcionou informações públicas e gratuitas sobre o desmatamento anual, a hidrografia, a vegetação e o bioma de cada unidade estadual.

Além da segmentação dos dados por município, as informações de cada unidade estadual são categorizadas em termos de área total desmatada e área desmatada por ano.

### Manual
```
Carregamento da bade de dados tratada -> pré-processamento dos dados -> Arquivo csv -> extrator_desmatamento.py -> Arquivos processados do csv em formato JSON -> extrair_dados_gerais.py -> Arquivo processado do desmatamento por ano por município.
```
### Carregamento dos dados
```
import basedosdados as bd

# Para carregar o dado direto no pandas
df = bd.read_table(dataset_id='br_inpe_prodes',
table_id='municipio_bioma',
billing_project_id="<YOUR_PROJECT_ID>")
```

## Como Usar
Ao coletar a base de dados do [basedosdados.org](https://basedosdados.org/dataset/e5c87240-ecce-4856-97c5-e6b84984bf42?table=d7a76d45-c363-4494-826d-1580e997ebf0) realize os seguintes passos: <br><br>
1. Carregamento dos dados<br>
```
import basedosdados as bd

# Para carregar o dado direto no pandas
df = bd.read_table(dataset_id='br_inpe_prodes',
table_id='municipio_bioma',
billing_project_id="<YOUR_PROJECT_ID>")
```
> **Note**
> No [site](https://basedosdados.org/dataset/e5c87240-ecce-4856-97c5-e6b84984bf42?table=d7a76d45-c363-4494-826d-1580e997ebf0), as opções para carregar os dados utilizando SQL, R, Stata, e realizar o download estão disponíveis.<br>
2. Pré-processar a base de dados e salvá-la em um arquivo CSV usando o `database_desmatamento.ipynb`.<br>

3. Extrair informações relevantes do arquivo CSV, separando-as por municípios, e salvá-las em arquivos JSON usando o `extrator_desmatamento.py`.<br>

4. Extrair informações sobre a área total desmatada e a área desmatada por ano de cada município, salvando-as em um único arquivo JSON com o `extrator_dados_gerais.py`.<br>

5. Criar um JSON contendo o nome de todos os municípios usando o `municípios.py`.
<br>

## Testes

## Related

[DesmataZônia](https://desmatazonia.netlify.app) - Website do Projeto onde os dados aqui capturados são exibidos.

Os dados exibidos no site estão na pasta: extrator/dados_desmatamento 