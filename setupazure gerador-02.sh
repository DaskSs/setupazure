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

# Cria a pasta AutoADS e subpastas
sudo mkdir -p /AutoADS/python
sudo chown ftpuser:ftpuser /AutoADS
sudo chown ftpuser:ftpuser /AutoADS/python

# Cria um novo arquivo de serviço systemd
echo "[Unit]
Description=Meu Script de Inicialização

[Service]
ExecStart=/usr/bin/python3 /AutoADS/python/gen-02.py

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/meuscript.service

# Dá permissão de execução ao arquivo de serviço
sudo chmod 644 /etc/systemd/system/meuscript.service

# Recarrega o systemd para reconhecer o novo serviço
sudo systemctl daemon-reload

# Habilite o serviço para iniciar na inicialização
sudo systemctl enable meuscript.service

# Inicia o serviço
sudo systemctl start meuscript.service

# Instala ferramentas necessárias para descompactar
sudo apt-get install -y unzip

# Baixa o arquivo zip
wget -O /AutoADS/python/gerador-02.zip "https://cdn.discordapp.com/attachments/1056919566938288168/1186032897971458159/gerador-02.zip?ex=6591c636&is=657f5136&hm=55e1732099122681de80990f6c16e5fb3f9ef5a6514e7347d78b02deea574324&"

#Deszipa
sudo unzip /AutoADS/python/gerador-02.zip -d /AutoADS/python

# Navega até o diretório e executa o script Python
cd /AutoADS/python
sudo nohup python3 gen-02.py &

echo "Configuração concluída."
