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

# Instala o vsftpd
sudo apt-get install -y vsftpd

# Configurações básicas do vsftpd (adicione ou ajuste conforme necessário)
sudo bash -c 'echo "listen=NO" >> /etc/vsftpd.conf'
sudo bash -c 'echo "listen_ipv6=YES" >> /etc/vsftpd.conf'
sudo bash -c 'echo "anonymous_enable=NO" >> /etc/vsftpd.conf'
sudo bash -c 'echo "local_enable=YES" >> /etc/vsftpd.conf'
sudo bash -c 'echo "write_enable=YES" >> /etc/vsftpd.conf'
sudo bash -c 'echo "chroot_local_user=YES" >> /etc/vsftpd.conf'
sudo bash -c 'echo "local_umask=022" >> /etc/vsftpd.conf'
sudo bash -c 'echo "user_sub_token=\$USER" >> /etc/vsftpd.conf'
sudo bash -c 'echo "local_root=/home/\$USER/ftp" >> /etc/vsftpd.conf'

# Reinicia o serviço vsftpd
sudo systemctl restart vsftpd

# Adiciona o usuário ftpuser com a senha 12345
sudo adduser ftpuser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "ftpuser:12345" | sudo chpasswd

# Cria a pasta AutoADS e subpastas
sudo mkdir -p /AutoADS/python
sudo chown ftpuser:ftpuser /AutoADS
sudo chown ftpuser:ftpuser /AutoADS/python

# Configurações adicionais para o diretório do usuário FTP
sudo mkdir /home/ftpuser/ftp
sudo chown ftpuser:ftpuser /home/ftpuser/ftp
sudo chmod a-w /home/ftpuser/ftp

# Cria um diretório para upload (opcional)
sudo mkdir /home/ftpuser/ftp/files
sudo chown ftpuser:ftpuser /home/ftpuser/ftp/files

# Instala o Git
sudo apt-get install -y git

# Variáveis de Token e Repositório
TOKEN="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"
REPO_URL="github.com/DaskSs/Auto-Adobe-Stock.git"

# Clona o Repositório na pasta python
sudo git clone https://${TOKEN}@${REPO_URL} /AutoADS/python

# Navega até o diretório clonado e executa o script
cd /AutoADS/python
sudo nohup python3 adobestock02.py &

echo "Configuração concluída."
