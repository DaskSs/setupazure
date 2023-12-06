#!/bin/bash

# Atualiza os pacotes do sistema
sudo apt-get update
sudo apt-get upgrade -y

# Instala dependências para compilar Python
sudo apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev libbz2-dev wget

# Baixa o Python 3.12.0
cd /tmp
wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tar.xz

# Extrai e compila o Python
tar -xf Python-3.12.0.tar.xz
cd Python-3.12.0
./configure --enable-optimizations
make -j `nproc`
sudo make altinstall

# Atualiza o pip
python3.12 -m pip install --upgrade pip

# Instala os pacotes Python necessários
python3.12 -m pip install discord requests Pillow httpx asyncio

# Instala o pacote 'sydney-py'
python3.12 -m pip install sydney-py

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

# Cria a pasta /Adobe Stock
sudo mkdir /Adobe\ Stock
sudo chown ftpuser:ftpuser /Adobe\ Stock

# Configurações adicionais para o diretório do usuário FTP
sudo mkdir /home/ftpuser/ftp
sudo chown ftpuser:ftpuser /home/ftpuser/ftp
sudo chmod a-w /home/ftpuser/ftp

# Cria um diretório para upload (opcional)
sudo mkdir /home/ftpuser/ftp/files
sudo chown ftpuser:ftpuser /home/ftpuser/ftp/files

# Instala o Git
sudo apt-get install -y git

# Variáveis de Token e Repositório (substitua SEU_TOKEN e NOME_DO_USUARIO)
TOKEN="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"
REPO_URL="https://github.com/DaskSs/Auto-Adobe-Stock.git"

# Clona o Repositório
git clone https://${TOKEN}@${REPO_URL}

# Navega até o diretório clonado e executa o script
cd Auto-Adobe-Stock
sudo nohup python3 adobestock02.py &

echo "Configuração concluída."
