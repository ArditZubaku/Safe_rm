#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NO_COLOR='\033[0m'

safe_rm() {
    for dir in "$@"; do
        if [[ -d "$dir" && ( (-d "$dir/.git") || (-d "$(git -C "$dir" rev-parse --git-dir 2>/dev/null)") ) ]]; then
            echo -e "\n${YELLOW}${BOLD}Warning:${NO_COLOR} The directory '${GREEN}$dir${NO_COLOR}' is a Git repository."

            local branch=""
            local last_commit=""
            local stash_count=""

            if git -C "$dir" rev-parse --is-inside-work-tree &>/dev/null; then
                branch=$(git -C "$dir" branch --show-current)
                last_commit=$(git -C "$dir" log -1 --pretty=format:"%h - %s")
                stash_count=$(git -C "$dir" stash list | wc -l)
            else
                echo "${RED}Error:${NO_COLOR} Not a Git repository: '$dir'. Skipping Git information."
            fi

            echo "${BOLD}Current branch:${NO_COLOR} ${GREEN}${branch}${NO_COLOR}"
            echo "${BOLD}Last commit:${NO_COLOR} ${GREEN}${last_commit}${NO_COLOR}"

            if [[ $stash_count -gt 0 ]]; then
                echo "${BOLD}Stash count:${NO_COLOR} ${GREEN}${stash_count}${NO_COLOR}"
            else
                echo "${BOLD}Stash count:${NO_COLOR} ${RED}0${NO_COLOR}"
            fi

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
