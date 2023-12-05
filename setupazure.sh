#!/bin/bash

# Atualiza os pacotes do sistema
sudo apt-get update
sudo apt-get upgrade -y

# Instala o Python 3 e pip
sudo apt-get install -y python3 python3-pip

# Atualiza o pip
python3 -m pip install --upgrade pip

# Instala os pacotes Python necessários
pip install discord requests Pillow httpx asyncio

# Instala o pacote 'sydney-py'
pip install sydney-py

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

echo "Configuração concluída."
