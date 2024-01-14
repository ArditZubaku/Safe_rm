#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NO_COLOR='\033[0m'

safe_rm() {
    for dir in "$@"; do
        if [[ -d "$dir" && -d "$dir/.git" ]]; then
            echo -e "\n${YELLOW}${BOLD}Warning:${NO_COLOR} The directory '${GREEN}$dir${NO_COLOR}' is a Git repository."

            # Fetching some Git repo details
            local branch=$(git -C "$dir" branch --show-current)
            local last_commit=$(git -C "$dir" log -1 --pretty=format:"%h - %s")

            echo "${BOLD}Current branch:${NO_COLOR} ${GREEN}${branch}${NO_COLOR}"
            echo "${BOLD}Last commit:${NO_COLOR} ${GREEN}${last_commit}${NO_COLOR}"
            echo -e "${BLUE}${BOLD}Are you sure you want to delete this repository? (${GREEN}y${BLUE}/${RED}n${BLUE})${NO_COLOR}"

            while true; do
                echo -n ""
                read -r reply
                case $reply in
                    [Yy]*)
                        echo -e "${RED}Deleting${NO_COLOR} '${GREEN}$dir${NO_COLOR}'..."
                        command rm -rf "$dir"
                        echo "Repository '${GREEN}$dir${NO_COLOR}' has been deleted."
                        break;;
                    [Nn]*)
                        echo "Deletion cancelled for '${GREEN}$dir${NO_COLOR}'."
                        break;;
                    *)
                        echo -e "${YELLOW}Please answer ${GREEN}y${YELLOW} (yes) or ${RED}n${YELLOW} (no).${NO_COLOR}";;
                esac
            done
        else
            command rm -rf "$dir"
        fi
    done
}

alias rm='safe_rm'
