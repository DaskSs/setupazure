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

#Instala o Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Baixa e instala o pip para Python 3.10
wget https://bootstrap.pypa.io/get-pip.py
sudo python3.10 get-pip.py

# Instala os pacotes Python necessários
python3.10 -m pip install discord requests Pillow httpx asyncio

# Instala o pacote 'sydney-py'
python3.10 -m pip install sydney-py

# Cria as pastas
sudo mkdir -p /AutoADS/python-gen01
sudo mkdir -p /AutoADS/python-gen02
sudo mkdir -p /AutoADS/python-gen03

# Define a propriedade das pastas
sudo chown ftpuser:ftpuser /AutoADS/python-gen01
sudo chown ftpuser:ftpuser /AutoADS/python-gen02
sudo chown ftpuser:ftpuser /AutoADS/python-gen03

# Instala Unzip
sudo apt-get install -y unzip

# Baixa e descompacta o arquivo para gen-01
wget -O /AutoADS/python-gen01/gen-01.zip "https://cdn.discordapp.com/attachments/1056919566938288168/1186039852312051742/gen-01.zip"
sudo unzip /AutoADS/python-gen01/gen-01.zip -d /AutoADS/python-gen01

# Baixa e descompacta o arquivo para gen-02
wget -O /AutoADS/python-gen02/gerador-02.zip "https://cdn.discordapp.com/attachments/1056919566938288168/1186032897971458159/gerador-02.zip"
sudo unzip /AutoADS/python-gen02/gerador-02.zip -d /AutoADS/python-gen02

# Configuração do serviço systemd para gen-01
echo "[Unit]
Description=Script de Inicialização gen-01

[Service]
ExecStart=/usr/bin/python3 /AutoADS/python-gen01/gen-01.py

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/meuscript-gen01.service

sudo chmod 644 /etc/systemd/system/meuscript-gen01.service
sudo systemctl daemon-reload
sudo systemctl enable meuscript-gen01.service
sudo systemctl start meuscript-gen01.service

# Configuração do serviço systemd para gen-02
echo "[Unit]
Description=Script de Inicialização gen-02

[Service]
ExecStart=/usr/bin/python3 /AutoADS/python-gen02/gen-02.py

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/meuscript-gen02.service

sudo chmod 644 /etc/systemd/system/meuscript-gen02.service
sudo systemctl daemon-reload
sudo systemctl enable meuscript-gen02.service
sudo systemctl start meuscript-gen02.service

# Navega até o diretório da gen01 e executa o script Python
cd /AutoADS/python-gen01
sudo nohup python3 gen-01.py &

# Navega até o diretório da gen02 e executa o script Python
cd /AutoADS/python-gen02
sudo nohup python3 gen-02.py &

echo "Configuração concluída."
