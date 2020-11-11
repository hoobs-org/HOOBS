## CLI
The HOOBS command line interface is the software that managess bridge instances. Below is a list of commands and actions available in the HOOBS CLI.


## **hoobsd start**
This starts instances. It is also the default command when no other command is defined.

```
sudo hoobsd start -i 'my-instance'
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

## **hoobsd api**
This starts the control api. This is needed to manage the instances.

```
sudo hoobsd api
```

Available options
| Flag                  | Description                                         |
| --------------------- | --------------------------------------------------- |
| -d, --debug           | Turn on debug level logging                         |
| -v, --verbose         | Tuen on insane verbose logging                      |
| -p, --port <port>     | Override the defined API port                       |
| -c, --container       | This changes the paths needed for Docker containers |

## **hoobsd service <action>**
This controls the services installed on teh system. To create the services use the HOOBS CLI.

> If you do not define an instance the default is **default**, also to control the API service, the instance name is **api**.

```
sudo hoobsd service start -i 'my-instance'
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
| -i, --instance <name> | Define the instance to start, can be the name or id |

## **hoobs initilize**
This initilizes the system. It creates the special API instance. The API instance is a control hub for all other instances.

```
sudo hoobs initilize
```

Available options
| Flag              | Description                                                |
| ----------------- | ---------------------------------------------------------- |
| -p, --port <port> | Sets the port for the API, if not set the CLI will ask you |
| -s, --skip        | This will skip the systemd or launchd service create       |
| -c, --container   | This changes the paths needed for Docker containers        |

## **hoobs instance [action]**
This controls instances on the system. It can be used to list, create and remove instances.

> This also creates and starts systemd and launchd services. If your system doesn't have either of these systems, the CLI will not attempt this.

#### **hoobs instance add**
This will create an instance.

```
sudo hoobs instance create
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

#### **hoobs instance create**
This is an alias for **add**.

#### **hoobs instance remove**
This will remove an instance.

```
sudo hoobs instance remove
```

> This will remove all configs and plugins.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to be removed                       |
| -s, --skip            | This will skip the systemd or launchd service create |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### **hoobs instance export**
This will export an instance to your current working directory.

```
cd ~/backups
sudo hoobs instance export
```

> Note this will need to be ran with elevated permissions. You will need to chmod the file if you want to work with it.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to export                           |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### **hoobs instance list**
This will show a list of instances on the system including the API. It will also show you if the instance is running.

```
sudo hoobs instance list
```

#### **hoobs instance ls**
This is an aliad for **list**.

## **hoobs plugin [action]**
This allows you to install, remove and list plugins from any instance.

This will manage the plugin locations, logging and configs. This important because HOOBS encrypts your config files.

> Even though you can install plugins using npm or yarn, this handles everything that those tools don't This plugin command is a more secure way of installing plugins.

#### **hoobs plugin add [name]**
This will install a plugin into an instance.

```
sudo hoobs plugin add my-plugin
```

You can also define a version using the standard syntax `my-plugin@1.0.0`.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to install this plugin              |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### **hoobs plugin install [name]**
This is an alias for **add**.

#### **hoobs plugin remove [name]**
This will uninstall a plugin from an instance.

```
sudo hoobs plugin remove my-plugin
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to install this plugin              |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### **hoobs plugin uninstall [name]**
This is an alias for **remove**.

#### **hoobs plugin upgrade <name>**
This will upgrade a single plugin or all plugins from an instance.

```
sudo hoobs plugin upgrade
```

or

```
sudo hoobs plugin upgrade my-plugin
```

You can also define a version using the standard syntax `my-plugin@1.0.0`.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines instance to upgrade                          |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

#### **hoobs plugin update <name>**
This is an alias for **upgrade**.

#### **hoobs plugin list**
This will list plugins for all or a single instance.

```
sudo hoobs plugin list
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines the instance to list                         |
| -c, --container       | This changes the paths needed for Docker containers  |

> If an instance is not defined, the CLI will include the instance in the list.

#### **hoobs plugin ls**
This is an aliad for **list**.

#### **hoobs plugin create**
This command is used by developers to quickly create a new plugin project. It will create a new folder for your project and add example files depending on the options you choose.

```
cd ~/projects
hoobs plugin create
```

This supports many options.
* JavaScript
* Typescript
* Eslint
* Jest
* Nodemon
* GUI plugin
* Config Schemas

## **hoobs config**
This allows you to manually configure HOOBS. This is the only way other then the GUI to configure HOOBS. HOOBS encrypts config files to project sensitive information.

```
sudo hoobs config
```

This command can configure the API as well as instances.

> This uses nano, you may need to install it on your system.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Defines the instance to configure                    |
| -c, --container       | This changes the paths needed for Docker containers  |

> If the instance name is not set the CLI will ask for this information.

## **hoobs log**
This will display the log from all instances. You can also use this command to show the log from a single instance.

```
sudo hoobs log
```

You can also display debug information after the fact. This comes in handy if you can't tuen on debug mode.

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -i, --instance <name> | Show the log from a single instance                  |
| -t, --tail <lines>    | Set the number of lines to show, default 50          |
| -d, --debug           | Show debug messages                                  |
| -c, --container       | This changes the paths needed for Docker containers  |

## **hoobs extention [action]**
This manages HOOBS extentions (features). It can be used to enable system level dependencies, like FFMPEG, and the official GUI.

> Extentions are not the same as plugins. A plugin runs on a bridge, where an extention runs on the system, or modifies the API.

#### **hoobs extention add [name]**
This enables an extention.

```
sudo hoobs extention add ffmpeg
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -c, --container       | This changes the paths needed for Docker containers  |

#### **hoobs extention install [name]**
This is an alias for **add**.

#### **hoobs extention remove [name]**
This disables an extention.

```
sudo hoobs extention remove ffmpeg
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -c, --container       | This changes the paths needed for Docker containers  |

#### **hoobs extention uninstall [name]**
This is an alias for **remove**.

#### **hoobs extention list**
This will list all available extetntions and if they are enabled.

```
sudo hoobs extention list
```

Available options
| Flag                  | Description                                          |
| --------------------- | ---------------------------------------------------- |
| -c, --container       | This changes the paths needed for Docker containers  |

#### **hoobs extention ls**
This is an aliad for **list**.

## **hoobs system <action>**
This command manages the system. You can upgrade HOOBS, backuup and restore the system. You can also clean the caches or completly reset the system.

#### **hoobs system upgrade**
This will upgrade HOOBS to the latest version.

```
sudo hoobs system upgrade
```

#### **hoobs system backup**
This will backup your current setup to the current working directory.

```
cd ~/backups
sudo hoobs system backup
```

> Note this will need to be ran with elevated permissions. You will need to chmod the file if you want to work with it.

#### **hoobs system restore <file>**
This will restore the system with the file you select

```
sudo hoobs system restore ~/backups/my-backup.zip
```

#### **hoobs system purge**
This will purge all persisted and cache files from all instances.

```
sudo hoobs system purge
```

> This will require you to re-pair with Apple Home.

#### **hoobs system reset**
This will remove all configurations, plugins and instances from the system. Yse this with caution.

```
sudo hoobs system reset
```

> This will keep you backup folder, so it is wise to create a backup before running this command.

## **hoobs remote**
This will start a remote terminal session with HOOBS support.

```
hoobs remote
```

> It is not wise using this command with sudo.
