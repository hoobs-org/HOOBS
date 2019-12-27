#!/bin/bash

os=$(uname)
arch=$(uname -m)

required_node_version="10.17.0"
required_npm_version="6.11.3"

get_node_version()
{
    version=""

    if command -v node > /dev/null; then
        version=$(node -v)
        version=${version#"v"}
    fi

    echo $version
}

find_node()
{
    if command -v node > /dev/null; then
        IFS=':'

        read -ra ADDR <<< "$PATH"

        for path in "${ADDR[@]}"; do
            if [[ -f "$path/node" ]]; then
                echo $(cd $path/../;pwd)

                break
            fi
        done

        IFS=' '
    else
        echo "/usr/local"
    fi
}

install_node()
{
    if command -v yum > /dev/null; then
        yum install -y python make gcc gcc-c++ nodejs
    elif command -v apt-get > /dev/null; then
        apt-get install -y python make gcc g++ nodejs npm
    fi
}

uninstall_node()
{
    rm -f $1/bin/node > /dev/null 2>&1

    unlink $1/bin/nodejs > /dev/null 2>&1
    unlink $1/bin/npm > /dev/null 2>&1
    unlink $1/bin/npx > /dev/null 2>&1
}

upgrade_node()
{
    node_path=$(find_node)

    export npm_config_loglevel=error

    npm_prefix=$(npm get prefix)

    case $os in
        "Linux")
            case $arch in
                "x86_64")
                    uninstall_node $node_path

                    curl -k -O https://nodejs.org/dist/v$required_node_version/node-v$required_node_version-linux-x64.tar.gz
                    tar -xzf ./node-v$required_node_version-linux-x64.tar.gz -C $node_path --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required_node_version-linux-x64.tar.gz > /dev/null 2>&1

                    npm config set -g prefix $npm_prefix
                    npm install -g npm@$required_npm_version
                    npm config set -g prefix $npm_prefix
                    ;;

                "armv6l")
                    uninstall_node $node_path

                    curl -k -O https://nodejs.org/dist/v$required_node_version/node-v$required_node_version-linux-armv6l.tar.gz
                    tar -xzf ./node-v$required_node_version-linux-armv7l.tar.gz -C $node_path --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required_node_version-linux-armv7l.tar.gz > /dev/null 2>&1

                    npm config set -g prefix $npm_prefix
                    npm install -g npm@$required_npm_version
                    npm config set -g prefix $npm_prefix
                    ;;

                "armv7l")
                    uninstall_node $node_path

                    curl -k -O https://nodejs.org/dist/v$required_node_version/node-v$required_node_version-linux-armv7l.tar.gz
                    tar -xzf ./node-v$required_node_version-linux-armv7l.tar.gz -C $node_path --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required_node_version-linux-armv7l.tar.gz > /dev/null 2>&1

                    npm config set -g prefix $npm_prefix
                    npm install -g npm@$required_npm_version
                    npm config set -g prefix $npm_prefix
                    ;;

                "armv8l")
                    uninstall_node $node_path

                    curl -k -O https://nodejs.org/dist/v$required_node_version/node-v$required_node_version-linux-arm64.tar.gz
                    tar -xzf ./node-v$required_node_version-linux-arm64.tar.gz -C $node_path --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required_node_version-linux-arm64.tar.gz > /dev/null 2>&1

                    npm config set -g prefix $npm_prefix
                    npm install -g npm@$required_npm_version
                    npm config set -g prefix $npm_prefix
                    ;;
            esac
            ;;

        "Darwin")
            uninstall_node $node_path

            curl -O https://nodejs.org/dist/v$required_node_version/node-v$required_node_version-darwin-x64.tar.gz
            tar -xzf ./node-v$required_node_version-linux-x64.tar.gz -C $node_path --strip-components=1 --no-same-owner > /dev/null 2>&1
            rm -f ./node-v$required_node_version-linux-x64.tar.gz > /dev/null 2>&1

            npm config set -g prefix $npm_prefix
            npm install -g npm@$required_npm_version
            npm config set -g prefix $npm_prefix
            ;;
    esac
}

echo ""
echo "Thank You for choosing HOOBS"
echo "---------------------------------------------------------"

node_version=$(get_node_version)

if [[ "$node_version" != "" ]]; then
    echo "Node Version $node_version"
fi

if [[ "$os" == "Darwin" && "$node_version" == "" ]]; then
    echo "Can Not Install Node"
    echo "------------------------------------------------------------"
    echo "Please go to https://nodejs.org/ and download and install   "
    echo "Node for macOS.                                             "
    echo "------------------------------------------------------------"

    exit 1
fi

echo "Updating Repositories"

if command -v yum > /dev/null; then
    yum install -y curl tar git
elif command -v apt-get > /dev/null; then
    apt-get update
    apt-get install -y curl tar git
fi

if [[ "$node_version" == "" ]]; then
    echo "Installing Node"

    install_node
    upgrade_node
    node_version=$(get_node_version)

    echo "Node $node_version Installed"

    npm_version=$(npm -v)

    echo "NPM $npm_version Installed"
fi

npm cache clean --force > /dev/null 2>&1

echo "---------------------------------------------------------"
echo ""

npm install -g --unsafe-perm @hoobs/hoobs
sleep 3

if [[ "$os" != "Darwin" ]]; then
    if command -v hoobs-init > /dev/null; then
        echo ""
        echo "Initializing HOOBS"
        echo "---------------------------------------------------------"

        hoobs-init
    fi
fi
