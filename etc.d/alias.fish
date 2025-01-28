# Exporting variables for ease of use
eval "$(zoxide init fish)"

# Environment variables
set -x LD_LIBRARY_PATH /usr/local/lib:/usr/local/lib64/
set -x PATH "$HOME/.local/bin/:$PATH"
set -x GIT "https://github.com"
set -x PROJECTS "$HOME/Projects/"
set -x SCRIPTS "$HOME/.scripts"
set -x WALLP "$HOME/.wallpapers"
set -x CONFIG "$HOME/.config"

# System aliases
alias inst="sudo dnf install -y"
alias update="sudo dnf update -y"
alias remove="sudo dnf remove -y"

alias cd='z'
alias ls="eza --icons --all"
alias ll="eza --icons --color --long --tree --all"

alias kill="killall -KILL"
alias copy="wl-copy"
alias syncv="rclone sync $HOME/Vault gdrive:Vault/"

# VPN aliases
alias vpnc="sudo protonvpn c"
alias vpnd="sudo protonvpn d"
alias vpns="sudo protonvpn status"

# Script aliases
alias arduino_ide="_JAVA_AWT_WM_NONREPARENTING=1 flatpak run cc.arduino.arduinoide"
alias fontinstall="cp $SCRIPTS/fontin.py ./ && python3 ./fontin.py && rm fontin.py"
alias port_foward="$SCRIPTS/portfowarding.sh"
alias aliases="bat $HOME/.zshalias"
alias audio="/usr/bin/audio -c wp"
alias icat="kitty +kitten icat"
alias fasty="fastfetch"

# Git aliases
alias ginit="git init"
alias gcl="git clone"
alias gco="git checkout"
alias gb="git branch"
alias gbd="git branch -d"
alias gst="git status"
alias ga="git add"
alias gaa="git add ."
alias gcm='git commit -m'
alias gp="git push"
alias gpl="git pull"
alias gpr='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD) && echo "Pull request created for branch $(git rev-parse --abbrev-ref HEAD)"'
alias grh='git reset --hard'
alias gd='git diff'
alias lg='lazygit'

# System logging aliases
alias syslog="sudo journalctl -f"
alias netlog="sudo tcpdump -i any"
alias netusage="sudo iftop"
alias kernellog="sudo dmesg -w"

