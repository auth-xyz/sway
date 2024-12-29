set -U fish_greeting ""
set config_aliases "$HOME/.config/fish/alias.fish"

if not type -q fisher
    echo "Fisher is not installed. Installing..."
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end

if type -q starship
    starship init fish | source
end 

if test -f $config_aliases
    source $config_aliases
end

