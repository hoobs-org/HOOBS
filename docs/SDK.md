## SDK
The SDK in this project defines the HOOBS API and added into Vue using a Mixin. Below, defines the properties and methods available in this SDK.

## **hoobs.version()**
This returns the current HOOBS version installed.

## **hoobs.latest()**
This returns the latest releasesd HOOBS version.

## **hoobs.auth.status()**
This fetches the status of the authentication system. It will return one of these values.

| Status        | Description                                                                |
| ------------- | -------------------------------------------------------------------------- |
| uninitialized | This is the initial status, and the default admin user needs to be created |
| enabled       | This is the auth OK status                                                 |
| disabled      | Auth system is disabled and will not require a login                       |

> The disabled status can only be achieved when the auth system is uninitilized.

## **hoobs.auth.validate()**
This validates the token stored in the Vuex store. If the auth system is disabled, this will always return true.

> Tokens are stored on in the API and have a TTL based in teh `inactive_logoff` setting on the API.

## **hoobs.auth.disable()**
This will disable the auth system.

The auth system can only be disabled if there are no users. If you would like to disable the auth system after users have been created, you must first remove the `access` file from the storage path.

This will return the auth system status.

## **hoobs.auth.login([username], [password])**
This will attempt to login to the API. If the login is successful the token will be added to the Vuex store and stored locally.

If the login fails this function will return `false`.

Parameters
| Name     | Required | Type   | Description                             |
| -------- | -------- | ------ | --------------------------------------- |
| username | Yes      | string | The username defined on the user record |
| password | Yes      | string | The password defined on the user record |

## **hoobs.auth.logout()**
This takes the session token from the store and logs out the current user.

## **hoobs.users.list()**
This will fetch a list of user records.

> Password hashes and salts are ommited for security purposes.

This will return an array of user records.

```js
[{
    id: number,
    username: string,
    name: string,
    permissions: {
        accessories: boolean,
        controller: boolean,
        instnace: boolean,
        plugins: boolean,
        users: boolean,
        reboot: boolean,
        config: boolean
    }
}]
```

## **hoobs.users.add([username], [password], \<name\>, \<permissions\>)**
This will add a new user to the system.

Parameters
| Name        | Required | Type   | Description                                           |
| ----------- | -------- | ------ | ----------------------------------------------------- |
| username    | Yes      | string | The desired username                                  |
| password    | Yes      | string | The new user's password                               |
| name        | No       | string | The new user's full name, if not set username is used |
| permissions | No       | string | The new user's permissions settings                   |

## **hoobs.user([id])**
Fetches a user object by id.

```js
{
    id: number,
    username: string,
    name: string,
    permissions: {
        accessories: boolean,
        controller: boolean,
        instnace: boolean,
        plugins: boolean,
        users: boolean,
        reboot: boolean,
        config: boolean
    }
}
```

Parameters
| Name | Required | Type   | Description               |
| ---- | -------- | ------ | ------------------------- |
| id   | Yes      | number | The id of the user record |

> The user id can be obtained from the `hoobs.users.list()` command.

## **user.update([username], [password], \<name\>, \<permissions\>)**
This updates the current user record.

Parameters
| Name        | Required | Type   | Description                                           |
| ----------- | -------- | ------ | ----------------------------------------------------- |
| username    | Yes      | string | The desired username                                  |
| password    | Yes      | string | The new user's password                               |
| name        | No       | string | The new user's full name, if not set username is used |
| permissions | No       | string | Define any updated permissions for the user           |

> This method is attached to the user object obtained from the `hoobs.user([id])` command.

## **user.remove()**
This removes the current user record.

> This method is attached to the user object obtained from the `hoobs.user([id])` command.

## **hoobs.config.get()**
This fetches the current API configuration.

```js
{
    api: {
        origin: string,
        inactive_logoff: number,
        disable_auth: boolean
    },
    description: string,
}
```

> Config files are encrypted on the hard drive. The API and CLI are the only ways to edit these files.

## **hoobs.config.update([data])**
This saves the config.

Parameters
| Name | Required | Type | Description                     |
| ---- | -------- | ---- | ------------------------------- |
| data | Yes      | JSON | The complete configuration JSON |

> Config files are encrypted on the hard drive. The API and CLI are the only ways to edit these files.

## **hoobs.log(\<tail\>)**
This fetches the historical log. This returns an array of message objects.

```js
[{
    level: LogLevel,
    instance: string,
    display: string,
    timestamp: number,
    plugin: string,
    prefix: string,
    message: string,
}]
```

Parameters
| Name | Required | Type   | Description                              |
| ---- | -------- | ------ | ---------------------------------------- |
| tail | No       | number | Defines the number of messages to return |

## **hoobs.status()**
Fetches the current device status.

```js
{
    instances: {
        instance: {
            version: string,
            running: boolean,
            status: string,
            uptime: number,
        }
    },
    cpu: {
        avgload: number,
        currentload: number,
        currentload_user: number,
        currentload_system: number,
        currentload_nice: number,
        currentload_idle: number,
        currentload_irq: number,
        raw_currentload: number,
        raw_currentload_user: number,
        raw_currentload_system: number,
        raw_currentload_nice: number,
        raw_currentload_idle: number,
        raw_currentload_irq: number,
        cpus: [{
            load: number,
            load_user: number,
            load_system: number,
            load_nice: number,
            load_idle: number,
            load_irq: number,
            raw_load: number,
            raw_load_user: number,
            raw_load_system: number,
            raw_load_nice: number,
            raw_load_idle: number,
            raw_load_irq: number
        }]
    },
    memory: {
        total: number,
        free: number,
        used: number,
        active: number,
        available: number,
        buffcache: number,
        buffers: number,
        cached: number,
        slab: number,
        swaptotal: number,
        swapused: number,
        swapfree: number
    },
    temp: {
        main: number,
        cores: [number],
        max: number
    }
}
```

> The instance key is the instance id

## **hoobs.backup.execute()**
This will generate a backup file and will return a URL to that backup file. If the backup fails an error object is returned.

## **hoobs.backup.catalog()**
Returns an list of backups available.

```js
[{
    date: number,
    filename: string,
}]
```

## **hoobs.restore.file([filename])**
This will accept a file name from the backup catalog and will restore it.

> This will reboot the device

Parameters
| Name     | Required | Type   | Description                                            |
| -------- | -------- | ------ | ------------------------------------------------------ |
| filename | Yes      | string | The file name without the path from the backup catalog |

## **hoobs.restore.upload([file])**
This will accept an uploaded file and restore it to the system.

> This will reboot the device

Parameters
| Name | Required | Type | Description                                                     |
| ---- | -------- | ---- | --------------------------------------------------------------- |
| file | Yes      | Blob | This can be any backup file stream including an HTTPFile object |

## **hoobs.system()**
Returns a system information object.

```js
{
    mac: string,
    ffmpeg_enabled: boolean,
    system: {
        manufacturer: string,
        model: string,
        version: string,
        serial: string,
        uuid: string,
        sku: string
    },
    operating_system: {
        platform: string,
        distro: string,
        release: string,
        codename: string,
        kernel: string,
        arch: string,
        hostname: string,
        codepage: string,
        logofile: string,
        serial: string,
        build: string,
        servicepack: string,
        uefi: boolean
    }
}
```

## **system.cpu()**
Returns the current CPU load.

```js
{
    information: {
        manufacturer: string,
        brand: string,
        vendor: string,
        family: string,
        model: string,
        stepping: string,
        revision: string,
        voltage: string,
        speed: string,
        speedmin: string,
        speedmax: string,
        governor: string,
        cores: number,
        physicalCores: number,
        processors: number,
        socket: string,
        cache: {
            l1d: number,
            l1i: number,
            l2: number,
            l3: number
        }
    },
    speed: {
        min: number,
        max: number,
        avg: number,
        cores: [number]
    },
    load: {
        avgload: number,
        currentload: number,
        currentload_user: number,
        currentload_system: number,
        currentload_nice: number,
        currentload_idle: number,
        currentload_irq: number,
        raw_currentload: number,
        raw_currentload_user: number,
        raw_currentload_system: number,
        raw_currentload_nice: number,
        raw_currentload_idle: number,
        raw_currentload_irq: number,
        cpus: [{
            load: number,
            load_user: number,
            load_system: number,
            load_nice: number,
            load_idle: number,
            load_irq: number,
            raw_load: number,
            raw_load_user: number,
            raw_load_system: number,
            raw_load_nice: number,
            raw_load_idle: number,
            raw_load_irq: number
        }]
    },
    cache: {
        l1d: number,
        l1i: number,
        l2: number,
        l3: number
    }
}
```

> This method is attached to the system object you must access this from the `hoobs.system()` command.

## **system.memory()**
Fetches the current memory load

```js
{
    total: number,
    free: number,
    used: number,
    active: number,
    available: number,
    buffcache: number,
    buffers: number,
    cached: number,
    slab: number,
    swaptotal: number,
    swapused: number,
    swapfree: number
}
```

> This method is attached to the system object you must access this from the `hoobs.system()` command.

## **system.network()**
Returns the current network interfaces.

```js
[{
    address: string,
    netmask: string,
    mac: string,
    internal: boolean,
    cidr: string
}]
```

> This method is attached to the system object you must access this from the `hoobs.system()` command.

## **system.filesystem()**
Fetch an array of the available file systems and the usage information.

```js
[{
    fs: string,
    type: string,
    size: number,
    used: number,
    use: number,
    mount: string
}]
```

> This method is attached to the system object you must access this from the `hoobs.system()` command.

## **system.activity()**
Fetch system load data.

```js
{
    avgload: number,
    currentload: number,
    currentload_user: number,
    currentload_system: number,
    currentload_nice: number,
    currentload_idle: number,
    currentload_irq: number,
    raw_currentload: number,
    raw_currentload_user: number,
    raw_currentload_system: number,
    raw_currentload_nice: number,
    raw_currentload_idle: number,
    raw_currentload_irq: number,
    cpus: [{
        load: number,
        load_user: number,
        load_system: number,
        load_nice: number,
        load_idle: number,
        load_irq: number,
        raw_load: number,
        raw_load_user: number,
        raw_load_system: number,
        raw_load_nice: number,
        raw_load_idle: number,
        raw_load_irq: number
    }]
}
```

> This method is attached to the system object you must access this from the `hoobs.system()` command.

## **system.temp()**
Fetch the current CPU temperature.

```js
{
    main: number,
    cores: [number],
    max: number
}
```

> This method is attached to the system object you must access this from the `hoobs.system()` command.

## **system.upgrade()**
This will update HOOBSD to the latest version.

> This method is attached to the system object you must access this from the `hoobs.system()` command.

## **system.reboot()**
This will reboot the device.

> This method is attached to the system object you must access this from the `hoobs.system()` command.

## **system.reset()**
This will factory reset the device. It will remove all instances, plugins and configurations.

> This method is attached to the system object you must access this from the `hoobs.system()` command.

## **hoobs.extentions.list()**
This will fetch a list of available extentions and if the extention is enabled.

```js
[{
    feature: string,
    description: string,
    enabled: boolean
}]
```

## **hoobs.extentions.add([name])**
This will enable an extention on the system.

Parameters
| Name | Required | Type   | Description                         |
| ---- | -------- | ------ | ----------------------------------- |
| name | Yes      | string | The name of the extention to enable |

## **hoobs.extentions.remove([name])**
This will disable an extention on the system.

Parameters
| Name | Required | Type   | Description                          |
| ---- | -------- | ------ | ------------------------------------ |
| name | Yes      | string | The name of the extention to disable |

## **hoobs.plugins()**
This will list all plugins installed across all instances.

```js
[{
    instance: string,
    identifier: string,
    scope: string,
    name: string,
    alias: string,
    version: string,
    latest: string,
    keywords: [string],
    details: string,
    schema: JSONSchema,
    description: string
}]
```

## **hoobs.instances.count()**
Returns the count of instances.

## **hoobs.instances.list()**
Returns a list of instances on the device.

```js
[{
    id: string,
    type: string,
    display: string,
    port: number,
    pin: string,
    username: string,
    ports: {
        start: number,
        end: number
    },
    autostart: number,
    host: string,
    plugins: string,
    service: string
}]
```

## **hoobs.instances.add([name], [port], \<pin\>, \<username\>)**
Adds an instance to the device. This will automatically create a system service and start it.

Parameters
| Name     | Required | Type   | Description                                               |
| -------- | -------- | ------ | --------------------------------------------------------- |
| name     | Yes      | string | The display name for the instance                         |
| port     | Yes      | number | The port for the instance, between 1 and 65535            |
| pin      | No       | string | The pin used to pair with HomeKit, defaults to 031-45-154 |
| username | No       | string | The bridge username, will auto generate is not set        |

The name is automatically sanitized and used as an id for the instance.

> If your operating system doesn't have systemd or launchd the service creation is skipped.

## **hoobs.instance([name])**
Fetches an instance object. Will return `undefined` is the instance doesn't exist.

```js
{
    id: string,
    type: string,
    display: string,
    port: number,
    pin: string,
    username: string,
    ports: {
        start: number,
        end: number
    },
    autostart: number,
    host: string,
    plugins: string,
    service: string
}
```

Parameters
| Name | Required | Type   | Description                            |
| ---- | -------- | ------ | -------------------------------------- |
| name | Yes      | string | The name or id of the desired instance |

## **instance.status()**
Fetch the current status of the bridge.

```js
{
    id: string,
    instance: string,
    running: boolean,
    status: string,
    uptime: number,
    bridge_name: string,
    product: string,
    version: string,
    node_version: string,
    username: string,
    bridge_port: number,
    setup_pin: string,
    setup_id: string,
    storage_path: string
}
```

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.config.get()**
Returns this instance's configuration data.

```js
{
    bridge: {
        name: string,
        username: string,
        pin: string,
        port: number,
        setupID: [string],
        manufacturer: string,
        model: string
    },
    description: string,
    mdns: any,
    accessories: [any],
    platforms: [any],
    plugins: [string],
    ports: {
        start: number,
        end: number
    }
}
```

Config files are encrypted on the hard drive. The API and CLI are the only ways to edit these files.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.config.update([data])**
This saves the config.

Parameters
| Name | Required | Type | Description                     |
| ---- | -------- | ---- | ------------------------------- |
| data | Yes      | JSON | The complete configuration JSON |

Config files are encrypted on the hard drive. The API and CLI are the only ways to edit these files.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.plugins.list()**
Fetch a list of installed plugins on this instance.

```js
[{
    identifier: string,
    scope: string,
    name: string,
    alias: string,
    version: string,
    latest: string,
    keywords: [string],
    details: string,
    schema: JSONSchema,
    description: string
}]
```

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.plugins.install([query])**
Installs a plugin on the current instance.

Parameters
| Name  | Required | Type   | Description                                                |
| ----- | -------- | ------ | ---------------------------------------------------------- |
| query | Yes      | string | This is the scope, name and optional version of the plugin |

Plugin queries are the same as NPM or Yarn queries. Use this format `@scope/name@version`.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.plugins.upgrade([query])**
Upgrades a plugin on the current instance.

Parameters
| Name  | Required | Type   | Description                                                |
| ----- | -------- | ------ | ---------------------------------------------------------- |
| query | Yes      | string | This is the scope, name and optional version of the plugin |

Plugin queries are the same as NPM or Yarn queries. Use this format `@scope/name@version`.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.plugins.uninstall([query])**
Uninstalls a plugin on the current instance.

Parameters
| Name  | Required | Type   | Description                              |
| ----- | -------- | ------ | ---------------------------------------- |
| query | Yes      | string | This is the scope and name of the plugin |

Plugin queries are the same as NPM or Yarn queries. Use this format `@scope/name`.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.update([name], [autostart], \<pin\>, \<username\>)**
This allows you to edit the instance information.

Parameters
| Name      | Required | Type    | Description                                                  |
| --------- | -------- | ------- | ------------------------------------------------------------ |
| name      | Yes      | string  | The desired display name for this instance                   |
| autostart | Yes      | number  | Set the number to delay the start of the bridge (in seconds) |
| pin       | No       | string  | Change the bridge's pin                                      |
| username  | No       | string  | Change the bridge username                                   |

The name is updated but the id will remain unchanged. We do this so you don't have to change any system services.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.ports([start], [end])**
This allows you to set the port pool on an instance. Usefull for camera plugins.

Parameters
| Name  | Required | Type   | Description                                      |
| ----- | -------- | ------ | ------------------------------------------------ |
| start | Yes      | number | The start port for the pool, between 1 and 65535 |
| end   | No       | number | The end port for the pool, between 1 and 65535   |

The end port must be equal to or larger then the start port.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.accessories()**
Fetch a list of accessories for this instance.

```js
[{
    aid: string,
    instance: string,
    type: string,
    linked: any,
    characteristics: [{
        iid: string,
        type: string,
        service_type: string,
        value: any,
        format: any,
        perms: [any],
        unit: any,
        max_value: any,
        min_value: any,
        min_step: any,
        read: boolean,
        write: boolean
    }]
}]
```

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.start()**
Starts the bridge on this instance.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.stop()**
Stops the bridge on this instance.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.restart()**
Restarts the bridge on this instance.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.purge()**
Purges the accessory and persisted cache on this instance.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.cache()**
Fetches the accessory and persisted connections cache on this instance.

```js
{
    parings: [{
        id: string,
        version: string,
        username: string,
        display: string,
        category: string,
        setup_pin: string,
        setup_id: string,
        clients: [any],
        permissions: [any]
    }],
    accessories: [any],
}
```

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **instance.remove()**
This will remove this instance including all plugins and configurations.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **hoobs.accessories()**
Returns a list of accessories from all instances.

```js
[{
    aid: string,
    instance: string,
    type: string,
    linked: any,
    characteristics: [{
        iid: string,
        type: string,
        service_type: string,
        value: any,
        format: any,
        perms: [any],
        unit: any,
        max_value: any,
        min_value: any,
        min_step: any,
        read: boolean,
        write: boolean
    }]
}]
```

## **hoobs.accessory([instance], [id])**
This fetches a single accessory object.

```js
{
    aid: string,
    instance: string,
    type: string,
    linked: any,
    characteristics: [{
        iid: string,
        type: string,
        service_type: string,
        value: any,
        format: any,
        perms: [any],
        unit: any,
        max_value: any,
        min_value: any,
        min_step: any,
        read: boolean,
        write: boolean
    }]
}
```

## **accessory.control([service], [data])**
Control an accessory. The JSON data for an accessory is contextual for the accessory you are wanting to control.

Parameters
| Name    | Required | Type   | Description                                     |
| ------- | -------- | ------ | ----------------------------------------------- |
| service | Yes      | string | The service id on the current accessory         |
| data    | Yes      | JSON   | This is contextual data for the accessory state |

> This method is attached to the accessory object you must access this from the `hoobs.accessory([instance], [id])` command.

## **hoobs.theme.get([name])**
This fetches the theme colors for the defined name.

```js
{
    name: string,
    display: string,
    auto: boolean,
    mode: string,
    transparency: string,
    application: {
        text: {
            default: string,
            highlight: string,
            input: string,
            error: string
        },
        background: string,
        highlight: string,
        accent: string,
        dark: string,
        drawer: string,
        input: {
            background: string,
            accent: string
        },
        border: string
    },
    button: {
        background: string,
        text: string,
        border: string,
        primary: {
            background: string,
            text: string,
            border: string
        },
        light: {
            background: string,
            text: string,
            border: string
        }
    },
    modal: {
        text: {
            default: string,
            input: string,
            error: string
        },
        background: string,
        dark: string,
        form: string,
        mask: string,
        highlight: string,
        input: string,
        accent: string,
        border: string
    },
    widget: {
        text: {
            default: string,
        },
        background: string,
        highlight: string,
        border: string
    },
    menu: {
        text: {
            default: string,
            highlight: string
        },
        background: string,
        highlight: string,
        border: string
    },
    navigation: {
        text: {
            default: string,
            highlight: string,
            active: string
        },
        background: string,
        highlight: string,
        border: string
    },
    backdrop: string,
    elevation: {
        default: string,
        button: string
    }
}
```

Parameters
| Name | Required | Type   | Description           |
| ---- | -------- | ------ | --------------------- |
| name | Yes      | string | The name of the theme |

## **hoobs.theme.set([name], [theme])**
This will save a theme to the backend.

Parameters
| Name  | Required | Type   | Description           |
| ----- | -------- | ------ | --------------------- |
| name  | Yes      | string | The name of the theme |
| theme | Yes      | Theme  | The theme JSON object |

## **hoobs.theme.backdrop([image])**
This will upload an image to the backend for use as a backdrop.

Parameters
| Name  | Required | Type | Description                                               |
| ----- | -------- | ---- | --------------------------------------------------------- |
| image | Yes      | Blob | This can be any image stream including an HTTPFile object |

## **hoobs.location([query])**
This will search for a location by open text search. This is used to set the location for weather forecasts.

```js
{
    lat: number,
    lng: number
}
```

Parameters
| Name  | Required | Type   | Description                       |
| ----- | -------- | ------ | --------------------------------- |
| query | Yes      | string | This the desired open text search |

## **hoobs.weather.current()**
Fetches the current weather from the configured location in the API config.

```js
{
    units: string,
    weather: string,
    description: string,
    icon: string,
    temp: number,
    min: number,
    max: number,
    windchill: number,
    pressure: number,
    humidity: number,
    visibility: number,
    wind: {
        speed: number,
        direction: number,
    }
}
```

## **hoobs.weather.forecast()**
Fetches the weather forecast from the configured location in the API config.

```js
[{
    units: string,
    date: number,
    weather: string,
    description: string,
    icon: string,
    temp: number,
    min: number,
    max: number,
    windchill: number,
    pressure: number,
    humidity: number,
    visibility: number,
    wind: {
        speed: number,
        direction: number,
    }
}]
```

## **hoobs.remote.status()**
Returns the status of a remote session.

```js
{
    active: boolean
}
```

> Only one remote session is allowed per API.

## **hoobs.remote.connect()**
Connects to the HOOBS support server. This will allow HOOBS support to diagnose and run commands on your device.

This will return a registration code or an error object if it can't connect.

```js
{
    registration: string
}
```

## **hoobs.remote.disconnect()**
This will disconnect a current active session.

> When HOOBS support disconnects this will automatically be called.
