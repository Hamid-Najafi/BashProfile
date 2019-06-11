
# SSH Servers
alias networkLabServer='ssh nls@network-lab-server.local'
alias raspberryPi='ssh pi@raspberrypi.local'

# Locations 
appLocation="/Users/"$(whoami)"/Dev/Apps"
configLocation="/Users/"$(whoami)"/Dev/Configs"
projectsLocation="/Users/"$(whoami)"/Dev"
brewListLocaion="$configLocation/Brew List/Brew List.command"
bashprofileLocation="$configLocation/Bash/Bash Profile.txt"
zshrcLocation="$configLocation/Bash/ZSHRC.txt"
VSCodeExtentionsLocaion="$configLocation/VSCode Extentions/VSCode Extentions.command"

# Custom Directories
alias software='cd $projectsLocation/Software'
alias hardware='cd $projectsLocation/Hardware'
alias msfmodule='cd /opt/metasploit-framework/embedded/framework/modules'

# Ferdowsi Hotspot User
alias fum_hotspot_logout='curl -s -G https://hotspot.um.ac.ir/logout > /dev/null && printf "\e[31;1m%s\n\e[0m" "FUM Hotspot Logged Out" || printf "\e[31;1m%s\n\e[0m" "Could not resolve host: hotspot.um.ac.ir"'
alias fum_hotspot_login_hamid='ChaeckHotspotInternetConnection; curl -s -d "password=c4c696ae0e63a98932e25c6f64bde5a8&username=9412101168" -X POST https://hotspot.um.ac.ir/login > /dev/null && printf "\e[33;1m%s\n\e[0m" "User Hamid Logged In" || printf "\e[31;1m%s\n\e[0m" "Could not resolve host: hotspot.um.ac.ir"'
alias fum_hotspot_login_shahla='ChaeckHotspotInternetConnection; curl -s -d "password=c7187c42b3be68cde72b2b4e2bb37a4c&username=9412101099" -X POST https://hotspot.um.ac.ir/login > /dev/null && printf "\e[33;1m%s\n\e[0m" "User Shahla Logged In" || printf "\e[31;1m%s\n\e[0m" "Could not resolve host: hotspot.um.ac.ir"'
alias hhamid=fum_hotspot_login_hamid
alias hshahla=fum_hotspot_login_shahla
alias hlogout=fum_hotspot_logout

function ChaeckHotspotInternetConnection(){
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
    printf "\e[32;1m%s\n\e[0m" "Already Coonected"
    fum_hotspot_logout
else
    printf "\e[31;1m%s\n\e[0m" "No Internet Coonection"
fi
}
