#!/bin/bash

# Diretórios e variáveis
DIR_LOG="/mnt/nfs/bruno"
DATA_HORA=$(date +"%d-%m-%Y %H:%M:%S")
SERVICO="httpd"
STATUS_SERVICO=$(systemctl is-active $SERVICO)

if [ "$STATUS_SERVICO" == "active" ]; then
    echo "$DATA_HORA - $SERVICO - ATIVO" >> "$DIR_LOG/httpd_ativo.log"
else
    echo "$DATA_HORA - $SERVICO - INATIVO" >> "$DIR_LOG/httpd_inativo.log"
fi
