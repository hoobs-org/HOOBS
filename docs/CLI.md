# <a name="home"></a>CLI
The HOOBS command line interface is the software that manages bridges. Below is a list of commands and actions available in the HOOBS CLI.

## **Table of Contents**
- Daemon
    - [Hub](#daemon.hub)
    - [Bridge](#daemon.bridge)
    - [Service](#daemon.service)
- [Install](#install)
- [Bridge](#bridge)
    - [Add](#bridge.add)
    - [Cache](#bridge.cache)
    - [Purge](#bridge.purge)
    - [Remove](#bridge.remove)
    - [Export](#bridge.export)
    - [List](#bridge.list)
- [Plugin](#plugin)
    - [Add](#plugin.add)
    - [Remove](#plugin.remove)
    - [Update](#plugin.update)
    - [List](#plugin.list)
    - [Create](#plugin.create)
- [Config](#config)
- [Log](#log)
- [Extention](#extention)
    - [Add](#extention.add)
    - [Remove](#extention.remove)
    - [List](#extention.list)
- [System](#system)
    - [Versions](#system.versions)
    - [Hostname](#system.hostname)
    - [Upgrade](#system.upgrade)
    - [Backup](#system.backup)
    - [Restore](#system.restore)
    - [Rreset](#system.reset)

## <a name="daemon.hub"></a>Hub (Daemon)
This starts the hub service. This is needed to manage the bridges. It is also the default command when no other command is defined.

```
sudo hoobsd hub
```

Available options
| Flag                  | Description                                         |
| --------------------- | --------------------------------------------------- |
| -d, --debug           | Turn on debug level logging                         |
| -v, --verbose         | Tuen on insane verbose logging                      |
| -p, --port <port>     | Override the defined hub port                       |
| -o, --orphans         | Keep cached accessories for orphaned plugins        |
| -c, --container       | This changes the paths needed for Docker containers |

[Top](#home)

## <a name="daemon.bridge"></a>Bridge (Daemon)
This starts bridges.

```
sudo hoobsd bridge -b 'my-bridge'
```

Available options
| Flag                  | Description                                         |
| --------------------- | --------------------------------------------------- |
| -d, --debug           | Turn on debug level logging                         |
| -v, --verbose         | Tuen on insane verbose logging                      |
| -b, --bridge <name>   | Define the bridge to start, can be the name or id   |
| -p, --port <port>     | Override the port defined on the bridge             |
| -o, --orphans         | Keep cached accessories for orphaned plugins        |
| -c, --container       | This changes the paths needed for Docker containers |

> If an bridge name is not included the default is **default**

[Top](#home)

## <a name="daemon.service"></a>Service (Daemon)
This controls the service installed on the system. To create the service use the HOOBS CLI.

```
sudo hoobsd service start
```

Available actions
| Action  | Description                          |
| ------- | ------------------------------------ |
| start   | This will start the defined bridge   |
| stop    | This will stop the defined bridge    |
| restart | This will restart the defined bridge |

Available options
| Flag                  | Description                                         |
| --------------------- | --------------------------------------------------- |
| -d, --debug           | Turn on debug level logging                         |

[Top](#home)

## <a name="install"></a>Install
This initilizes the system. It creates the special hub bridge. The hub bridge is a control hub for all other bridges.

```
sudo hbs install
```

Available options
| Flag              | Description                                                |
| ----------------- | ---------------------------------------------------------- |
| -p, --port <port> | Sets the port for the hub, if not set the CLI will ask you |
| -s, --skip        | This will skip the systemd or launchd service create       |
| -c, --container   | This changes the paths needed for Docker containers        |

[Top](#home)

## <a name="bridge"></a>Bridge
This controls bridges on the system. It can be used to list, create and remove bridges.

> This also creates and starts systemd and launchd services. If your system doesn't have either of these systems, the CLI will not attempt this.

[Top](#home)

#### <a name="bridge.add"></a>Add
*alias **create***  

This will create an bridge.

```
sudo hbs bridge create
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -b, --bridge <name>   | Defines a name for the bridge                        |
| -p, --port <port>     | Sets the port for the bridge                         |
| -n, --pin <pin>       | Sets the pin for bridge paring                       |
| -s, --skip            | This will skip the systemd or launchd service create |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the bridge name or port is not set the CLI will ask for this information.

[Top](#home)

#### <a name="bridge.cache"></a>Cache
This will display cached accessories for a bridge.

```
sudo hbs bridge cache
```

Available options
| Flag                  | Description                                          |
| --------------------  | ---------------------------------------------------- |
| -b, --bridge <name>   | Selects a bridge                                     |

> If the bridge name or port is not set the CLI will ask for this information.

[Top](#home)

#### <a name="bridge.purge"></a>Purge
This will purge all persisted and cache files for a bridge.

```
sudo hbs bridge purge
```

Available options
| Flag                  | Description                                          |
| --------------------  | ---------------------------------------------------- |
| -b, --bridge <name>   | Selects a bridge                                     |
| -u, --uuid <UUID>     | Remove a specific accessory from the cache           |

> If the bridge name or port is not set the CLI will ask for this information.  
> This will require you to re-pair with Apple Home.

[Top](#home)

#### <a name="bridge.remove"></a>Remove
*alias **rm***  

This will remove an bridge.

```
sudo hbs bridge remove
```

> This will remove all configs and plugins.

Available options
| Flag                | Description                                          |
| ------------------- | ---------------------------------------------------- |
| -b, --bridge <name> | Defines bridge to be removed                         |
| -s, --skip          | This will skip the systemd or launchd service create |
| -c, --container     | This changes the paths needed for Docker containers  |

> If the bridge name is not set the CLI will ask for this information.

[Top](#home)

#### <a name="bridge.export"></a>Export
This will export an bridge to your current working directory.

```
cd ~/backups
sudo hbs bridge export
```

> Note this will need to be ran with elevated permissions. You will need to chmod the file if you want to work with it.

Available options
| Flag                | Description                                          |
| ------------------- | ---------------------------------------------------- |
| -b, --bridge <name> | Defines bridge to export                             |
| -c, --container     | This changes the paths needed for Docker containers  |

> If the bridge name is not set the CLI will ask for this information.

[Top](#home)

#### <a name="bridge.list"></a>List
*alias **ls***  

This will show a list of bridges on the system including the hub. It will also show you if the bridge is running.

```
sudo hbs bridge list
```

[Top](#home)

## <a name="plugin"></a>Plugin
This allows you to install, remove and list plugins from any bridge.

This will manage the plugin locations, logging and configs. This important because HOOBS encrypts your config files.

> Even though you can install plugins using npm or yarn, this handles everything that those tools don't This plugin command is a more secure way of installing plugins.

[Top](#home)

#### <a name="plugin.add"></a>Add
*alias **install***  

This will install a plugin into an bridge.

```
sudo hbs plugin add my-plugin
```

You can also define a version using the standard syntax `my-plugin@1.0.0`.

Available options
| Flag                | Description                                          |
| ------------------- | ---------------------------------------------------- |
| -b, --bridge <name> | Defines bridge to install this plugin                |
| -c, --container     | This changes the paths needed for Docker containers  |

> If the bridge name is not set the CLI will ask for this information.

[Top](#home)

#### <a name="plugin.remove"></a>Remove
*alias **uninstall***  
*alias **rm***  

This will uninstall a plugin from an bridge.

```
sudo hbs plugin remove my-plugin
```

Available options
| Flag                | Description                                          |
| ------------------- | ---------------------------------------------------- |
| -b, --bridge <name> | Defines bridge to install this plugin                |
| -c, --container     | This changes the paths needed for Docker containers  |

> If the bridge name is not set the CLI will ask for this information.

[Top](#home)

#### <a name="plugin.update"></a>Update
*alias **upgrade***  

This will upgrade a single plugin or all plugins from an bridge.

```
sudo hbs plugin update
```

or

```
sudo hbs plugin update my-plugin
```

You can also define a version using the standard syntax `my-plugin@1.0.0`.

Available options
| Flag                | Description                                          |
| ------------------- | ---------------------------------------------------- |
| -b, --bridge <name> | Defines bridge to upgrade                            |
| -c, --container     | This changes the paths needed for Docker containers  |

> If the bridge name is not set the CLI will ask for this information.

[Top](#home)

#### <a name="plugin.list"></a>List
*alias **ls***  

This will list plugins for all or a single bridge.

```
sudo hbs plugin list
```

Available options
| Flag                | Description                                          |
| ------------------- | ---------------------------------------------------- |
| -b, --bridge <name> | Defines the bridge to list                           |
| -c, --container     | This changes the paths needed for Docker containers  |

> If an bridge is not defined, the CLI will include the bridge in the list.

[Top](#home)

#### <a name="plugin.create"></a>Create
This command is used by developers to quickly create a new plugin project. It will create a new folder for your project and add example files depending on the options you choose.

```
cd ~/projects
hbs plugin create
```

This supports many options.
* JavaScript
* Typescript
* Eslint
* Jest
* Nodemon
* GUI plugin
* Config Schemas

[Top](#home)

## <a name="config"></a>Config
This allows you to manually configure HOOBS. This is the only way other then the GUI to configure HOOBS. HOOBS encrypts config files to project sensitive information.

```
sudo hbs config
```

This command can configure the hub as well as bridges.

> This uses nano, you may need to install it on your system.

Available options
| Flag                | Description                                          |
| ------------------- | ---------------------------------------------------- |
| -b, --bridge <name> | Defines the bridge to configure                      |
| -c, --container     | This changes the paths needed for Docker containers  |

> If the bridge name is not set the CLI will ask for this information.

[Top](#home)

## <a name="log"></a>Log
This will display the log from all bridges. You can also use this command to show the log from a single bridge.

```
sudo hbs log
```

You can also display debug information after the fact. This comes in handy if you can't tuen on debug mode.

Available options
| Flag                | Description                                          |
| ------------------- | ---------------------------------------------------- |
| -b, --bridge <name> | Show the log from a single bridge                    |
| -t, --tail <lines>  | Set the number of lines to show, default 50          |
| -d, --debug         | Show debug messages                                  |
| -c, --container     | This changes the paths needed for Docker containers  |

[Top](#home)

## <a name="extention"></a>Extention
This manages HOOBS extentions (features). It can be used to enable system level dependencies, like FFMPEG, and the official GUI.

> Extentions are not the same as plugins. A plugin runs on a bridge, where an extention runs on the system, or modifies the hub.

[Top](#home)

#### <a name="extention.add"></a>Add
*alias **install***  

This enables an extention.

```
sudo hbs extention add ffmpeg
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -c, --container       | This changes the paths needed for Docker containers  |

[Top](#home)

#### <a name="extention.remove"></a>Remove
*alias **uninstall***  
*alias **rm***  

This disables an extention.

```
sudo hbs extention remove ffmpeg
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -c, --container       | This changes the paths needed for Docker containers  |

[Top](#home)

#### <a name="extention.list"></a>List
*alias **ls***  

This will list all available extetntions and if they are enabled.

```
sudo hbs extention list
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -c, --container       | This changes the paths needed for Docker containers  |

[Top](#home)

## <a name="system"></a>System
This command manages the system. You can upgrade HOOBS, backuup and restore the system. You can also clean the caches or completly reset the system.

[Top](#home)

#### <a name="system.versions"></a>Versions
*alias **version***  

This shows system information and version information. This is usefull for checking for Node, HOOBSD and the CLI for updates.

```
sudo hbs system versions
```

Available options
| Flag  | Description                                                      |
| ----- | ---------------------------------------------------------------- |
| -beta | This compares installed versions against available beta versions |

[Top](#home)

#### <a name="system.versions"></a>Hostname
This shows or sets the hostname.

```
sudo hbs system hostname
```

To set the hostname, `<name>` is the hostname you wish to use.

```
sudo hbs system hostname '<name>'
```

> Note: Hostnames should not include spaces or special characters other then dashes.

[Top](#home)

#### <a name="system.upgrade"></a>Upgrade
*alias **update***  

This will upgrade HOOBS to the latest version. This includes HOOBSD, the CLI and Node.

```
sudo hbs system upgrade
```

Available options
| Flag      | Description                                      |
| --------- | ------------------------------------------------ |
| -t, -test | Dry run an upgrade and test network connectivity |
| -beta     | Install available beta versions                  |

[Top](#home)

#### <a name="system.backup"></a>Backup
This will backup your current setup to the current working directory.

```
cd ~/backups
sudo hbs system backup
```

> Note this will need to be ran with elevated permissions. You will need to chmod the file if you want to work with it.

[Top](#home)

#### <a name="system.restore"></a>Restore
This will restore the system with the file you select

```
sudo hbs system restore ~/backups/my-backup.zip
```

[Top](#home)

#### <a name="system.reset"></a>Rreset
This will remove all configurations, plugins and bridges from the system. Yse this with caution.

```
sudo hbs system reset
```

> This will keep you backup folder, so it is wise to create a backup before running this command.

[Top](#home)
