# <a name="home"></a>Development Enviornment
This will walk you through setting up your IDE, needed to develop and build HOOBS.

## **Table of Contents**
- [Introduction](#intro)
- [Getting Started](#start)
- [Prerequisites](#prerequisites)
- [Docker](#docker)
- [Enviornment Variables](#enviornment)
- [Download the Code](#repo)
- [Development Server](#serve)
- [Building](#building)
- [GitHub Intergration](#git)

## <a name="intro"></a>**Introduction**
The HOOBS development enviornment is designed to be ran on Debian Linux. The build routine uses Docker. This can be ran in a VM and using Visual Studio Code with the Remote SSH extention.

Prerequisites
* Debian Linux
* Visual Studio Code
* Make, GCC, GIT and Python
* Node and Yarn
* Sudo

[Top](#home)

## <a name="start"></a>**Getting Started**
First you will need to download the latest version of Debian from [www.debian.org](https://www.debian.org/distrib/).

Once you finish installing with your desired configuration. You will need to setup sudo.

Access root
```
su
```

Install sudo
```
apt-get update && apt-get install -y sudo
```

Then you need to add your user to the `sudo` group. In this example, I am using the `hoobs` user.

```
/usr/sbin/usermod -a -G sudo hoobs
```

To get sudo to work you need to logout by running `exit` twice.

[Top](#home)

## <a name="prerequisites"></a>**Prerequisites**
Once you have Debian setup with sudo, you will need to install the needed packages to run and build HOOBS.

```
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common tar git python3 make gcc g++ jq
```

Next you will need to setup the Node and Yarn repositories.

Node
```
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
```

Yarn
```
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```

Now you can install Node and Yarn.
```
sudo apt-get update && sudo apt-get install -y nodejs yarn
```

[Top](#home)

## <a name="docker"></a>**Docker**
The Docker engine is required to build the HOOBS SD Card image.

First, remove any installed Docker or Containerd packages.

```
sudo apt-get remove docker docker-engine docker.io containerd runc
```

> You might get an error, this is OK.

Now download and install Docker's GPG key.

```
sudo apt-get remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
```

Test to see if Docker's fingerprint returns anything.
```
sudo apt-key fingerprint 0EBFCD88
```

Then add the Docker repository to APT.

```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
```

Finally install Dopcker and Containerd.

```
sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```

Now because the build process and development server watches many files, you will need to increase Linux's max file watcher setting.

```
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

[Top](#home)

## <a name="enviornment"></a>**Enviornment Variables**
Now HOOBS requires some enviornment variables, which are needed for the development code. This allows the code to act like it is installed on the system.

Setting the PATH in `/etc/profile`. You can access this file using this command `sudo nano /etc/profile`.

```
if [ "`id -u`" -eq 0 ]; then
  PATH="/home/hoobs/HOOBS/cli/bin:/home/hoobs/HOOBS/hoobsd/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
else
  PATH="/home/hoobs/HOOBS/cli/bin:/home/hoobs/HOOBS/hoobsd/bin:/usr/local/bin:/usr/bin:/bin"
fi
```

Find the two **PATH** directives as above and replace the value. This will add the CLI and HOOBSD projects to the path.

Now you will need to do the same with the `/etc/sudoers` file, here's the command for that `sudo nano /etc/sudoers`.

```
Defaults        secure_path="/home/hoobs/HOOBS/cli/bin:/home/hoobs/HOOBS/hoobsd/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
```

Find the **secure_path** directive and replace it with the above. This will make sure the project paths are avaliable when you use the `sudo` command.

Next you will need to create teh HOOBS vendow file.

```
sudo nano /etc/hoobs
```

Then set the contents to this.

```
ID=card
MODEL=P3X-774
SKU=7-45114-12418-0
```

[Top](#home)

## <a name="repo"></a>**Download the Code**
Now you are ready to get the HOOBS code on you new development computer.

First go to your home directory.

```
cd ~/
```

Now clone the main HOOBS repository.

```
git clone https://github.com/hoobs-org/HOOBS.git
```

Now switch to the development branch.

```
cd ~/HOOBS
git checkout development
```

Now you are ready to setup the modules.

```
yarn setup
```

Now you will need to create the .env files for the **hoobsd** and **gui** projects.
* .env.development
* .env.production

> Note these files are private and you will need to get them from a secure location.

[Top](#home)

## <a name="serve"></a>**Development Server**
Now you have the code, you are ready to run the development server.

First you will need to build the CLI.

```
cd ~/HOOBS/cli
yarn build
```

Next you will need to initilize the hub.

```
sudo hbs install
```

Now you are ready to run HOOBS in development mode, you will need to open two terminals.

Terminal one.

```
cd ~/HOOBS/hoobsd
yarn serve
```

Terminal two

```
cd ~/HOOBS/gui
yarn serve
```

Follow the instructions in the console to access the interface.

[Top](#home)

## <a name="building"></a>**Building**
To build the image, all you need to do is run this command.

```
cd ~/HOOBS
yarn build
```

The output will be in the `~/HOOBS/builds` folder.

[Top](#home)

## <a name="git"></a>**GitHub Intergration**
There are a few commands in the tool chain that help you with syncing with GitHub.

To pull changes down

```
cd ~/HOOBS
yarn pull
```

> This will also update any modules

To push your changes up

```
cd ~/HOOBS
yarn push
```

[Top](#home)
