#!/usr/bin/env bash

set -e pipefail

# Increase the number of open files allowed
ulimit -n 65535 || true

# Setting up some vars
DOTFILES_REPO="https://github.com/vietduc01100001/dotfiles.git"
CACHE_DIR="$HOME/.cache/ubuntu-setup"

# Set the colors to use
red=$(tput setaf 1)
green=$(tput setaf 2)
cyan=$(tput setaf 6)
reset=$(tput sgr0) # Reset the color

# Color-echo
# arg $1 = color
# arg $2 = message
cecho() {
    echo "${1}${2}${reset}"
}

# Echo newline
echo_nl() {
    echo -e "\n"
}

# Install multiple packages
apt_install() {
    if [ "${1}" == "-q" ]; then
        params=($@)
        for pkg in "${params[@]:1}"; do
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq "${pkg}" > /dev/null || true
        done
    else
        for pkg in "$@"; do
            sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "${pkg}" || true
        done
    fi
    sudo dpkg --configure -a || true
    sudo apt-get autoclean && sudo apt-get clean
}

#################################################
#                    Welcome                    #
#################################################

cecho $red "Have you read through the script you're about to run and";
cecho $red "understood that it will make changes to your computer? (y/n): ";
read -r response
if [[ "${response}" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo_nl
    cecho $cyan "#################################################"
    cecho $cyan "#                                               #"
    cecho $cyan "#       Ubuntu Setup Installation Script        #"
    cecho $cyan "#                                               #"
    cecho $cyan "#              by vietduc01100001               #"
    cecho $cyan "#                                               #"
    cecho $cyan "#  Note: You need to be sudo before continuing  #"
    cecho $cyan "#                                               #"
    cecho $cyan "#################################################"
    echo_nl
else
    cecho $red "Please go read the script, it only takes a few minutes."
    exit 1
fi

# Ask for the administrator password and run an infinite loop
# to update existing `sudo` timestamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#################################################
#             Update package lists              #
#################################################

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Ibus Bamboo
sudo add-apt-repository -y ppa:bamboo-engine/ibus-bamboo

# VSCode
curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Albert
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_18.04/Release.key -O Release.key
sudo apt-key add - < Release.key

# Stacer
sudo add-apt-repository ppa:oguzhaninan/stacer -y

# Refresh package lists
sudo apt-get update -qq || true
sudo dpkg --configure -a || true

mkdir -p $CACHE_DIR
rm -rf "$CACHE_DIR/*" || true
cecho $cyan "Start installing packages..."

#################################################
#               Essential packages              #
#################################################

apt_install curl \
    wget \
    git \
    gdebi \
    ruby \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common \
    default-jre
cecho $green "Installed essential packages"

#################################################
#               Terminal packages               #
#################################################

apt_install zsh \
    powerline \
    fonts-powerline \
    tree \
    tmux \
    xsel \
    fzf

# Oh My Zsh, themes & plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# exa
curl -L "https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip" -o "$CACHE_DIR/exa.zip"
unzip "$CACHE_DIR/exa.zip" -d $CACHE_DIR
sudo mv "$CACHE_DIR/exa-linux-x86_64" /usr/local/bin/exa

# bat
curl -s "https://github.com/sharkdp/bat/releases/download/v0.13.0/bat_0.13.0_amd64.deb" -o "$CACHE_DIR/bat.deb"
yes Y | sudo gdebi "$CACHE_DIR/bat.deb"

# Teamocil
sudo gem install teamocil

cecho $green "Installed terminal packages"

#################################################
#             Programming packages              #
#################################################

sudo snap install go --classic
apt_install docker-ce \
    docker-ce-cli \
    containerd.io \
    go-dep \
    redis-server

# Set up Docker
sudo gpasswd -a "$(users)" docker
sudo usermod -a -G docker "$(users)"
echo '{"features":{"buildkit":true}}' | sudo tee /etc/docker/daemon.json > /dev/null

# Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts --latest-npm
nvm alias default node
npm install --global yarn \
    npm-check-updates \
    nodemon \
    json \
    eslint \
    git-standup \
    tldr

cecho $green "Installed programming packages"

#################################################
#                   Dotfiles                    #
#################################################

# Init git for tracking dotfiles in home directory
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config remote add origin $DOTFILES_REPO
config pull origin master
config branch --set-upstream-to=origin/master master

# Configure zsh shell as default
chsh -s $(which zsh)
source ~/.zshrc

cecho $green "Installed dotfiles"

#################################################
#                 Input programs                #
#################################################

sudo gpasswd -a $USER input
apt_install libinput-tools \
    xdotool \
    ibus-bamboo # Vietnamese keyboard
sudo gem install fusuma # Multi-touch gestures
ibus restart
cecho $green "Installed input programs"

#################################################
#                  GUI programs                 #
#################################################

apt_install code \
    albert \
    stacer \
    kazam

# Settings Sync VSCode extension
code --install-extension Shan.code-settings-sync --force

sudo snap install --candidate postman
sudo snap install redis-desktop-manager spotify

# Google Chrome
curl -s https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o "$CACHE_DIR/google-chrome.deb"
yes Y | sudo gdebi "$CACHE_DIR/google-chrome.deb"

cecho $green "Installed GUI programs"

#################################################
#                System settings                #
#################################################

# Disable Apport
sudo sed -i 's/enabled=1/enabled=0/' /etc/default/apport || true

# Fix shutdown/restart freezing
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi=force"/' /etc/default/grub || true

# Decrease grub timeout
sudo sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/' /etc/default/grub || true

# Increase number of file watchers
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p || true

# Install Ubuntu restricted extra packages
apt_install ubuntu-restricted-extras

# Install graphics card drivers
sudo ubuntu-drivers autoinstall || true

cecho $green "Updated system settings"

#################################################
#                   Clean up                    #
#################################################

# Remove temporary files
sudo apt clean && rm -rf -- *.deb* *.gpg* && rm -f *.tar.gz
rm -rf $CACHE_DIR || true

# Install updates then remove unused packages
sudo apt-get update -qq
sudo apt-get upgrade -y --allow-unauthenticated
sudo apt-get clean && sudo apt-get autoclean
yes Y | sudo apt-get autoremove --purge

cecho $green "Installation completed!"
cecho $cyan "Reboot system now? [Y/n] "
read -r response
if [ -z "${response}" ]; then
    response="yes"
fi
if [[ "${response}" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    sudo shutdown -r now
fi
