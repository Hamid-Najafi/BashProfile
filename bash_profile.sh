# This is used for mac Terminal Only (not ZSH)

bashConfig="/Users/"$(whoami)"/Dev/Configs/Bash"
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
source $bashConfig/Bash-Profile.sh
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/hamid/.sdkman"
[[ -s "/Users/hamid/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/hamid/.sdkman/bin/sdkman-init.sh"
