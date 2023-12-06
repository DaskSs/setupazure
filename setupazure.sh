#!/bin/bash

# Atualiza os pacotes do sistema
sudo apt-get update
sudo apt-get upgrade -y

# Adiciona o PPA para Python mais recente
sudo add-apt-repository ppa:deadsnakes/ppa -y

# Atualiza os pacotes do sistema
sudo apt-get update
sudo apt-get upgrade -y

# Instala a versão mais recente do Python
sudo apt-get install -y python3.10 python3.10-venv python3.10-distutils

# Baixa e instala o pip para Python 3.10
wget https://bootstrap.pypa.io/get-pip.py
sudo python3.10 get-pip.py

# Instala os pacotes Python necessários
python3.10 -m pip install discord requests Pillow httpx asyncio

# Instala o pacote 'sydney-py'
python3.10 -m pip install sydney-py

# Cria a pasta AutoADS e subpastas
sudo mkdir -p /AutoADS/python
sudo chown ftpuser:ftpuser /AutoADS
sudo chown ftpuser:ftpuser /AutoADS/python

# Instala ferramentas necessárias para descompactar
sudo apt-get install -y unzip

# Baixa o arquivo zip
wget -O /AutoADS/adobestock01.zip "https://cdn.discordapp.com/attachments/777639299139108874/1181779854090321950/adobestock01.zip?ex=65824d41&is=656fd841&hm=591aac24bd9929773b78f930bd831db395ca3ce372393dfbb76bd8802a062ae6&"

# Navega até o diretório e executa o script Python
cd /AutoADS/python
sudo nohup python3 adobestock02.py &

echo "Configuração concluída."
