#!/bin/bash

##################################################################################################
# hoobs-core                                                                                     #
# Copyright (C) 2020 HOOBS                                                                       #
#                                                                                                #
# This program is free software: you can redistribute it and/or modify                           #
# it under the terms of the GNU General Public License as published by                           #
# the Free Software Foundation, either version 3 of the License, or                              #
# (at your option) any later version.                                                            #
#                                                                                                #
# This program is distributed in the hope that it will be useful,                                #
# but WITHOUT ANY WARRANTY; without even the implied warranty of                                 #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                                  #
# GNU General Public License for more details.                                                   #
#                                                                                                #
# You should have received a copy of the GNU General Public License                              #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.                          #
##################################################################################################

OS=""
ARCH=""

REBOOT_AFTER="false"
INSTANCE_SUPPORT="false"
CORE_FILE=""

NODE_INSTALLED="false"
NODE_VERSION=""
NODE_TARGET=""
NODE_PREFIX=""

NPM_INSTALLED="false"
NPM_VERSION=""
NPM_TARGET=""
NPM_PREFIX=""

HOOBS_INSTALLED="false"
SELINUX_INSTALLED="false"
PACKAGE_MNGR=""

usage()
{
    echo ""
    echo "help: install [-r | --reboot] [-i | --instance] [-n | --node version]"
    echo "    Display information about builtin commands."
    echo ""
    echo "    Installs HOOBS with prerequisites, including Node, NPM and Avachi."
    echo "    This script allows you to adjust the version of Node, using the"
    echo "    -n (or --node) flag. It also allows you to adjust the version of"
    echo "    NPM using -m (or --npm) flag."
    echo ""
    echo "    Note:"
    echo "        This script requires elevated permissions, please run this with"
    echo "        SUDO or ROOT privileges."
    echo ""
    echo "    Options:"
    echo "        -r, --reboot              reboots after install"
    echo "        -i, --instance            install for instances"
    echo "        -n, --node [version]      the desired Node version"
    echo "        -m, --npm [version]       the desired NPM version"
    echo "        -c, --core [file]         file path to NPM pack file"
    echo "        --reset                   resets to factory settings"
    echo "        -h, --help                displays this help menu"
    echo ""
    echo "    Returns:"
    echo "        Returns success unless the install fails."
    echo ""
}

hr()
{
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
}

lr()
{
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

reset()
{
    echo ""
    echo "Reseting device"
    echo ""

    rm -fR /home/hoobs/.hoobs/
    shutdown -r now
}

get_os()
{
    OS=$(uname)
    ARCH=$(uname -m)
}

get_node()
{
    NODE_INSTALLED="false"
    NODE_VERSION=""
    NODE_PREFIX="/usr/local"

    if command -v node > /dev/null; then
        NODE_INSTALLED="true"
        NODE_VERSION=$(node -v)
        NODE_VERSION=${NODE_VERSION#"v"}

        WORKING="$PATH"
        IFS=':'

        read -ra ADDR <<< "$WORKING"

        for DIR in "${ADDR[@]}";
        do
            if [[ -f "$DIR/node" ]]; then
                NODE_PREFIX=$(cd $DIR/../;pwd)

                break
            fi
        done

        IFS=' '
    fi
}

get_npm()
{
    NPM_INSTALLED="false"
    NPM_VERSION=""
    NPM_PREFIX="/usr/local"

    if command -v npm > /dev/null; then
        NPM_INSTALLED="true"
        NPM_VERSION=$(npm -v)
        NPM_PREFIX=$(npm get prefix)
    fi
}

get_package_manager()
{
    if command -v yum > /dev/null; then
        PACKAGE_MNGR="yum"
    elif command -v dnf > /dev/null; then
        PACKAGE_MNGR="dnf"
    elif command -v apt-get > /dev/null; then
        PACKAGE_MNGR="apt"
    fi
}

check_existing_install()
{
    if command -v hoobs > /dev/null; then
        HOOBS_INSTALLED="true"
    else
        HOOBS_INSTALLED="false"
    fi

    if command -v setsebool > /dev/null; then
        SELINUX_INSTALLED="true"
    else
        SELINUX_INSTALLED="false"
    fi
}

install_prequsits()
{
    get_package_manager

    case $PACKAGE_MNGR in
        "yum")
            yum install -y curl tar git policycoreutils
            ;;

        "dnf")
            dnf install -y curl tar git policycoreutils
            ;;

        "apt")
            apt-get update
            apt-get install -y curl tar git
            ;;
    esac

    if [[ "$SELINUX_INSTALLED" = "true" ]]; then
        setsebool -P httpd_can_network_connect 1
    fi
}

install_node_prequsits()
{
    get_node
    get_package_manager

    case $PACKAGE_MNGR in
        "yum")
            yum install -y python make gcc gcc-c++
            ;;

        "dnf")
            dnf install -y python make gcc gcc-c++
            ;;

        "apt")
            apt-get install -y python make gcc g++
            ;;
    esac

    if [[ "$NODE_INSTALLED" = "false" ]]; then
        case $PACKAGE_MNGR in
            "yum")
                yum install -y nodejs
                ;;

            "dnf")
                dnf install -y nodejs
                ;;

            "apt")
                apt-get install -y nodejs npm
                ;;
        esac
    fi
}

install_node()
{
    export npm_config_loglevel=error

    get_os
    get_node
    get_npm

    case $OS in
        "Linux")
            case $ARCH in
                "x86_64")
                    curl -k -O https://nodejs.org/dist/v$NODE_TARGET/node-v$NODE_TARGET-linux-x64.tar.gz
                    tar -xzf ./node-v$NODE_TARGET-linux-x64.tar.gz -C $NODE_PREFIX --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$NODE_TARGET-linux-x64.tar.gz > /dev/null 2>&1

                    npm config set -g prefix $NPM_PREFIX
                    npm install -g npm@$NPM_TARGET
                    npm config set -g prefix $NPM_PREFIX

		    setcap CAP_NET_BIND_SERVICE=+eip $NODE_PREFIX/bin/node
                    ;;

                "armv6l")
                    curl -k -O https://unofficial-builds.nodejs.org/download/release/v$NODE_TARGET/node-v$NODE_TARGET-linux-armv6l.tar.gz
                    tar -xzf ./node-v$NODE_TARGET-linux-armv6l.tar.gz -C $NODE_PREFIX --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$NODE_TARGET-linux-armv6l.tar.gz > /dev/null 2>&1

                    npm config set -g prefix $NPM_PREFIX
                    npm install -g npm@$NPM_TARGET
                    npm config set -g prefix $NPM_PREFIX

		    setcap CAP_NET_BIND_SERVICE=+eip $NODE_PREFIX/bin/node
                    ;;

                "armv7l")
                    curl -k -O https://nodejs.org/dist/v$NODE_TARGET/node-v$NODE_TARGET-linux-armv7l.tar.gz
                    tar -xzf ./node-v$NODE_TARGET-linux-armv7l.tar.gz -C $NODE_PREFIX --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$NODE_TARGET-linux-armv7l.tar.gz > /dev/null 2>&1

                    npm config set -g prefix $NPM_PREFIX
                    npm install -g npm@$NPM_TARGET
                    npm config set -g prefix $NPM_PREFIX

		    setcap CAP_NET_BIND_SERVICE=+eip $NODE_PREFIX/bin/node
                    ;;

                "armv8l")
                    curl -k -O https://nodejs.org/dist/v$NODE_TARGET/node-v$NODE_TARGET-linux-arm64.tar.gz
                    tar -xzf ./node-v$NODE_TARGET-linux-arm64.tar.gz -C $NODE_PREFIX --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$NODE_TARGET-linux-arm64.tar.gz > /dev/null 2>&1

                    npm config set -g prefix $NPM_PREFIX
                    npm install -g npm@$NPM_TARGET
                    npm config set -g prefix $NPM_PREFIX

		    setcap CAP_NET_BIND_SERVICE=+eip $NODE_PREFIX/bin/node
                    ;;
            esac
            ;;

        "Darwin")
            curl -k -O https://nodejs.org/dist/v$NODE_TARGET/node-v$NODE_TARGET-darwin-x64.tar.gz
            tar -xzf ./node-v$NODE_TARGET-darwin-x64.tar.gz -C $NODE_PREFIX --strip-components=1 --no-same-owner > /dev/null 2>&1
            rm -f ./node-v$NODE_TARGET-darwin-x64.tar.gz > /dev/null 2>&1

            npm config set -g prefix $NPM_PREFIX
            npm install -g npm@$NPM_TARGET
            npm config set -g prefix $NPM_PREFIX
            ;;
    esac
}

install_npm()
{
    get_npm

    if [[ "$NPM_INSTALLED" = "false" ]]; then
        if [[ "$NPM_TARGET" == "" ]]; then
            NPM_TARGET="latest"
        fi

        npm install -g npm@$NPM_TARGET
    fi
}

clear_npm_cache()
{
    get_npm

    if [[ "$NPM_INSTALLED" = "true" ]]; then
        npm cache clean --force > /dev/null 2>&1
    fi
}

if [[ "$(id -u)" != "0" ]]; then
	usage
	exit
fi

while [ "$1" != "" ]; do
    case $1 in
        -r | --reboot )   REBOOT_AFTER="true"
                          ;;

        -i | --instance ) INSTANCE_SUPPORT="true"
                          ;;

        --reset )         reset
                          exit
                          ;;

        -n | --node )     shift
                          NODE_TARGET=$1

                          if [[ "$NODE_TARGET" == "lts" || "$NODE_TARGET" == "stable" ]]; then
                              NODE_TARGET="14.15.5"
                          elif [[ "$NODE_TARGET" == "latest" ]]; then
                              NODE_TARGET="15.2.1"
                          fi

                          ;;

        -m | --npm )      shift
                          NPM_TARGET=$1

                          if [[ "$NODE_TARGET" == "stable" || "$NODE_TARGET" == "lts" ]]; then
                              NODE_TARGET="latest"
                          fi

                          ;;

        -c | --core )     shift
                          CORE_FILE=$1
                          ;;

        -h | --help )     usage
                          exit
                          ;;

        * )               usage
                          exit
    esac

    shift
done

get_os
get_node
get_npm
get_package_manager
check_existing_install

echo ""
echo "Thank You for choosing HOOBS"
hr

if [[ "$NODE_INSTALLED" = "true" ]]; then
    echo "Node Version $NODE_VERSION"
elif [[ "$OS" == "Darwin" ]]; then
    echo "Can Not Install Node"

    lr
    echo "Please go to https://nodejs.org/ and download and install"
    echo "Node for macOS."
    lr

    exit
elif [[ "$NODE_TARGET" == "" ]]; then
    NODE_TARGET="14.15.5"
    NPM_TARGET="6.14.5"
fi

echo "Updating Repositories"

install_prequsits

if [[ "$NODE_INSTALLED" = "false" || ( "$NODE_TARGET" != "" && "$NODE_VERSION" != "$NODE_TARGET" ) ]]; then
    if [[ "$ARCH" == "armv6l" && "$NODE_TARGET" > "10.18.0" ]]; then
        echo "Can Not Install Node"

        lr
        echo "Node $NODE_VERSION is not supported on your system."
        lr
    fi

    echo ""
    echo "Installing Node"
    hr

    install_node_prequsits
    install_node
    get_node
    get_npm

    lr
    echo "Node $NODE_VERSION Installed"
    echo ""
fi

if [[ "$NPM_TARGET" != "" && "$NPM_VERSION" != "$NPM_TARGET" ]]; then
    install_npm
    get_npm

    lr
    echo "NPM $NPM_VERSION Installed"
    echo ""
fi

clear_npm_cache

if [[ "$HOOBS_INSTALLED" = "true" ]]; then
    if [[ "$NODE_TARGET" != "" ]]; then
        if [[ "$CORE_FILE" != "" ]]; then
            npm install -g --unsafe-perm "$CORE_FILE"
        else
            npm install -g --unsafe-perm @hoobs/hoobs
        fi

        npm uninstall -g @hoobs/hoobs

        if [[ "$CORE_FILE" != "" ]]; then
            npm install -g --unsafe-perm "$CORE_FILE"
        else
            npm install -g --unsafe-perm @hoobs/hoobs
        fi
    fi

    for f in /home/*;	
    do 	
        [ -d "$f/.hoobs/dist" ] && rm -fR $f/.hoobs/dist	
        [ -d "$f/.hoobs/lib" ] && rm -fR $f/.hoobs/lib	
    done;	

    [ -d "/root/.hoobs/dist" ] && rm -fR /root/.hoobs/dist	
    [ -d "/root/.hoobs/lib" ] && rm -fR /root/.hoobs/lib	

    [ -d "/var/root/.hoobs/dist" ] && rm -fR /var/root/.hoobs/dist	
    [ -d "/var/root/.hoobs/lib" ] && rm -fR /var/root/.hoobs/lib

    if [[ "$OS" != "Darwin" ]]; then
        if command -v hoobs > /dev/null; then
            echo ""
            echo "Restarting HOOBS"
            hr

            hoobs switch hoobs
            hoobs service restart

            if [[ "$REBOOT_AFTER" = "true" ]]; then
                shutdown -r now
            fi
        fi
    fi
else
    if [[ "$CORE_FILE" != "" ]]; then
        npm install -g --unsafe-perm "$CORE_FILE"
    else
        npm install -g --unsafe-perm @hoobs/hoobs
    fi

    if [[ "$INSTANCE_SUPPORT" == "false" && "$OS" != "Darwin" ]]; then
        get_node

        if command -v setcap > /dev/null; then
            setcap CAP_NET_BIND_SERVICE=+eip $NODE_PREFIX/bin/node
        fi

        if command -v hoobs > /dev/null; then
            echo ""
            echo "Initializing HOOBS"
            hr

            if [[ "$REBOOT_AFTER" = "true" ]]; then
                hoobs service install --reboot
            else
                hoobs service install
            fi

            if [[ "$REBOOT_AFTER" = "true" ]]; then
                shutdown -r now
            fi
        fi
    fi
fi
