# <a name="home"></a>Development Enviornment
This will walk you through setting up your IDE, needed to develop and build HOOBS.

## **Table of Contents**
- [Introduction](#intro)
- [Getting Started](#start)
- [Prerequisites](#prerequisites)
- [Docker](#docker)
- [Enviornment Variables](#enviornment)
- [Download the Code](#repo)
- [Key Signing](#signing)
- [Development Server](#serve)
- [Building](#building)
- [Publishing](#publishing)
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
apt update && apt install -y sudo
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
sudo apt install -y gnupg-agent dpkg-sig sshpass apt-transport-https ca-certificates curl
```

Some build utilities are required.

```
sudo apt install -y software-properties-common tar git python3 make gcc g++ jq
```

Now you will need to install Avahi.

```
sudo apt install -y avahi-daemon avahi-discover libnss-mdns
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
sudo apt update && sudo apt install -y nodejs yarn
```

[Top](#home)

## <a name="docker"></a>**Docker**
The Docker engine is required to build the HOOBS SD Card image.

First, remove any installed Docker or Containerd packages.

```
sudo apt remove docker docker-engine docker.io containerd runc
```

> You might get an error, this is OK.

Now download and install Docker's GPG key.

```
sudo apt remove docker docker-engine docker.io containerd runc
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
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io
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

The toolchain also bounces in and out of root a lot using sudo. Adding `NOPASSWD:` to the sudoers file makes things a bit easier.

```
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL
```

> Note: We don't do this for production images.

Next you will need to create the HOOBS vendor file.

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

You can get these files from the security repository.

```
cd ~/HOOBS
git clone https://github.com/hoobs-org/security.git
```

> Note these files are protected. You will need to login to clone. You also need to be a member of the HOOBS orginization.

Now copy the hoobsd env files.
```
cd ~/HOOBS
cp ./security/hoobsd/.env.development ./hoobsd/
cp ./security/hoobsd/.env.production ./hoobsd/
```

Next copy the hoobsd env files.
```
cd ~/HOOBS
cp ./security/gui/.env.development ./gui/
cp ./security/gui/.env.production ./gui/
```

[Top](#home)

## <a name="signing"></a>**Key Signing**
HOOBS signs it's packages. The repository server is setup to require signing. You will need to import the certificate from the security repository.

Importing the keys.

```
cd ~/HOOBS
gpg --import ./security/repo/publickey.gpg
gpg --allow-secret-key-import --import ./security/repo/privatekey.gpg
```

Now check your keys to see if the hoobs key is there.

```
gpg --list-keys | grep hoobs
```

The output should look something like this.
```
uid [ultimate] hoobs <info@hoobs.org>
```

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

To build the packages.
```
cd ~/HOOBS
yarn build package
```

To build the images.
```
cd ~/HOOBS
yarn build image
```

> Note. The image build process uses the repository. You will need to publish the packages before buildiing the image.

The output will be in the `~/HOOBS/builds` folder.

[Top](#home)

## <a name="publishing"></a>**Publishing**
We publish our releases to our repository server. There are built-in commands in the tool chain to make this easy.

You can build and publish everyghing with this one command.

```
cd ~/HOOBS
yarn release
```

This command will ask you for the new version, and which Node major release to use. The Node release is not the full version, this is handled by the NodeSource repository. To get Node **14.16.0** simply enter the value **14**.

> Note. This will ask for the password for the repository.

The tool chain also allows you to publish the parts individually. This is handy for troubleshooting the build process.

To publish the packages.

```
cd ~/HOOBS
yarn upload package
```

To publish the images.

```
cd ~/HOOBS
yarn upload image
```

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
