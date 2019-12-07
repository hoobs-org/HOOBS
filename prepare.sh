#!/bin/bash

os=$(uname)
arch=$(uname -m)

required_node_version="12.13.1"
required_npm_version="6.13.1"

node_version=$(node -v)
node_version=${node_version#"v"}

npm_version=$(npm -v)

spin()
{
    spinner="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"

    while :
    do
        for i in `seq 0 7`
        do
            printf "\r\e[93m${spinner:$i:1}\e[0m "
            sleep 0.2
        done
    done
}

install_node()
{
    case $os in
        "Linux")
            case $arch in
                "x86_64")
                    curl -O https://nodejs.org/dist/v$required_node_version/node-v$required_node_version-linux-x64.tar.gz > /dev/null 2>&1
                    tar -xzf ./node-v$required_node_version-linux-x64.tar.gz -C $1 --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required_node_version-linux-x64.tar.gz > /dev/null 2>&1
                    ;;

                "armv7l")
                    curl -O https://nodejs.org/dist/v$required_node_version/node-v$required_node_version-linux-armv7l.tar.gz > /dev/null 2>&1
                    tar -xzf ./node-v$required_node_version-linux-armv7l.tar.gz -C $1 --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required_node_version-linux-armv7l.tar.gz > /dev/null 2>&1
                    ;;

                "armv8l")
                    curl -O https://nodejs.org/dist/v$required_node_version/node-v$required_node_version-linux-arm64.tar.gz > /dev/null 2>&1
                    tar -xzf ./node-v$required_node_version-linux-arm64.tar.gz -C $1 --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required_node_version-linux-arm64.tar.gz > /dev/null 2>&1
                    ;;
            esac
            ;;

        "Darwin")
            curl -O https://nodejs.org/dist/v$required_node_version/node-v$required_node_version-darwin-x64.tar.gz > /dev/null 2>&1
            tar -xzf ./node-v$required_node_version-linux-x64.tar.gz -C $1 --strip-components=1 --no-same-owner > /dev/null 2>&1
            rm -f ./node-v$required_node_version-linux-x64.tar.gz > /dev/null 2>&1
            ;;
    esac
}

echo ""
echo "Checking Node"
echo "------------------------------------------------------------"

spin &
marker=$!

sleep 0.2

echo "Node Version $node_version"

case $os in
    "Linux")
        if command -v yum > /dev/null; then
            if [[ "$node_version" == "" ]]; then
                sleep 0.2

                echo "Installing Node"

                yum install -y python make gcc gcc-c++ nodejs > /dev/null 2>&1

                sleep 3

                node_version=$(node -v)
                node_version=${node_version#"v"}
            fi

            if [[ "$node_version" < "$required_node_version" ]]; then
                sleep 0.2

                echo "Updating Node"

                install_node /usr/local

                node_version=$(node -v)
                node_version=${node_version#"v"}

                sleep 0.2

                echo "Node $node_version Installed"
                source ~/.bashrc
            fi
        elif command -v apt-get > /dev/null; then
            sleep 0.2

            echo "Updating Repositories"

            apt-get update > /dev/null 2>&1
            apt-get install -y curl tar > /dev/null 2>&1

            if [[ "$node_version" == "" ]]; then
                sleep 0.2

                echo "Installing Node"

                apt-get install -y python make gcc g++ nodejs npm > /dev/null 2>&1

                node_version=$(node -v)
                node_version=${node_version#"v"}
            fi

            if [[ "$node_version" < "$required_node_version" ]]; then
                sleep 0.2

                echo "Upgrading Node"

                install_node /usr/local

                rm -f /usr/bin/node > /dev/null 2>&1

                unlink /usr/bin/nodejs > /dev/null 2>&1
                unlink /usr/bin/npm > /dev/null 2>&1
                unlink /usr/bin/npx > /dev/null 2>&1

                node_version=$(node -v)
                node_version=${node_version#"v"}

                sleep 0.2

                echo "Node $node_version Installed"
            fi

            source ~/.bashrc
        fi

        sleep 0.2

        npm_version=$(npm -v)

        echo "NPM Version $npm_version"

        if [[ "$npm_version" < "$required_npm_version" ]]; then
            sleep 0.2

            echo "Upgrading NPM"

            npm install -g npm > /dev/null 2>&1

            npm_version=$(npm -v)

            echo "NPM $npm_version Installed"
        fi

        npm cache clean --force > /dev/null 2>&1

        source ~/.bashrc
        ;;

    "Darwin")
        if [[ "$node_version" == "" ]]; then
            kill -9 $marker > /dev/null

            echo "Can Not Install Node"
            echo "------------------------------------------------------------"
            echo "Please go to https://nodejs.org/ and download and install   "
            echo "Node for macOS.                                             "
            echo "------------------------------------------------------------"

            exit 1
        fi

        if [[ "$node_version" < "$required_node_version" ]]; then
            sleep 0.2

            echo "Upgrading Node"

            install_node /usr/local

            node_version=$(node -v)
            node_version=${node_version#"v"}

            sleep 0.2

            echo "Node $node_version Installed"
        fi

        sleep 0.2

        npm_version=$(npm -v)

        echo "NPM Version $npm_version"

        if [[ "$npm_version" < "$required_npm_version" ]]; then
            sleep 0.2

            echo "Upgrading NPM"

            npm install -g npm > /dev/null 2>&1

            npm_version=$(npm -v)

            echo "NPM $npm_version Installed"
        fi

        npm cache clean --force > /dev/null 2>&1
        ;;
esac

kill -9 $marker > /dev/null

sleep 1

echo "------------------------------------------------------------"
echo "Node has been upgraded. You now can upgrade HOOBS.          "
echo "------------------------------------------------------------"
