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
- [Publishing](#publishing)
- [GitHub Intergration](#git)

## <a name="intro"></a>**Introduction**
The HOOBS development enviornment is designed to be ran on Debian Linux. The build routine uses Docker. This can be ran in a VM and using Visual Studio Code with the Remote SSH extension.

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

And finally you will need to install the GitHub CLI.
```
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh
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
Defaults secure_path="/home/hoobs/HOOBS/cli/bin:/home/hoobs/HOOBS/hoobsd/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
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

> Note. These files are protected. You will need to login to clone. You also need to be a member of the HOOBS orginization.

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
At HOOBS we sign our packages. This ensures that our packages are untampered after releasing. The repository server is setup to require signing. You will need to import the certificate from the security repository.

Importing the keys.

```
cd ~/HOOBS
gpg --import ./security/repo/github-publickey.gpg
gpg --allow-secret-key-import --import ./security/repo/github-privatekey.gpg
```

Now check your keys to see if the hoobs key is there.

```
gpg --list-keys | grep HOOBS
```

The output should look something like this.
```
uid [unknown] HOOBS <info@hoobs.org>
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
yarn debug install
```

> For development we use port 50826 for the hub.

Now edit the development enviornment file for the GUI.
```
cd ~/HOOBS/gui
nano .env.development
```

Change the IP addresses to your IP address.

> You can obtain your IP address with this command `ip address`.

Now you are ready to run HOOBS in development mode, you will need to open two terminals.

Terminal one.

```
cd ~/HOOBS/hoobsd
yarn debug
```

Terminal two

```
cd ~/HOOBS/gui
yarn debug
```

Follow the instructions in the console to access the interface.

You can also run the desktop app, however, there are some caveats. The desktop app needs a desktop to run. Since this app is developed for Windows or macOS, you need to run on one of these operating systems.

```
cd ~/HOOBS/desktop
yarn debug
```

Starting the desktop app will also start the developer tools, which gives you access to the console, DOM, and other tools that are usefull when working on the app's code.

> Note. The desktop app repository is protected. You will need to login to clone. You also need to be a member of the HOOBS orginization.

[Top](#home)

## <a name="publishing"></a>**Publishing**
We publish our releases to our repository server. There are built-in commands in the tool chain to make this easy.

> The desktop app is published along with the other services, if it is in your repo folder.

You can build and publish everything with this one command.

```
cd ~/HOOBS
yarn release
```

This command will ask you for the new version, and which Node major release to use. The Node release is not the full version, this is handled by the NodeSource repository. To get Node **14.16.0** simply enter the value **14**.

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
