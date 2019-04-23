
message () {
  printf "${YELLOW}"
  echo ''
  echo "$1"
  printf "${NORMAL}"
}

main() {

    # Use colors, but only if connected to a terminal, and that terminal
    # supports them.
    if which tput >/dev/null 2>&1; then
        ncolors=$(tput colors)
    fi
    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        BLUE="$(tput setaf 4)"
        BOLD="$(tput bold)"
        NORMAL="$(tput sgr0)"
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        NORMAL=""
    fi


    # update everything
    message "Updating system....."
    sudo apt-get update && sudo apt-get upgrade -y

    # install zsh
    message "Cleaning up"
    sudo apt-get remove vim-tiny -y

    message "Installing packages....."
    sudo apt-get install git zsh vim

    #make zsh default
    chsh -s /bin/zsh


    # done
    printf "${GREEN}"
    echo 'linux-home is now installed!'
    echo ''
    echo ''
    printf "${NORMAL}"
    env zsh -l

}



main