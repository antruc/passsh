#! /bin/bash

# Generate passwords and pin codes

version=2.0.0
password_length=""
pin_length=""

echo_usage() {
    echo "Usage: pass.sh -p [length] -c [length]
    
Options:
    -p [length]    Generate random password.
    -c [length]    Generate random pin code.
    -h             Prints usage and exits.
    -v             Prints version and exits."
}

generate_password() {
    strings /dev/urandom |
    grep -o "[[:alnum:]!$%&/()=?@_-]" |
    head -n $password_length |
    tr -d "\n"; echo
}

generate_pin() {
    strings /dev/urandom |
    grep -o '[0-9]' |
    head -n $pin_length |
    tr -d '\n'; echo
}

while getopts ':p:c:hv' OPTION; do
    case "$OPTION" in
        p)
            if [[ ${OPTARG} =~ ^[0-9]+$ ]]; then
                password_length="${OPTARG}"
                generate_password 
            else
                echo "Error: argument must be a number"
            fi
        ;;
        c)
            if [[ ${OPTARG} =~ ^[0-9]+$ ]]; then
                pin_length="${OPTARG}"
                generate_pin 
            else
                echo "Error: argument must be a number"
            fi
        ;;
        h)
            echo_usage
            if [ "$#" -ne 1 ]; then
                exit 1
            fi
        ;;
        v)
            echo $version
            if [ "$#" -ne 1 ]; then
                exit 1
            fi
        ;;
        ?)
            echo_usage
            exit 1
        ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    echo_usage
fi
