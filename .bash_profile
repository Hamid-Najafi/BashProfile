bashConfig="/Users/"$(whoami)"/Dev/Configs/Bash"
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
source $bashConfig/Bash-Profile.sh
