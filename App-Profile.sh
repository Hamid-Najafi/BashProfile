# ===========================================================================
# =========================== Software Developing ===========================
# ===========================================================================

# ------------------------ Applications ------------------------
#ExportAll

# RSA KEYs
alias copyPublicKey='pbcopy < $devLocations/Configs/RSA\ Keys/id_rsa.pub'
alias exportKnownHosts='cp ~/.ssh/known_hosts $configsLocaion/RSA\ Keys/  && echo Export Knownhosts Done'

# ZSH
alias exportBash='cp ~/.zshrc $configsLocaion/Bash/zshrc.sh && cp ~/.bash_profile $configsLocaion/Bash/bash_profile.sh && echo Export Bash Done'

# Visual Studio Code
export VSCode=/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
alias vscode='code'
alias exportvscodeExtn='code --list-extensions | xargs -L 1 echo code --install-extension > $configsLocaion/VSCode/VSCode\ Extentions.command  && echo Export VSCode Extn Done'

# Git
git config --global color.ui true
git config --global format.pretty oneline
git config --global core.autocrl input
git config --global core.fileMode true
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias push='git pull origin master && git push origin master'
alias pull='git pull origin master'
function clone(){
cd $devLocations/Git && git clone $1 && cd $(ls -t | head -n 1)
}
alias exportGit='cp ~/.gitconfig  $configsLocaion/Git/gitconfig.txt  && echo Export Git Done'


# dotnetCore
export DDOTNETTOOLS=$HOME/.dotnet/tools

# Homebrew
#  bash-completion - NOTE : ITS FOR BASH , NOT ZSH !
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#    . $(brew --prefix)/etc/bash_completion
#fi
export EDITOR=code
export HOMEBREW_EDITOR=code
alias installBrew='ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew doctor'
alias exportBrewList='brew tap |  xargs -L 1 echo brew tap > $configsLocaion/Brew/Brew\ List.command  && brew list --formula | xargs -L 1 echo brew install >> $configsLocaion/Brew/Brew\ List.command  && brew list --cask | xargs -L 1 echo brew cask install >> $configsLocaion/Brew/Brew\ List.command && echo Export Brew List Done'

# NPM (Node Package Manager)
export PATH=~/.npm-global/bin:$PATH


# NVM (Node Version Manager)
# export NVM_DIR="$HOME/.nvm"
# source $(brew --prefix nvm)/nvm.sh
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Minishift OC
export PATH="/Users/hamid/.minishift/cache/oc/v3.11.0/darwin:$PATH"

# Metasploit
export Metasploit=/opt/metasploit-framework/bin

# Fastlane
#export Fastlane=$HOME/.fastlane/bin

# Android
export ANDROID_SDK=/Users/"$(whoami)"/Library/Developer/Xamarin/android-sdk-macosx
#export ANDROID_NDK=/Users/"$(whoami)"/Library/Developer/Xamarin/android-ndk
export ANDROID_ROOT=$ANDROID_SDK
export ANDROID_HOME=$ANDROID_SDK
#export NDK_ROOT=$ANDROID_NDK

# ------------------ Custom Scripts and Binaries ------------------
# Download document from wenku.baidu.com
export dotnetSdkHelpers=$appLocation/dotnet-sdk-helpers
export wkget=$appLocation/wkget/tools
export PATH=$PATH:$wkget
#:$dotnetSdkHelpers
alias TashimBeNesbeh='cd "/Users/hamid/Documents/Projects/Mahdi/TashimBeNesbeh-macOS";./TashimBeNesbeh'

# --------------------- Programming Languages ---------------------

# Phyton
alias python=python3
alias pip=pip3
alias update_pip='sudo pip install -U $(pip freeze | cut -d '=' -f 1)'

# Java
# jEnv is a command line tool to help you forget how to set the JAVA_HOME environment variable
# OR use these:
#export JAVA_HOME=$(/usr/libexec/java_home)
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-12.0.1.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
export JRE_HOME=$JAVA_HOME

# Go
#export GOPATH=$HOME/go-workspace # don't forget to change your path correctly!
#export GOROOT=/usr/local/opt/go/libexec/bin

# Ruby Version Manager
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# SWI-Prolog
#export SWI_Prolog=/Applications/SWI-Prolog.app/Contents/MacOS

# ----------------------- Databasses ------------------------

# PostgresSQL
#alias pg_start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
#alias pg_stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"

# MySQL
#export MYSQL_HOME=/usr/local/mysql
#export MYSQL_CLIENT=/usr/local/opt/mysql-client/bin
#alias start_mysql='sudo $MYSQL_HOME/bin/mysqld_safe &'
#alias stop_mysql='sudo $MYSQL_HOME/bin/mysqladmin shutdown'

# -------------------------- Path ---------------------------

export PATH=$PATH:$VSCode:$Metasploit
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
#export PATH=$PATH:$GOPATH:$GOROOT:$SWI_Prolog:$MYSQL_CLIENT


# ===========================================================================
# =========================== Hardware Developing ===========================
# ===========================================================================

# Mbed
alias mbed-update='pip install --upgrade mbed-cli'
alias mbed-run='mbed compile --target K64F --toolchain GCC_ARM --flash'

# ST Microcontroller
function st-gdb(){
STUtilPort="$@"
cd build
[[ -z "$STUtilPort" ]] && arm-none-eabi-gdb -ex "tar extended-remote 127.0.0.1:4242" || arm-none-eabi-gdb -ex "tar extended-remote 127.0.0.1:$STUtilPort"
}

alias st-bmp='arm-none-eabi-gdb -ex "tar extended-remote /dev/cu.usbmodemC3BFB8DB"'

function st-write(){
FirmwareFile="$@"
[[ -z "$FirmwareFile" ]] && st-flash write firmware.bin 0x08000000 || st-flash write $FirmwareFile 0x08000000
}

function st-run(){
make -j8 all
if [ $? -eq 0 ]
    then
        printf "\e[32m%s\n" "Successfully Compiled"
        extension=".bin"
        name="${PWD##*/}"
        fullname="$name$extension"
        printf "\e[32mFlashing $fullname\e[m\n"
        #stat=$
        st-write build/$fullname
       # if [stat -eq 0] then 
        printf "\e[32m%s\n" "Flash Done"
       # printf "\e[32m%s\n" "Flash Error"


        #for foo in $(find . -type f -name "*.bin" )
        #    do
             #   st-write $foo
           # done
    else
        printf "\e[31m%s\n" "Compile Error!" >&2
fi
}
function st-erase(){
    st-flash erase
}

# Espressif


# ESP-IDF
source $HOME/esp/esp-idf/export.sh > /dev/null
# export esp32=$HOME/esp/xtensa-esp32-elf/1.22.0-100-ge567ec7-5.2.0/bin
# export esp32=$HOME/esp/xtensa-esp32-elf/gcc8_2_0-esp32-2019r1/bin
#alias get_esp32="export PATH=$HOME/esp/xtensa-esp32-elf/1.22.0-80-g6c4433a-5.2.0/bin:$PATH"
# export esp32=$HOME/esp/xtensa-esp32-elf/1.22.0-80-g6c4433a-5.2.0/bin
export IDF_PATH=~/esp/esp-idf/
export esp32BuildEnvironment=~/esp/esp-idf/tools
alias itarget='idf.py set-target esp32'
alias imenu='idf.py menuconfig'
alias ibuild='idf.py build'
alias iflash='idf.py flash'
alias imonitor='idf.py monitor'

# ESP-MDF
# export MDF_PATH=~/esp/esp-mdf

# ESP-IOT
# export IOT_SOLUTION_PATH=~/esp/esp-iot-solution

# ESP8266 RTOS
# export lx106=$HOME/esp/xtensa-lx106-elf/1.22.0-92-g8facf4c-5.2.0/bin
# alias get_lx106="export PATH=$HOME/esp/xtensa-lx106-elf/1.22.0-92-g8facf4c-5.2.0/bin:$PATH"
#export IDF_PATH=~/esp/8266/ESP8266_RTOS_SDK
# source $HOME/esp/ESP8266_RTOS_SDK/add_path.sh

# ESP8266 NONOS
#export SDK_PATH=~/esp/8266/ESP8266_RTOS_SDK
#export BIN_PATH=~/esp/8266/ESP8266_RTOS_SDK/bin

function esp_write(){
FirmwareFile="$@"
Port="/dev/tty.SLAB_USBtoUART"
[[ -z "$FirmwareFile" ]] && esptool.py -p $Port write_flash -fm qio 0x0000 firmware.bin  || esptool.py -p $Port write_flash -fm dio 0x0000 $FirmwareFile -b 1500000
}

function esp_erase(){
    Port="/dev/tty.SLAB_USBtoUART"
esptool.py --port $Port erase_flash 
# esptool.py erase_flash 
}


# function esp_run(){
# if [ $? -eq 0 ];
#     then
#         printf "Writing Done."
#         for foo in $(find . -type f -name "*.bin" )
#             do
#                 esp_write $foo
#             done
# elif [ $? -eq 1 ]
#     then
#         printf "Write Error!" >&2
# fi
# }

function esp_update()
{
# Toolchain Download Link
# ESP32
# https://docs.espressif.com/projects/esp-idf/en/latest/get-started/macos-setup.html
# ESP8266
# https://github.com/espressif/ESP8266_RTOS_SDK
# IDF_PATH in 1.(project.mk Of esp-mdf) & 2.(Makefile Of esp-iot-solution) has been changed.
currentDir=$PWD && \
cd ~/esp && \
cd arduino-esp32 && \
printf "\e[32m%s\n" "Updating Arduino ESP32" && \
git pull origin master && \
git submodule update --init --recursive && \
cd .. && \
cd esp-idf && \
# git clone --recursive https://github.com/espressif/esp-idf.git
printf "\e[32m%s\n"  "Updating ESP-IDF" && \
git pull origin master && \
git submodule update --init --recursive && \
printf "\e[32m%s\n" "Updating ESPTool" && \
pip install esptool --upgrade && \
cd .. && \
cd esp-mdf && \
printf "\e[32m%s\n" "Updating ESP-MDF" && \
git pull origin master && \
git submodule update --init --recursive && \
cd .. && \
printf "\e[32m%s\n" "Updating ESP-IOT-solution" && \
cd esp-iot-solution && \
git pull origin master && \
git submodule update --init --recursive && \
cd .. && \
printf "\e[32m%s\n" "Updating ESP8266-RTOS" && \
cd ESP8266_RTOS_SDK && \
git pull origin master && \
git submodule update --init --recursive && \
cd .. && \
printf "\e[32m%s\n" "Updating ESP8266-NONOS" && \
cd ESP8266_NONOS_SDK && \
git pull origin master && \
git submodule update --init --recursive && \
printf "\e[32m%s\n" "Done" && \
cd $currentDir
}

# Mifare Card Scripts
alias nfc_config='touch /usr/local/Cellar/libnfc/1.7.1/etc/nfc/devices.d/pn532_via_uart2usb.conf && code /usr/local/Cellar/libnfc/1.7.1/etc/nfc/devices.d/pn532_via_uart2usb.conf'
alias mifare_read='bash $configLocation/Mifare\ Read.sh'
alias mifare_clone='bash $configLocation/Mifare\ Clone.sh'

# -------------------------- Path ---------------------------
export PATH=$PATH:$esp32:$esp32BuildEnvironment:$lx106:$IDF_PATH:$MDF_PATH:$IOT_SOLUTION_PATH:$DDOTNETTOOLS

function exportAll(){
      exportBash  
      exportGit 
      exportKnownHosts  
      exportBrewList  
      exportvscodeExtn  
      echo "Export Done"
}