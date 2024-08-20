# Documentação para a Atividade de Linux da Compass UOL

### Requisitos AWS:
• Gerar uma chave pública para acesso ao 
ambiente;  
• Criar 1 instância EC2 com o sistema 
operacional Amazon Linux 2 (Família t3.small, 
16 GB SSD);  
• Gerar 1 elastic IP e anexar à instância EC2;  
• Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).  
### Requisitos no linux:
• Configurar o NFS entregue;  
• Criar um diretorio dentro do filesystem do NFS 
com seu nome;  
• Subir um apache no servidor - o apache deve 
estar online e rodando;  
• Criar um script que valide se o serviço esta 
online e envie o resultado da validação para o 
seu diretorio no nfs;  
• O script deve conter - Data HORA + nome do 
serviço + Status + mensagem personalizada de 
ONLINE ou offline;  
• O script deve gerar 2 arquivos de saida: 1 para o 
serviço online e 1 para o serviço OFFLINE;  
• Preparar a execução automatizada do script a 
cada 5 minutos;    
• Fazer o versionamento da atividade;  
• Fazer a documentação explicando o processo de 
instalação do Linux.  

## Requisitos AWS
### Gerar uma chave pública para acesso ao ambiente:
![1](https://github.com/user-attachments/assets/01a9dac1-54a6-4936-aeb3-28e52e3d32ea)  
Ao criar a EC2, a chave por ser gerada selecionando a máquina virtual  
### Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD)    
![1 1](https://github.com/user-attachments/assets/d8db5528-59a9-448f-a1c5-5d1d3923c695)  
A instância deve ser iniciada atendendo as critérios em questão. Lembrar de colocar as tags para conseguir subir a VM.  
### Criar uma VPC  
![2 1](https://github.com/user-attachments/assets/388c7df6-b518-4e0d-9b3d-bcd947aa163e)  
### Criar uma sub-rede  
![2 2](https://github.com/user-attachments/assets/5b4537b8-9fc0-4274-a13f-8c9344879ebd)  
### Gerar 1 elastic IP e anexar à instância EC2  
![1 3](https://github.com/user-attachments/assets/268cfefe-689f-43c9-81f5-8bfd417410c0)  
Linkar IP Elástico a instância criada.  
### Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP)  
![2](https://github.com/user-attachments/assets/182cc910-6039-4b56-b31d-0f5b692f6bf2)  

## Requisitos no linux  
### Configurar o NFS entregue  
![1](https://github.com/user-attachments/assets/e0b227ff-dc67-4b09-9119-08046ff71f12)  
`sudo yum install -y nfs-utils`  
`# instala o pacote para gerenciamento de pastas NFS`  
`sudo systemctl start nfs-server`  
`# inicia o serviço`  
`sudo systemctl enable nfs-server`  
`# habilita a inicialização do serviço`  
`sudo mkdir -p /mnt/nfs`  
`# cria o diretorio nfs`  
`sudo nano /etc/exports`  
`# cria o arquivo de configuração nfs`  
`/mnt/nfs *(rw,sync,no_root_squash,no_all_squash)`  
`# configuração a ser colocada dentro do arquivo`  
`sudo exportfs -a`
`# exporta a configuração`  
### Criar um diretorio dentro do filesystem do NFS 
com seu nome  
`sudo mkdir -p /mnt/nfs/bruno`  
`# cria o diretório`  
### Subir um apache no servidor - o apache deve estar online e rodando
`sudo yum install -y httpd`  
`# instala o apache`  
`sudo systemctl start httpd`  
`# inicia o serviço`  
`sudo systemctl enable httpd`  
`# habilita a inicialização do serviço`
`sudo systemctl status httpd`  
`# verifica o status do serviço`  
### Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs;
`# O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline;`  
`sudo nano /usr/local/bin/check_apache.sh`  
`# cria o arquivo do script`  
![2](https://github.com/user-attachments/assets/04ba5468-3595-4107-bae6-e9ddaddb951f)  
```
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
```    
`# código do scrpit`  
### Preparar a execução automatizada do script a cada 5 minutos. 
`sudo crontab -e`
`# configurar o script`  
![3 percebi](https://github.com/user-attachments/assets/43dd2517-43ea-4672-93b5-8d8292230686)  
Note que o pacote não está instalado, portanto:  
`sudo yum install cronie`  
`# instala o pacote para agendamento de tarefas`  
`sudo crontab -e`  
`*/5 * * * * /usr/local/bin/check_apache.sh`  
`# definir comando para o tempo em questão`  
![4 crond ligar e automatico](https://github.com/user-attachments/assets/b262a07f-2dac-41db-9326-36f869f05c5f)  
`sudo systemclt start crond`  
`# iniciar o serviço`  
`sudo systemclt enable crond`  
`# habilita a inicialização automatica do serviço`  

### Arquivos de saída
Ativo  
![6 ativo](https://github.com/user-attachments/assets/81a5252d-e818-45c7-81e8-3836e68c48e9)  
Inativo  
![6 inativo](https://github.com/user-attachments/assets/f052b33c-2656-4f2f-98e8-9917efeacff8)  







