#!/bin/bash
black='\e[0;30m';blue='\e[0;34m';green='\e[0;32m';cyan='\e[0;36m';red='\e[0;31m';purple='\e[0;35m';brown='\e[0;33m';lightgray='\e[0;37m';darkgray='\e[1;30m';lightblue='\e[1;34m';lightgreen='\e[1;32m';lightcyan='\e[1;36m';lightred='\e[1;31m';lightpurple='\e[1;35m';y='\e[1;33m';white='\e[1;37m';nc='\e[0m'
devicelist=(s3ve3gxx s3ve3gjv s3ve3gds milletwifi milletlte milletltetmo millet3g matissewifi matisselte matisse3g)
printdevicelist() {
    for ((i=0;i<$(expr ${#devicelist} + 1);i++)) {
        echo -ne "$lightblue$(expr $i + 1)) $nc${devicelist[$i]} "
    }
}
checkchoice() {
    if [ -z "$userChoice" ]; then
        echo -e $lightred"ERROR: no device was chosen."$nc
        exit 1
    fi
    spellCheck=false
    for ((i=1;i<$(expr ${#devicelist} + 2);i++)) {
        if [ "$userChoice" = "$i" ]; then
            spellCheck=true
        fi
    }
    if [ $spellCheck != false ]; then
        echo -e $lightgreen"OK"$nc
    else
        echo -e $lightred"ERROR: Chosen device $userChoice was not found."$nc
        exit 1
    fi
}
putman() {
    args=(${@})
    for ((i=0;i<=$(expr $# - 1);i++)) {
        cp $PWD/manifests/${args[$i]}.xml $srcdir/.repo/local_manifests/${args[$i]}.xml
    }
}
getdeviceman() {
    srcdir="$HOME$userDir"
    [ -d "$srcdir/.repo/local_manifests" ] && rm -rf "$srcdir/.repo/local_manifests"
    [ ! -d "$srcdir/.repo/local_manifests" ] && mkdir "$srcdir/.repo/local_manifests"
    case "${devicelist[$(expr $userChoice - 1)]}" in
        s3ve3gxx) putman main_neo s3ve3gxx
        ;;
        s3ve3gjv) putman main_neo s3ve3gjv
        ;;
        s3ve3gds) putman main_neo s3ve3gds
        ;;
        matissewifi) putman main_matisse matissewifi
        ;;
        matisse3g) putman main_matisse matisse3g
        ;;
        matisselte) putman main_matisse matisselte
        ;;
        milletltetmo) putman main_millet milletltetmo
        ;;
        milletlte) putman main_millet milletlte
        ;;
        millet3g) putman main_millet millet3g
        ;;
        milletwifi) putman main_millet milletwifi
        ;;
    esac
}

menu() {
    echo -e $y"Welcome! Choose device number to use local manifest from (Android 11):"$nc
    echo -e $y"$(printdevicelist)"$nc
    echo -ne $cyan"choose manifest> "
    read userChoice
    checkchoice
    echo -e $y"What's your sources directory?"$nc
    echo -ne $cyan"choose directory> $HOME"
    read userDir
    [ -z "$userDir" ] && echo -e $lightred"ERROR: you can't build in the home folder."$nc && exit 1
    [ ! -d "$HOME$userDir" ] && echo -e $lightred"ERROR: Chosen directory $HOME$userDir was not found."$nc && exit 1
    echo -e $y"Putting manifest..."$nc
    getdeviceman
    echo -e $lightgreen"ALL DONE"$nc
}

menu
