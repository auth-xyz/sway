set -U fish_greeting ""
set config_aliases "$HOME/.config/fish/alias.fish"

if type -q starship
    starship init fish | source
end 

if test -f $config_aliases
    source $config_aliases
end

fish_add_path /home/ep/.spicetify
