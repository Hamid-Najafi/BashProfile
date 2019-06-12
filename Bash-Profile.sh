export PATH=$PATH:.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#export CLICOLOR=1
#export LSCOLORS=Exfxcxdxbxegedabagacad

#For Home
export PS1="\[\e[38;5;110;48;233m\]\u \W $ \[\e[0m\]"

#For Servers
#export PS1="\[\e[38;5;110;48;233m\]\u@\h \W $ \[\e[0m\]"
# Default
#export PS1=$DEFAULT

PROMPT_COMMAND="echo"

check=$(type sudo)
result="sudo is /usr/bin/sudo"
if [ "$check" != "$result" ]
then
    printf "\e[31;1m%s\n\e[0m" "Sudo Warning"
    type sudo
    read -p "You may hacked !"
fi
# Bash 
alias ls='ls -GFh'
alias lsf='ls -laghFG'
alias cd..='cd ..'
alias cd~='cd ~'
alias serial_port='ls /dev/tty.*'
alias sp=serial_port
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias copyPublicKey='pbcopy < $devLocations/Configs/RSA\ Keys/id_rsa.pub'

# Commom Mac programsc
alias xcode='open -a xcode'
alias text='open -a TextEdit'
alias pre='open -a Preview'
alias pwdfailed='syslog -k Time ge -24h | egrep -e "sshd|ftpd|afp|vnc"'
alias restart_wifi='networksetup -setairportpower en0 off;networksetup -setairportpower en0 on'
alias installCommandLineTools='xcode-select --install'

# Grep
alias grep='grep -n'
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'

# ------------------------ Load Configs -------------------------
bashConfig="/Users/"$(whoami)"/Dev/Configs/Bash"
source $bashConfig/App-Profile.sh
source $bashConfig/Personal-Profile.sh
source $bashConfig/Useful-Functions.sh

alias reload='source $bashConfig/Bash-Profile.sh'
#;source $bashConfig/App-Profile.sh;source $bashConfig/Personal-Profile.sh;source $bashConfig/Useful-Functions.sh'
alias r=reload
alias bash_profile='code $bashConfig/Bash-Profile.sh'
alias bp=bash_profile
# -------------------------- Path ---------------------------
# Binary Files Locations (Order is important)
# Already exists in etc/path
export Binary=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$PATH:$Binary