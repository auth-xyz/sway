# Start tmux when terminal opens
#test $TERM != "screen"; and exec tmux

#if status is-interactive
#and not set -q TMUX
#	exec tmux
#end


# Init:
starship init fish | source
source $HOME/.zshalias 

# FZF:
set fzf_preview_dir_cmd eza --all --color=always
set fzf_directory_opts eza --all --color=always
set fzf_preview_file_cmd bat -n

# Disable greeting:
set -U fish_greeting  
