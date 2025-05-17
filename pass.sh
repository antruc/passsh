#! /bin/bash

# Generate passwords and pin codes

usage()
{
    echo "Usage: ./pass.sh [-c] [-d]"
}
if [[ -n "$1" ]] then
    while getopts "cd" OPTION; do
        case "$OPTION" in 
            c)
                strings /dev/urandom |
                grep -o "[[:alnum:]!$%&/()=?@_-]" |
                head -n 20 | # 20 character password
                tr -d "\n"; echo
            ;;
            d)
                strings /dev/urandom |
                grep -o "[0-9]" |
                head -n 4 | # 4 digit PIN
                tr -d "\n"; echo
            ;;
            ?)
                usage
                exit 1
            ;;
        esac
    done
else
    usage
fi
