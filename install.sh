#!/bin/bash

os=$(uname)
arch=$(uname -m)

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

echo ""
echo "Thank You for choosing HOOBS"
echo "---------------------------------------------------------"

spin &
marker=$!

trap "kill -9 $marker" `seq 0 15`

sleep 0.2

echo "Node Version $node"

case $os in
    "Linux")
        if command -v dnf > /dev/null; then
            if [[ "$node" < "12.13.1" ]]; then
                echo "Updating Node"

                curl -O https://nodejs.org/dist/v12.13.1/node-v12.13.1-linux-x64.tar.gz > /dev/null 2>&1
                tar -xzf ./node-v12.13.1-linux-x64.tar.gz -C /usr --strip-components=1 --no-same-owner > /dev/null 2>&1
                rm -f ./node-v12.13.1-linux-x64.tar.gz > /dev/null 2>&1

                node=$(node -v)
                node=${node#"v"}

                echo "Node Updated to $node"

                source ~/.bashrc

                sleep 0.2
            fi
        elif command -v apt-get > /dev/null; then
            sleep 0.2

            echo "Updating Repositories"

            apt-get update > /dev/null 2>&1
            apt-get install -y curl tar > /dev/null 2>&1

            if [[ "$node" < "12.13.1" ]]; then
                case $arch in
                    "x86_64")
                        echo "Upgrading Node"

                        curl -O https://nodejs.org/dist/v12.13.1/node-v12.13.1-linux-x64.tar.gz > /dev/null 2>&1
                        tar -xzf ./node-v12.13.1-linux-x64.tar.gz -C /usr/local --strip-components=1 --no-same-owner > /dev/null 2>&1
                        rm -f ./node-v12.13.1-linux-x64.tar.gz > /dev/null 2>&1

                        node=$(node -v)
                        node=${node#"v"}

                        echo "Node Updated to $node"
                        ;;

                    "armv7l")
                        echo "Upgrading Node"

                        curl -O https://nodejs.org/dist/v12.13.1/node-v12.13.1-linux-armv7l.tar.gz > /dev/null 2>&1
                        tar -xzf ./node-v12.13.1-linux-armv7l.tar.gz -C /usr/local --strip-components=1 --no-same-owner > /dev/null 2>&1
                        rm -f ./node-v12.13.1-linux-armv7l.tar.gz > /dev/null 2>&1

                        node=$(node -v)
                        node=${node#"v"}

                        echo "Node Updated to $node"
                        ;;

                    "armv8l")
                        echo "Upgrading Node"

                        curl -O https://nodejs.org/dist/v12.13.1/node-v12.13.1-linux-arm64.tar.gz > /dev/null 2>&1
                        tar -xzf ./node-v12.13.1-linux-arm64.tar.gz -C /usr/local --strip-components=1 --no-same-owner > /dev/null 2>&1
                        rm -f ./node-v12.13.1-linux-arm64.tar.gz > /dev/null 2>&1

                        node=$(node -v)
                        node=${node#"v"}

                        echo "Node Updated to $node"
                        ;;
                esac
            fi

            source ~/.bashrc

            sleep 0.2
        fi

        echo "Cleaning NPM"

        npm cache clean --force > /dev/null 2>&1
        npm install -g npm > /dev/null 2>&1

        source ~/.bashrc

        sleep 0.2
        ;;

    "Darwin")
        if [[ "$node" < "12.13.1" ]]; then
            echo "Upgrading Node"

            curl -O https://nodejs.org/dist/v12.13.1/node-v12.13.1-darwin-x64.tar.gz
            tar -xzf ./node-v12.13.1-darwin-x64.tar.gz -C /usr/local --strip-components=1 --no-same-owner
            rm -f ./node-v12.13.1-darwin-x64.tar.gz

            node=$(node -v)
            node=${node#"v"}

            echo "Node Updated to $node"
        fi

        sleep 0.2

        echo "Cleaning NPM"

        npm cache clean --force > /dev/null 2>&1
        npm install -g npm > /dev/null 2>&1

        sleep 0.2
        ;;
esac

echo "Installing HOOBS"

npm install -g --unsafe-perm @hoobs/hoobs > /dev/null 2>&1

sleep 3

kill -9 $marker

echo "Configuring"
echo "---------------------------------------------------------"
echo ""
echo ""
echo "Initializing HOOBS"
echo "---------------------------------------------------------"

hoobs-init
