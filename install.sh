#!/bin/bash

os=$(uname)
arch=$(uname -m)

required="12.13.1"

node=$(node -v)
node=${node#"v"}

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
                    curl -O https://nodejs.org/dist/v$required/node-v$required-linux-x64.tar.gz > /dev/null 2>&1
                    tar -xzf ./node-v$required-linux-x64.tar.gz -C $1 --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required-linux-x64.tar.gz > /dev/null 2>&1
                    ;;

                "armv7l")
                    curl -O https://nodejs.org/dist/v$required/node-v$required-linux-armv7l.tar.gz > /dev/null 2>&1
                    tar -xzf ./node-v$required-linux-armv7l.tar.gz -C $1 --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required-linux-armv7l.tar.gz > /dev/null 2>&1
                    ;;

                "armv8l")
                    curl -O https://nodejs.org/dist/v$required/node-v$required-linux-arm64.tar.gz > /dev/null 2>&1
                    tar -xzf ./node-v$required-linux-arm64.tar.gz -C $1 --strip-components=1 --no-same-owner > /dev/null 2>&1
                    rm -f ./node-v$required-linux-arm64.tar.gz > /dev/null 2>&1
                    ;;
            esac
            ;;

        "Darwin")
            curl -O https://nodejs.org/dist/v$required/node-v$required-darwin-x64.tar.gz > /dev/null 2>&1
            tar -xzf ./node-v$required-linux-x64.tar.gz -C $1 --strip-components=1 --no-same-owner > /dev/null 2>&1
            rm -f ./node-v$required-linux-x64.tar.gz > /dev/null 2>&1
            ;;
    esac
}

echo ""
echo "Thank You for choosing HOOBS"
echo "---------------------------------------------------------"

spin &
marker=$!

if [[ "$os" != "Darwin" ]]; then
    trap "kill -9 $marker" `seq 0 15`
fi

sleep 0.2

echo "Node Version $node"

case $os in
    "Linux")
        if command -v yum > /dev/null; then
            if [[ "$node" == "" ]]; then
                sleep 0.2

                echo "Installing Node"

                yum install -y nodejs > /dev/null 2>&1

                sleep 3

                node=$(node -v)
                node=${node#"v"}
            fi

            if [[ "$node" < "$required" ]]; then
                sleep 0.2

                echo "Updating Node"

                install_node /usr

                node=$(node -v)
                node=${node#"v"}

                sleep 0.2

                echo "Node $node Installed"
                source ~/.bashrc
            fi
        elif command -v apt-get > /dev/null; then
            sleep 0.2

            echo "Updating Repositories"

            apt-get update > /dev/null 2>&1
            apt-get install -y curl tar > /dev/null 2>&1

            if [[ "$node" == "" ]]; then
                sleep 0.2

                echo "Installing Node"

                apt-get install -y nodejs npm > /dev/null 2>&1

                node=$(node -v)
                node=${node#"v"}
            fi

            if [[ "$node" < "$required" ]]; then
                sleep 0.2

                echo "Upgrading Node"

                install_node /usr/local

                node=$(node -v)
                node=${node#"v"}

                sleep 0.2

                echo "Node $node Installed"
            fi

            source ~/.bashrc
        fi

        sleep 0.2

        echo "Cleaning NPM"

        npm cache clean --force > /dev/null 2>&1
        npm install -g npm > /dev/null 2>&1

        source ~/.bashrc
        ;;

    "Darwin")
        if [[ "$node" == "" ]]; then
            kill -9 $marker > /dev/null

            echo "Can Not Install Node"
            echo "---------------------------------------------------------"
            echo "Please go to https://nodejs.org/ and download and"
            echo "install Node for macOS."
            echo "---------------------------------------------------------"

            exit 1
        fi

        if [[ "$node" < "$required" ]]; then
            sleep 0.2

            echo "Upgrading Node"

            install_node /usr/local

            node=$(node -v)
            node=${node#"v"}

            sleep 0.2

            echo "Node $node Installed"
        fi

        sleep 0.2

        echo "Cleaning NPM"

        npm cache clean --force > /dev/null 2>&1
        npm install -g npm > /dev/null 2>&1
        ;;
esac

sleep 0.2

echo "Installing HOOBS"

npm install -g --unsafe-perm @hoobs/hoobs > /dev/null 2>&1

sleep 3

kill -9 $marker > /dev/null

echo "Configuring"
echo "---------------------------------------------------------"
echo ""

if [[ "$os" != "Darwin" ]]; then
    echo ""
    echo "Initializing HOOBS"
    echo "---------------------------------------------------------"

    hoobs-init
fi
