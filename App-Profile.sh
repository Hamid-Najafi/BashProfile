# ===========================================================================
# =========================== Software Developing ===========================
# ===========================================================================

# ------------------------ Applications ------------------------
# Visual Studio Code
export VSCode=/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin
alias vscode='code'
alias exportvscodeExtn='code --list-extensions | xargs -L 1 echo code --install-extension > "$VSCodeExtentionsLocaion" && echo Export Done'

# Git
git config --global color.ui true
git config --global format.pretty oneline
git config --global core.autocrl input
git config --global core.fileMode true
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias push='git pull origin master && git push origin master'
alias pull='git pull origin master'
#alias clone='git clone $1 ~/Git'
function clone()
{
    git clone $1 $devLocations/Git
}

# Homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
alias installBrew='ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew doctor'
alias exportBrewList='brew tap |  xargs -L 1 echo brew tap > "${brewListLocaion}"  && brew list | xargs -L 1 echo brew install >> "${brewListLocaion}"  && brew cask list | xargs -L 1 echo brew cask install >> "${brewListLocaion}"  && echo Export Done'

# Metasploit
export Metasploit=/opt/metasploit-framework/bin

# Fastlane
#export Fastlane=$HOME/.fastlane/bin

# Android
#export ANDROID_SDK=/Users/"$(whoami)"/Library/Developer/Xamarin/android-sdk-macosx
#export ANDROID_NDK=/Users/"$(whoami)"/Library/Developer/Xamarin/android-ndk
#export ANDROID_ROOT=$ANDROID_SDK
#export ANDROID_HOME=$ANDROID_SDK
#export NDK_ROOT=$ANDROID_NDK

# ------------------ Custom Scripts and Binaries ------------------
# Download document from wenku.baidu.com
export wkget=$appLocation/wkget/tools
export PATH=$PATH:$wkget
alias TashimBeNesbeh='cd "${appLocation}"/TashimBeNesbeh;./TashimBeNesbeh'

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
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home
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
export MYSQL_HOME=/usr/local/mysql
#export MYSQL_CLIENT=/usr/local/opt/mysql-client/bin
alias start_mysql='sudo $MYSQL_HOME/bin/mysqld_safe &'
alias stop_mysql='sudo $MYSQL_HOME/bin/mysqladmin shutdown'

# -------------------------- Path ---------------------------

export PATH=$PATH:$VSCode:$Metasploit
#export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$platformio
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
        st-write build/$fullname
        #for foo in $(find . -type f -name "*.bin" )
        #    do
             #   st-write $foo
           # done
        printf "\e[32m%s\n" "Flash Done"
    else
        printf "\e[31m%s\n" "Compile Error!" >&2
fi
}
function st-erase(){
    st-flash erase
}

# Espressif

# ESP-IDF
export esp32=$HOME/esp/xtensa-esp32-elf/1.22.0-80-g6c4433a-5.2.0/bin
export IDF_PATH=~/esp/esp-idf 
alias mm='make menuconfig'
#alias get_esp32="export PATH=$HOME/esp/xtensa-esp32-elf/1.22.0-80-g6c4433a-5.2.0/bin:$PATH"

# ESP-MDF
export MDF_PATH=~/esp/esp-mdf

# ESP-IOT
export IOT_SOLUTION_PATH=~/esp/esp-iot-solution

# ESP8266 RTOS
export lx106=$HOME/esp/xtensa-lx106-elf/1.22.0-92-g8facf4c-5.2.0/bin
#export IDF_PATH=~/esp/8266/ESP8266_RTOS_SDK
#alias get_lx106="export PATH=$HOME/esp/xtensa-lx106-elf/1.22.0-92-g8facf4c-5.2.0/bin:$PATH"

# ESP8266 NONOS
#export SDK_PATH=~/esp/8266/ESP8266_RTOS_SDK
#export BIN_PATH=~/esp/8266/ESP8266_RTOS_SDK/bin

function esp_write(){
FirmwareFile="$@"
Port="/dev/tty.SLAB_USBtoUART"
[[ -z "$FirmwareFile" ]] && esptool.py -p $Port write_flash -fm qio 0x0000 firmware.bin  || esptool.py -p $Port write_flash -fm qio 0x0000 $FirmwareFile
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

function esp_init_arduino()
{
mkdir -p components && \
cd components && \
cp -r ~/esp/arduino-esp32 . && \
cd .. && \
make menuconfig
}
function esp_update()
{
# Toolchain Download Link
# ESP32
# https://docs.espressif.com/projects/esp-idf/en/latest/get-started/macos-setup.html
# ESP8266
# https://dl.espressif.com/dl/xtensa-lx106-elf-osx-1.22.0-92-g8facf4c-5.2.0.tar.gz
# IDF_PATH in 1.(project.mk Of esp-mdf) & 2.(Makefile Of esp-iot-solution) has been changed.
currentDir=$PWD && \
cd ~/esp && \
cd arduino-esp32 && \
printf "\e[32m%s\n" "Updating Arduino ESP32" && \
git pull origin master && \
git submodule update --init --recursive && \
cd .. && \
cd esp-idf && \
printf "\e[32m%s\n"  "Updating ESP-IDF" && \
git pull origin master && \
git submodule update && \
printf "\e[32m%s\n" "Updating ESPTool" && \
pip install esptool --upgrade && \
cd .. && \
cd esp-mdf && \
printf "\e[32m%s\n" "Updating ESP-MDF" && \
git pull origin master && \
git submodule update && \
cd .. && \
printf "\e[32m%s\n" "Updating ESP-IOT-solution" && \
cd esp-iot-solution && \
git pull origin master && \
git submodule update && \
printf "\e[32m%s\n" "Done" && \
cd $currentDir
}

# Mifare Card Scripts
alias nfc_config='touch /usr/local/Cellar/libnfc/1.7.1/etc/nfc/devices.d/pn532_via_uart2usb.conf && code /usr/local/Cellar/libnfc/1.7.1/etc/nfc/devices.d/pn532_via_uart2usb.conf'
alias mifare_read='bash $configLocation/Mifare\ Read.sh'
alias mifare_clone='bash $configLocation/Mifare\ Clone.sh'

# -------------------------- Path ---------------------------
export PATH=$PATH:$esp32:$lx106:$IDF_PATH:$MDF_PATH:$IOT_SOLUTION_PATH
