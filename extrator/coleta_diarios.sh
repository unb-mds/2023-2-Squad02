#!/bin/bash

set -x  # debug
set -e  # exit on error

START_DATE=${START_DATE:="2010-01-01"}
END_DATE=${END_DATE:="2023-12-31"}
ROOT_DIR=${PWD}
DATA_DIR=${ROOT_DIR}/data
OUT_DIR=${DATA_DIR}/out
REPO_DIR=${DATA_DIR}/qd
DATA_COLLECTION_DIR=${REPO_DIR}/data_collection
QD_DOWNLOAD_DIR=${REPO_DIR}/data_collection/data/1300000
DOWNLOAD_DIR=${DATA_DIR}/diarios

mkdir -p ${DATA_DIR}
cd ${DATA_DIR}
mkdir -p ${DOWNLOAD_DIR}
mkdir -p ${OUT_DIR}

# Checando se o docker está rodando antes de iniciar a coleta.
docker ps > /dev/null

# # Preparando ambiente para coleta.
# cd ${REPO_DIR} || (git clone https://github.com/okfn-brasil/querido-diario qd && cd ${REPO_DIR})
# python3 -m venv .venv
# source .venv/bin/activate
# pip install -r ${DATA_COLLECTION_DIR}/requirements-dev.txt

# # Coletando diários e movendo para a pasta diários.
# cd ${DATA_COLLECTION_DIR}
# scrapy crawl am_associacao_municipios -a start_date=2010-01-01 -a end_date=2023-12-31 > ${OUT_DIR}/scrapy.out 2> ${OUT_DIR}/scrapy.err

for dir in `ls -da ${QD_DOWNLOAD_DIR}/*`
do
    # Importante pois algumas datas possuem mais de um diário (tem os extras).
    i=1
    for fpath in `ls -da ${dir}/*`
    do
        newname=`basename ${dir}-${i}.pdf`
        mv ${fpath} ${DOWNLOAD_DIR}/${newname}
        i=$((i+1))
    done
done

# Finalizando e saindo do ambiente virtual.
cd ${REPO_DIR}


# Extraindo texto dos diários e segmentando diários.
cd ${DOWNLOAD_DIR}

# docker pull apache/tika:1.28.4
docker run -d -p 9998:9998 --rm --name tika apache/tika:1.28.4
sleep 10

for pdf in `ls -a *.pdf`
do
    fname=`basename -s .pdf ${pdf}`  # removendo extensão
    extraido="${fname}-extraido.txt"
    curl \
        -H "Accept: text/plain" -H "Content-Type: application/pdf" \
        -T ${pdf} \
        http://localhost:9998/tika > ${extraido}
    
    cd ${ROOT_DIR}
    # python3 ${ROOT_DIR}/extrair_diarios.py ${extraido}
    python3 extrair_diarios.py data/diarios/diarios/${extraido}
    # rm -f ${pdf}
    # rm -f ${fname}-proc*.txt

    cd ${DOWNLOAD_DIR}
done

docker stop tika
