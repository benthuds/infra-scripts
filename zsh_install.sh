#!/usr/bin/env zsh
#
# backup-webthux.sh - backup dos arquivos de configuração de um servidor Web.
#
# Site:       https://thux.tech/hudson
# Autor:      Hudson Bento
# Manutenção: Hudson Bento
#
# ------------------------------------------------------------------------ #
#  Este código tem como finalidade realizar o backup dos arquivos de configuração de vários sites hospedados em um servidor Web.
#
#  Exemplos:
# ------------------------------------------------------------------------ #
# Histórico:
#   v1.0/11/2024, Hudson:
#     -
# ------------------------------------------------------------------------ #
# Testado em:
#   zsh 5.8.1
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
date=`date`
#ZSH=$(rpm -qa | grep zsh > /dev/null 2>&1;  echo $?)
#ZSH=$(dpkg -l | grep zsh > /dev/null 2>&1;  echo $?)
ZSH=$(which zsh > /dev/null 2>&1;  echo $?)
GIT=$(which git > /dev/null 2>&1;  echo $?)
WGET=$(which wget > /dev/null 2>&1;  echo $?)
SH=$(which sh > /dev/null 2>&1;  echo $?)
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
#[ "$ZSH" -ne 1 ] && dnf install zsh
[ "$WGET" -ne 0 ] && dnf install wget
[ "$GIT" -ne 0 ] && dnf install git
[ "$ZSH" -ne 0 ] && dnf install zsh

# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
## instalação do Oh My ZSH
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &

## instalação do plugin Auto Sugestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sleep 3

## instalação do plugin  Sybtax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sleep 3

## instalação do plugin FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
sleep 3
if [ -d ~/.fzf/ ]; 
then
    ~/.fzf/install
elif [ -d ~/.fz/ ]; then
    ~/.fz/install
else
    echo "Diretório não encontrado!"
    exit 1;
if

## ajustes na configuração do ZSH
sed -i 's|ZSH_THEME="robbyrussell"|ZSH_THEME="fino-time"|' ~/.zshrc
sed -i "s|plugins=(git)|$(printf 'plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf)')|" ~/.zshrc
# ------------------------------------------------------------------------ #