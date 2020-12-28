## CLI
The HOOBS command line interface is the software that managess bridge instances. Below is a list of commands and actions available in the HOOBS CLI.

## Start
This starts the control api. This is needed to manage the instances. It is also the default command when no other command is defined.

```
sudo hoobsd start
```

Available options
| Flag                  | Description                                         |
| --------------------- | --------------------------------------------------- |
| -d, --debug           | Turn on debug level logging                         |
| -v, --verbose         | Tuen on insane verbose logging                      |
| -p, --port <port>     | Override the defined API port                       |
| -o, --orphans         | Keep cached accessories for orphaned plugins        |
| -c, --container       | This changes the paths needed for Docker containers |

## Instance
This starts instances.

```
sudo hoobsd instance -i 'my-instance'
```

Available options
| Flag                  | Description                                         |
| --------------------- | --------------------------------------------------- |
| -d, --debug           | Turn on debug level logging                         |
| -v, --verbose         | Tuen on insane verbose logging                      |
| -i, --instance <name> | Define the instance to start, can be the name or id |
| -p, --port <port>     | Override the port defined on the instance           |
| -o, --orphans         | Keep cached accessories for orphaned plugins        |
| -c, --container       | This changes the paths needed for Docker containers |

> If an instance name is not included the default is **default**

## Service
This controls the service installed on the system. To create the service use the HOOBS CLI.

```
sudo hoobsd service start
```

Available actions
| Action  | Description                            |
| ------- | -------------------------------------- |
| start   | This will start the defined instance   |
| stop    | This will stop the defined instance    |
| restart | This will restart the defined instance |

Available options
| Flag                  | Description                                         |
| --------------------- | --------------------------------------------------- |
| -d, --debug           | Turn on debug level logging                         |

## Install
This initilizes the system. It creates the special API instance. The API instance is a control hub for all other instances.

```
sudo hbs install
```

Available options
| Flag              | Description                                                |
| ----------------- | ---------------------------------------------------------- |
| -p, --port <port> | Sets the port for the API, if not set the CLI will ask you |
| -s, --skip        | This will skip the systemd or launchd service create       |
| -c, --container   | This changes the paths needed for Docker containers        |

## Instance
This controls instances on the system. It can be used to list, create and remove instances.

> This also creates and starts systemd and launchd services. If your system doesn't have either of these systems, the CLI will not attempt this.

#### Add
*alias **create***  

This will create an instance.

```
sudo hbs instance create
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines a name for the instance                      |
| -p, --port <port>     | Sets the port for the instance                       |
| -n, --pin <pin>       | Sets the pin for bridge paring                       |
| -s, --skip            | This will skip the systemd or launchd service create |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name or port is not set the CLI will ask for this information.

#### Remove
*alias **rm***  

This will remove an instance.

```
sudo hbs instance remove
```

> This will remove all configs and plugins.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to be removed                       |
| -s, --skip            | This will skip the systemd or launchd service create |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### Export
This will export an instance to your current working directory.

```
cd ~/backups
sudo hbs instance export
```

> Note this will need to be ran with elevated permissions. You will need to chmod the file if you want to work with it.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to export                           |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### List
*alias **ls***  

This will show a list of instances on the system including the API. It will also show you if the instance is running.

```
sudo hbs instance list
```

## Plugin
This allows you to install, remove and list plugins from any instance.

This will manage the plugin locations, logging and configs. This important because HOOBS encrypts your config files.

> Even though you can install plugins using npm or yarn, this handles everything that those tools don't This plugin command is a more secure way of installing plugins.

#### Add
*alias **install***  

This will install a plugin into an instance.

```
sudo hbs plugin add my-plugin
```

You can also define a version using the standard syntax `my-plugin@1.0.0`.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to install this plugin              |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### Remove
*alias **uninstall***  
*alias **rm***  

This will uninstall a plugin from an instance.

```
sudo hbs plugin remove my-plugin
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to install this plugin              |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### Update
*alias **upgrade***  

This will upgrade a single plugin or all plugins from an instance.

```
sudo hbs plugin update
```

or

```
sudo hbs plugin update my-plugin
```

You can also define a version using the standard syntax `my-plugin@1.0.0`.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to upgrade                          |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### List
*alias **ls***  

This will list plugins for all or a single instance.

```
sudo hbs plugin list
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines the instance to list                         |
| -c, --container       | This changes the paths needed for Docker containers  |

> If an instance is not defined, the CLI will include the instance in the list.

#### Create
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

## Config
This allows you to manually configure HOOBS. This is the only way other then the GUI to configure HOOBS. HOOBS encrypts config files to project sensitive information.

```
sudo hbs config
```

This command can configure the API as well as instances.

> This uses nano, you may need to install it on your system.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines the instance to configure                    |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

## Log
This will display the log from all instances. You can also use this command to show the log from a single instance.

```
sudo hbs log
```

You can also display debug information after the fact. This comes in handy if you can't tuen on debug mode.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Show the log from a single instance                  |
| -t, --tail <lines>    | Set the number of lines to show, default 50          |
| -d, --debug           | Show debug messages                                  |
| -c, --container       | This changes the paths needed for Docker containers  |

## Extention
This manages HOOBS extentions (features). It can be used to enable system level dependencies, like FFMPEG, and the official GUI.

> Extentions are not the same as plugins. A plugin runs on a bridge, where an extention runs on the system, or modifies the API.

#### Add
*alias **install***  

This enables an extention.

```
sudo hbs extention add ffmpeg
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -c, --container       | This changes the paths needed for Docker containers  |

#### Remove
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

#### List
*alias **ls***  

This will list all available extetntions and if they are enabled.

```
sudo hbs extention list
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -c, --container       | This changes the paths needed for Docker containers  |

## System
This command manages the system. You can upgrade HOOBS, backuup and restore the system. You can also clean the caches or completly reset the system.

#### Versions
*alias **version***  

This shows system information and version information. This is usefull for checking for Node, HOOBSD and the CLI for updates.

```
sudo hbs system versions
```

Available options
| Flag  | Description                                                      |
| ----- | ---------------------------------------------------------------- |
| -beta | This compares installed versions against available beta versions |

#### Upgrade
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

#### Backup
This will backup your current setup to the current working directory.

```
cd ~/backups
sudo hbs system backup
```

> Note this will need to be ran with elevated permissions. You will need to chmod the file if you want to work with it.

#### Restore
This will restore the system with the file you select

```
sudo hbs system restore ~/backups/my-backup.zip
```

#### Purge
This will purge all persisted and cache files from all instances.

```
sudo hbs system purge
```

> This will require you to re-pair with Apple Home.

#### Rreset
This will remove all configurations, plugins and instances from the system. Yse this with caution.

```
sudo hbs system reset
```

> This will keep you backup folder, so it is wise to create a backup before running this command.
