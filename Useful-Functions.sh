
function downloadURLRecursive()
{
read -p "Enter Download URL:" Downloadurl
read -p "Enter Save location:" DownloadToDir
wget -r -l5 -P $DownloadToDir $Downloadurl
}
function checkPort(){
Port="$@"
lsof -i :$Port
# kill proccess
}

exit() {
    read -t5 -n1 -p "Do you really wish to exit? [Y/N] " should_exit || should_exit=y
    case $should_exit in
        [Yy] ) builtin exit $1 ;;
        * ) echo "\n" ;;
    esac
}
