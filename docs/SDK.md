# <a name="home"></a>SDK
This SDK is designed to be used with JavaScript and includes a Vue plugin.

```js
import hoobs from "@hoobs/sdk";

const version = await hoobs.sdk.version();
```

To include the SDK in a Vue application, simply pass it into a Vue.use() call. You will also need to define a token store. This example uses Vuex.

```js
import hoobs from "@hoobs/sdk";
import store from "./store";

hoobs.sdk.config.token.get(() => store.state.session);
hoobs.sdk.config.token.set((token) => { store.commit("SESSION:SET", token); });

Vue.use(hoobs);
```

The Vue plugin creates the $hoobs variable.

Below, defines the properties and methods available in this SDK.

> Note: If you are using this within an Vue component, you can access the SDK from `this.$hoobs`. If you are not using Vue, you can access this from `hoobs.sdk`.

## <a name="version"></a>**Table of Contents**
- [Version](#version)
- [Latest](#latest)
- Auth
    - [Status](#auth.status)
    - [Validate](#auth.validate)
    - [Disable](#auth.disable)
    - [Login](#auth.login)
    - [Logout](#auth.logout)
    - [Link](#auth.link)
- [IO](#io)
    - [On](#io.on)
    - [Off](#io.off)
    - [Emit](#io.emit)
- Dates
    - [Display](#dates.display)
    - [Age](#dates.age)
    - [Ordinal](#dates.ordinal)
    - [Month](#dates.month)
- Users
    - [List](#users.list)
    - [Add](#users.add)
- [User](#user)
    - [Update](#user.update)
    - [Remove](#user.remove)
- Config
    - [Get](#config.get)
    - [Update](#config.update)
- [Log](#log)
- [Status](#status)
- Backup
    - [Execute](#backup.execute)
    - [Catalog](#backup.catalog)
- Restore
    - [File](#restore.file)
    - [Upload](#restore.upload)
- [System](#system)
    - [CPU](#system.cpu)
    - [Memory](#system.memory)
    - [Network](#system.network)
    - [Filesystem](#system.filesystem)
    - [Activity](#system.activity)
    - [Temp](#system.temp)
    - [Upgrade](#system.upgrade)
    - [Reboot](#system.reboot)
    - [Reset](#system.reset)
- Hostname
    - [Get](#hostname.get)
    - [Update](#hostname.update)
- Extentions
    - [List](#extentions.list)
    - [Add](#extentions.add)
    - [Remove](#extentions.remove)
- [Plugins](#plugins)
- Repository
    - [Featured](#repository.featured)
    - [Popular](#repository.popular)
    - [Search](#repository.search)
    - [Details](#repository.details)
    - [Reviews](#repository.reviews)
    - [Title](#repository.title)
- Bridges
    - [Count](#bridges.count)
    - [List](#bridges.list)
    - [Add](#bridges.add)
    - [Import](#bridges.import)
    - [Bridge](#bridge)
    - [Status](#bridge.status)
    - Config
        - [Get](#bridge.config.get)
        - [Update](#bridge.config.update)
    - Plugins
        - [List](#bridge.plugins.list)
        - [Install](#bridge.plugins.install)
        - [Upgrade](#bridge.plugins.upgrade)
        - [Uninstall](#bridge.plugins.uninstall)
    - [Update](#bridge.update)
    - [Ports](#bridge.ports)
    - [Accessories](#bridge.accessories)
    - [Start](#bridge.start)
    - [Stop](#bridge.stop)
    - [Restart](#bridge.restart)
    - [Purge](#bridge.purge)
    - [Cache](#bridge.cache)
    - [Export](#bridge.export)
    - [Remove](#bridge.remove)
- [Accessories](#accessories)
- [Accessory](#accessory)
    - [Set](#accessory.set)
- Rooms
    - [Count](#rooms.count)
    - [List](#rooms.list)
    - [Add](#rooms.add)
- [Room](#room)
    - [Set](#room.set)
    - [Remove](#room.remove)
- Theme
    - [Get](#theme.get)
    - [Set](#theme.set)
    - [Backdrop](#theme.backdrop)
- [Plugin](#plugin)
- [Location](#location)
- Weather
    - [Current](#weather.current)
    - [Forecast](#weather.forecast)
- Remote
    - [Status](#remote.status)
    - [Connect](#remote.connect)
    - [Disconnect](#remote.disconnect)

## <a name="version"></a>**version()**
This returns the current HOOBSD version installed.

[Top](#home)

## <a name="latest"></a>**latest()**
This returns the latest releasesd HOOBSD version.

[Top](#home)

## <a name="auth.status"></a>**auth.status()**
This fetches the status of the authentication system. It will return one of these values.

| Status        | Description                                                                |
| ------------- | -------------------------------------------------------------------------- |
| uninitialized | This is the initial status, and the default admin user needs to be created |
| enabled       | This is the auth OK status                                                 |
| disabled      | Auth system is disabled and will not require a login                       |

> The disabled status can only be achieved when the auth system is uninitilized.

[Top](#home)

## <a name="auth.validate"></a>**auth.validate()**
This validates the token stored in the Vuex store. If the auth system is disabled, this will always return true.

> Tokens are stored on the hub and have a TTL based in teh `inactive_logoff` setting.

[Top](#home)

## <a name="auth.disable"></a>**auth.disable()**
This will disable the auth system.

The auth system can only be disabled if there are no users. If you would like to disable the auth system after users have been created, you must first remove the `access` file from the storage path.

This will return the auth system status.

[Top](#home)

## <a name="auth.login"></a>**auth.login([username], [password])**
This will attempt to login to the hub. If the login is successful the token will be added to the Vuex store and stored locally.

If the login fails this function will return `false`.

Parameters
| Name     | Required | Type   | Description                             |
| -------- | -------- | ------ | --------------------------------------- |
| username | Yes      | string | The username defined on the user record |
| password | Yes      | string | The password defined on the user record |

[Top](#home)

## <a name="auth.logout"></a>**auth.logout()**
This takes the session token from the store and logs out the current user.

[Top](#home)

## <a name="auth.link"></a>**auth.link([vendor], [username], [password], \<verification\>)**
This will attempt to to fetch authentication tokens from defined third party vendors.

Parameters
| Name         | Required | Type   | Description                                     |
| ------------ | -------- | ------ | ----------------------------------------------- |
| vendor       | Yes      | string | The vendor you wish to link                     |
| username     | Yes      | string | The username for this vendor                    |
| password     | Yes      | string | The password for this vendor                    |
| verification | No       | string | Verification code for two factor authentication |

Currently these are the available vendors.
- Ring

[Top](#home)

## <a name="io"></a>**io()**
This returnes an bridge of the web socket used to communicate with the backend.

Events
| Name             | Description                                                               |
| ---------------- | ------------------------------------------------------------------------- |
| connect          | Fires when the socket connects                                            |
| disconnect       | Fires when the socket disconnects                                         |
| reconnect        | Fires when the socket reconnects                                          |
| log              | This event is fired when the backend writes to the console                |
| monitor          | This fires on an interval set on the hub, sends monitor data to the UI    |
| notification     | Fires when a notification is generated on the hub                         |
| accessory_change | Every time an accessory is changes this is fired, including on/off states |
| shell_input      | Emit only, used to send XTerm commands to a PTY shell                     |
| shell_output     | Is fired when the PTY shell outputs information                           |
| shell_clear      | Emit only, used to clear the PTY terminal                                 |

To use io in Vue you must add it seperatly in main.

```js
import hoobs from "@hoobs/sdk";

const io = hoobs.sdk.io();

Vue.use(hoobs);
Vue.use(io);
```

Once this is added, `this.io` will be available in your Vue components.

[Top](#home)

## <a name="io.on"></a>**io.on([event], [callback])**
This adds a listner on the socket for specific events.

Parameters
| Name     | Required | Type     | Description                                |
| -------- | -------- | -------- | ------------------------------------------ |
| event    | Yes      | string   | Predefined event name                      |
| callback | Yes      | function | The function to call when event is emitted |

> All events return a JSON payload or undefined

[Top](#home)

## <a name="io.off"></a>**io.off([event])**
Disables all listners for a given event.

[Top](#home)

## <a name="io.emit"></a>**io.emit([event], [...arguments])**
Allows you to emit events from the UI to the backend.

> Arguments are specific to each event

[Top](#home)

## <a name="dates.display"></a>**dates.display([date])**
Formats a string date or a timestamp into a friendly display.

Parameters
| Name | Required | Type     | Description                |
| ---- | -------- | -------- | -------------------------- |
| date | Yes      | string   | A date string or timestamp |

[Top](#home)

## <a name="dates.age"></a>**dates.age([date])**
Formats a string date or a timestamp into an age string line "5 days ago"

Parameters
| Name | Required | Type     | Description                |
| ---- | -------- | -------- | -------------------------- |
| date | Yes      | string   | A date string or timestamp |

[Top](#home)

## <a name="dates.ordinal"></a>**dates.ordinal([value])**
Converts a number into an ordinal like "7th"

Parameters
| Name  | Required | Type     | Description      |
| ----- | -------- | -------- | ---------------- |
| value | Yes      | number   | Any number value |

[Top](#home)

## <a name="dates.month"></a>**dates.month([value])**
Converts a month from Date.getMonth() to a test string.

Parameters
| Name  | Required | Type     | Description      |
| ----- | -------- | -------- | ---------------- |
| value | Yes      | number   | Any number value |

[Top](#home)

## <a name="users.list"></a>**users.list()**
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
        bridges: boolean,
        plugins: boolean,
        users: boolean,
        reboot: boolean,
        config: boolean
    }
}]
```

[Top](#home)

## <a name="users.add"></a>**users.add([username], [password], \<name\>, \<permissions\>)**
This will add a new user to the system.

Parameters
| Name        | Required | Type   | Description                                           |
| ----------- | -------- | ------ | ----------------------------------------------------- |
| username    | Yes      | string | The desired username                                  |
| password    | Yes      | string | The new user's password                               |
| name        | No       | string | The new user's full name, if not set username is used |
| permissions | No       | string | The new user's permissions settings                   |

[Top](#home)

## <a name="user"></a>**user([id])**
Fetches a user object by id.

```js
{
    id: number,
    username: string,
    name: string,
    permissions: {
        accessories: boolean,
        controller: boolean,
        bridges: boolean,
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

[Top](#home)

## <a name="user.update"></a>**user.update([username], [password], \<name\>, \<permissions\>)**
This updates the current user record.

Parameters
| Name        | Required | Type   | Description                                           |
| ----------- | -------- | ------ | ----------------------------------------------------- |
| username    | Yes      | string | The desired username                                  |
| password    | Yes      | string | The new user's password                               |
| name        | No       | string | The new user's full name, if not set username is used |
| permissions | No       | string | Define any updated permissions for the user           |

> This method is attached to the user object obtained from the `hoobs.user([id])` command.

[Top](#home)

## <a name="user.remove"></a>**user.remove()**
This removes the current user record.

> This method is attached to the user object obtained from the `hoobs.user([id])` command.

[Top](#home)

## <a name="config.get"></a>**config.get()**
This fetches the current hub configuration.

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

[Top](#home)

## <a name="config.update"></a>**config.update([data])**
This saves the config.

Parameters
| Name | Required | Type | Description                     |
| ---- | -------- | ---- | ------------------------------- |
| data | Yes      | JSON | The complete configuration JSON |

> Config files are encrypted on the hard drive. The API and CLI are the only ways to edit these files.

[Top](#home)

## <a name="log"></a>**log(\<tail\>)**
This fetches the historical log. This returns an array of message objects.

```js
[{
    level: LogLevel,
    bridge: string,
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

[Top](#home)

## <a name="status"></a>**status()**
Fetches the current device status.

```js
{
    version: string,
    release: string,
    upgraded: boolean,
    cli_version: string,
    cli_release: string,
    cli_upgraded: boolean,
    node_version: string,
    node_release: string,
    node_upgraded: boolean,
    bridges: {
        bridge: {
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

> The bridge key is the bridge id

[Top](#home)

## <a name="backup.execute"></a>**backup.execute()**
This will generate a backup file and will return a URL to that file. If the backup fails an error object is returned.

[Top](#home)

## <a name="backup.catalog"></a>**backup.catalog()**
Returns an list of backups available.

```js
[{
    date: number,
    filename: string,
}]
```

[Top](#home)

## <a name="restore.file"></a>**restore.file([filename])**
This will accept a file name from the backup catalog and will restore it.

> This will reboot the device

Parameters
| Name     | Required | Type   | Description                                            |
| -------- | -------- | ------ | ------------------------------------------------------ |
| filename | Yes      | string | The file name without the path from the backup catalog |

[Top](#home)

## <a name="restore.upload"></a>**restore.upload([file])**
This will accept an uploaded file and restore it to the system.

> This will reboot the device

Parameters
| Name | Required | Type | Description                                                     |
| ---- | -------- | ---- | --------------------------------------------------------------- |
| file | Yes      | Blob | This can be any backup file stream including an HTTPFile object |

[Top](#home)

## <a name="system"></a>**system()**
Returns a system information object.

```js
{
    mac: string,
    ffmpeg_enabled: boolean,
    system: {
        manufacturer: string,
        model: string,
        distribution: string,
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

[Top](#home)

## <a name="system.cpu"></a>**system.cpu()**
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

[Top](#home)

## <a name="system.memory"></a>**system.memory()**
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

[Top](#home)

## <a name="system.network"></a>**system.network()**
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

[Top](#home)

## <a name="system.filesystem"></a>**system.filesystem()**
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

[Top](#home)

## <a name="system.activity"></a>**system.activity()**
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

[Top](#home)

## <a name="system.temp"></a>**system.temp()**
Fetch the current CPU temperature.

```js
{
    main: number,
    cores: [number],
    max: number
}
```

> This method is attached to the system object you must access this from the `hoobs.system()` command.

[Top](#home)

## <a name="system.upgrade"></a>**system.upgrade()**
This will update HOOBSD to the latest version.

> This method is attached to the system object you must access this from the `hoobs.system()` command.

[Top](#home)

## <a name="system.reboot"></a>**system.reboot()**
This will reboot the device.

> This method is attached to the system object you must access this from the `hoobs.system()` command.

[Top](#home)

## <a name="system.reset"></a>**system.reset()**
This will factory reset the device. It will remove all bridges, plugins and configurations.

> This method is attached to the system object you must access this from the `hoobs.system()` command.

[Top](#home)

## <a name="hostname.get"></a>**hostname.get()**
This allows you to view the broadcasted hostname.

> Note this is only available on HOOBS devices like the HOOBS Box and the HOOBS SD Card.

[Top](#home)

## <a name="hostname.update"></a>**hostname.update([name])**
This allows you to set the broadcasted hostname.

> Note this doesn't change the system's hostname, it only changes the mDNS broadcasted hostname.

> Note this is only available on HOOBS devices like the HOOBS Box and the HOOBS SD Card.

[Top](#home)

## <a name="extentions.list"></a>**extentions.list()**
This will fetch a list of available extentions and if the extention is enabled.

```js
[{
    feature: string,
    description: string,
    enabled: boolean
}]
```

[Top](#home)

## <a name="extentions.add"></a>**extentions.add([name])**
This will enable an extention on the system.

Parameters
| Name | Required | Type   | Description                         |
| ---- | -------- | ------ | ----------------------------------- |
| name | Yes      | string | The name of the extention to enable |

[Top](#home)

## <a name="extentions.remove"></a>**extentions.remove([name])**
This will disable an extention on the system.

Parameters
| Name | Required | Type   | Description                          |
| ---- | -------- | ------ | ------------------------------------ |
| name | Yes      | string | The name of the extention to disable |

[Top](#home)

## <a name="plugins"></a>**plugins()**
This will list all plugins installed across all bridges.

```js
[{
    bridge: string,
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

[Top](#home)

## <a name="repository.featured"></a>**repository.featured()**
Fetches a list of featured plugins from HOOBS Cloud.

[Top](#home)

## <a name="repository.popular"></a>**repository.popular()**
Fetches a list of popular plugins from HOOBS Cloud.

[Top](#home)

## <a name="repository.search"></a>**repository.search([query], [skip], [limit])**
Search for plugins on HOOBS Cloud in order of hit rank.

Parameters
| Name  | Required | Type   | Description                          |
| ----- | -------- | ------ | ------------------------------------ |
| query | Yes      | string | The search query                     |
| skip  | Yes      | number | Skip the first number of plugins     |
| limit | Yes      | number | Limit the number of plugins returned |

[Top](#home)

## <a name="repository.details"></a>**repository.details([identifier])**
Fetches a plugin details including readme and config schemas.

Parameters
| Name       | Required | Type   | Description                                     |
| ---------- | -------- | ------ | ----------------------------------------------- |
| identifier | Yes      | string | The plugin identifier as it appears in the repo |

> Note plugin identifiers include the scope, like @scope/plugin-name.

[Top](#home)

## <a name="repository.reviews"></a>**repository.reviews([identifier], [skip], [limit])**
Fetch a list of reviews for a given plugin ordered by newest review.

Parameters
| Name       | Required | Type   | Description                                     |
| ---------- | -------- | ------ | ----------------------------------------------- |
| identifier | Yes      | string | The plugin identifier as it appears in the repo |
| skip       | Yes      | number | Skip the first number of plugins                |
| limit      | Yes      | number | Limit the number of plugins returned            |

[Top](#home)

## <a name="repository.title"></a>**repository.title([value])**
Converts a plugin name or identifier into a friendly display name.

Parameters
| Name  | Required | Type   | Description                   |
| ----- | -------- | ------ | ----------------------------- |
| value | Yes      | string | The plugin name or identifier |

[Top](#home)

## <a name="bridges.count"></a>**bridges.count()**
Returns the count of bridges.

[Top](#home)

## <a name="bridges.list"></a>**bridges.list()**
Returns a list of bridges on the device.

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

[Top](#home)

## <a name="bridges.add"></a>**bridges.add([name], [port], \<pin\>, \<username\>)**
Adds an bridge to the device. This will automatically create a system service and start it.

Parameters
| Name     | Required | Type   | Description                                               |
| -------- | -------- | ------ | --------------------------------------------------------- |
| name     | Yes      | string | The display name for the bridge                           |
| port     | Yes      | number | The port for the bridge, between 1 and 65535              |
| pin      | No       | string | The pin used to pair with HomeKit, defaults to 031-45-154 |
| username | No       | string | The bridge username, will auto generate is not set        |

The name is automatically sanitized and used as an id for the bridge.

> If your operating system doesn't have systemd or launchd the service creation is skipped.

[Top](#home)

## <a name="bridges.import"></a>**bridges.import([file], [name], [port], \<pin\>, \<username\>)**
This will add an bridge from an export of another bridge. This will automatically create a system service and start it.

Parameters
| Name     | Required | Type   | Description                                                     |
| -------- | -------- | ------ | --------------------------------------------------------------- |
| file     | Yes      | Blob   | This can be any backup file stream including an HTTPFile object |
| name     | Yes      | string | The display name for the bridge                                 |
| port     | Yes      | number | The port for the bridge, between 1 and 65535                    |
| pin      | No       | string | The pin used to pair with HomeKit, defaults to 031-45-154       |
| username | No       | string | The bridge username, will auto generate is not set              |

The name is automatically sanitized and used as an id for the bridge.

> If your operating system doesn't have systemd or launchd the service creation is skipped.

[Top](#home)

## <a name="bridge"></a>**bridge([name])**
Fetches an bridge object. Will return `undefined` is the bridge doesn't exist.

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
| Name | Required | Type   | Description                          |
| ---- | -------- | ------ | ------------------------------------ |
| name | Yes      | string | The name or id of the desired bridge |

[Top](#home)

## <a name="bridge.status"></a>**bridge.status()**
Fetch the current status of the bridge.

```js
{
    id: string,
    bridge: string,
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

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.config.get"></a>**bridge.config.get()**
Returns this bridge's configuration data.

```js
{
    plugins: [string],
    accessories: [any],
    platforms: [any]
}
```

Config files are encrypted on the hard drive. The API and CLI are the only ways to edit these files.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.config.update"></a>**bridge.config.update([data])**
This saves the config.

Parameters
| Name | Required | Type | Description                     |
| ---- | -------- | ---- | ------------------------------- |
| data | Yes      | JSON | The complete configuration JSON |

Config files are encrypted on the hard drive. The API and CLI are the only ways to edit these files.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.plugins.list"></a>**bridge.plugins.list()**
Fetch a list of installed plugins on this bridge.

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

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.plugins.install"></a>**bridge.plugins.install([query])**
Installs a plugin on the current bridge.

Parameters
| Name  | Required | Type   | Description                                                |
| ----- | -------- | ------ | ---------------------------------------------------------- |
| query | Yes      | string | This is the scope, name and optional version of the plugin |

Plugin queries are the same as NPM or Yarn queries. Use this format `@scope/name@version`.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.plugins.upgrade"></a>**bridge.plugins.upgrade([query])**
Upgrades a plugin on the current bridge.

Parameters
| Name  | Required | Type   | Description                                                |
| ----- | -------- | ------ | ---------------------------------------------------------- |
| query | Yes      | string | This is the scope, name and optional version of the plugin |

Plugin queries are the same as NPM or Yarn queries. Use this format `@scope/name@version`.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.plugins.uninstall"></a>**bridge.plugins.uninstall([query])**
Uninstalls a plugin on the current bridge.

Parameters
| Name  | Required | Type   | Description                              |
| ----- | -------- | ------ | ---------------------------------------- |
| query | Yes      | string | This is the scope and name of the plugin |

Plugin queries are the same as NPM or Yarn queries. Use this format `@scope/name`.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.update"></a>**bridge.update([name], [autostart], \<pin\>, \<username\>)**
This allows you to edit the bridge information.

Parameters
| Name      | Required | Type    | Description                                                  |
| --------- | -------- | ------- | ------------------------------------------------------------ |
| name      | Yes      | string  | The desired display name for this bridge                     |
| autostart | Yes      | number  | Set the number to delay the start of the bridge (in seconds) |
| pin       | No       | string  | Change the bridge's pin                                      |
| username  | No       | string  | Change the bridge username                                   |

The name is updated but the id will remain unchanged. We do this so you don't have to change any system services.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.ports"></a>**bridge.ports([start], [end])**
This allows you to set the port pool on an bridge. Usefull for camera plugins.

Parameters
| Name  | Required | Type   | Description                                      |
| ----- | -------- | ------ | ------------------------------------------------ |
| start | Yes      | number | The start port for the pool, between 1 and 65535 |
| end   | No       | number | The end port for the pool, between 1 and 65535   |

The end port must be equal to or larger then the start port.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.accessories"></a>**bridge.accessories()**
Fetch a list of accessories for this bridge.

```js
[{
    accessory_identifier: string,
    bridge_identifier: string | undefined,
    bridge: string,
    room: string | null | undefined,
    sequence: number | undefined,
    hidden: boolean | undefined,
    type: string,
    characteristics: [{
        type: string,
        service_type: string,
        value: any,
        format: any,
        unit: any,
        max_value: any,
        min_value: any,
        min_step: any,
        read: boolean,
        write: boolean
    }],
    manufacturer: string,
    model: string,
    name: string,
    serial_number: string,
    firmware_revision: string,
    hardware_revision: string,
    icon: string | undefined
}]
```

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.start"></a>**bridge.start()**
Starts the bridge on this bridge.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.stop"></a>**bridge.stop()**
Stops the bridge on this bridge.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.restart"></a>**bridge.restart()**
Restarts the bridge on this bridge.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

[Top](#home)

## <a name="bridge.cache"></a>**bridge.cache()**
Fetches the accessory and persisted connections cache on this bridge.

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

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

## <a name="bridge.purge"></a>**bridge.purge(\<uuid\>)**
Purges the accessory and persisted cache on this bridge.

Parameters
| Name   | Required | Type   | Description                                |
| ------ | -------- | ------ | ------------------------------------------ |
| uuid   | No       | string | Remove a specific accessory from the cache |

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="bridge.export"></a>**bridge.export()**
This will generate an bridge file and will return a URL to that file. If the export fails an error object is returned.

[Top](#home)

## <a name="bridge.remove"></a>**bridge.remove()**
This will remove this bridge including all plugins and configurations.

> This method is attached to the bridge object you must access this from the `hoobs.bridge([name])` command.

[Top](#home)

## <a name="accessories"></a>**accessories(\<hidden\>)**
Returns a list of rooms, accessories from all bridges.

Parameters
| Name   | Required | Type    | Description                         |
| ------ | -------- | ------- | ----------------------------------- |
| hidden | No       | boolean | Return a list of hidden accessories |

```js
[{
    id: string,
    name: string | undefined,
    sequence: number,
    devices: number,
    accessories: [{
        accessory_identifier: string,
        bridge_identifier: string | undefined,
        bridge: string,
        room: string | null | undefined,
        sequence: number | undefined,
        hidden: boolean | undefined,
        type: string,
        characteristics: [{
            type: string,
            service_type: string,
            value: any,
            format: any,
            unit: any,
            max_value: any,
            min_value: any,
            min_step: any,
            read: boolean,
            write: boolean
        }],
        manufacturer: string,
        model: string,
        name: string,
        serial_number: string,
        firmware_revision: string,
        hardware_revision: string,
        icon: string | undefined
    }]
}]
```

[Top](#home)

## <a name="accessory"></a>**accessory([bridge], [id])**
This fetches a single accessory object.

```js
{
    accessory_identifier: string,
    bridge_identifier: string | undefined,
    bridge: string,
    room: string | null | undefined,
    sequence: number | undefined,
    hidden: boolean | undefined,
    type: string,
    characteristics: [{
        type: string,
        service_type: string,
        value: any,
        format: any,
        unit: any,
        max_value: any,
        min_value: any,
        min_step: any,
        read: boolean,
        write: boolean
    }],
    manufacturer: string,
    model: string,
    name: string,
    serial_number: string,
    firmware_revision: string,
    hardware_revision: string,
    icon: string | undefined
}
```

Parameters
| Name   | Required | Type   | Description                           |
| ------ | -------- | ------ | ------------------------------------- |
| bridge | Yes      | string | The the bridge the accessory is lives |
| id     | Yes      | string | This is the accessory identifier      |

[Top](#home)

## <a name="accessory.set"></a>**accessory.set([characteristic], [data])**
Update or control an accessory. The JSON data for an accessory is contextual for the accessory you are wanting to control.

Parameters
| Name           | Required | Type   | Description                                      |
| -------------- | -------- | ------ | ------------------------------------------------ |
| characteristic | Yes      | string | The characteristic type on the current accessory |
| data           | Yes      | any    | This is contextual data for the accessory state  |

These characteristics are available for all non bridge types and are used to organize accessories.
- name
- room
- hidden
- sequence
- icon

> This method is attached to the accessory object you must access this from the `hoobs.accessory([bridge], [id])` command.

[Top](#home)

## <a name="rooms.count"></a>**rooms.count()**
Returns the count of rooms.

[Top](#home)

## <a name="rooms.list"></a>**rooms.list()**
Returns a list of defined rooms.

> The room name is not included for the default room. This aids in localization.

```js
[{
    id: string,
    name: string,
    sequence: number,
    devices: number,
    types: [string],
    characteristics: [string]
}]
```

[Top](#home)

## <a name="rooms.add"></a>**rooms.add([name], \<sequence\>)**
Adds an room to the device..

Parameters
| Name     | Required | Type   | Description                               |
| -------- | -------- | ------ | ----------------------------------------- |
| name     | Yes      | string | The display name for the room             |
| sequence | No       | number | The room order, will default to the first |

The name is automatically sanitized and used as an id for the room.

[Top](#home)

## <a name="room"></a>**room([id])**
This fetches a single room with accessories, types and characteristics.

```js
{
    id: string,
    name: string | undefined,
    sequence: number,
    devices: number,
    accessories: [{
        accessory_identifier: string,
        bridge_identifier: string | undefined,
        bridge: string,
        room: string | null | undefined,
        sequence: number | undefined,
        hidden: boolean | undefined,
        type: string,
        characteristics: [{
            type: string,
            service_type: string,
            value: any,
            format: any,
            unit: any,
            max_value: any,
            min_value: any,
            min_step: any,
            read: boolean,
            write: boolean
        }],
        manufacturer: string,
        model: string,
        name: string,
        serial_number: string,
        firmware_revision: string,
        hardware_revision: string,
        icon: string | undefined
    }],
    types: [string],
    characteristics: [string]
}
```

Parameters
| Name | Required | Type   | Description         |
| ---- | -------- | ------ | ------------------- |
| id   | Yes      | string | This is the room id |

[Top](#home)

## <a name="room.set"></a>**room.set([characteristic], [data])**
Update or control a room.

Parameters
| Name           | Required | Type   | Description                                      |
| -------------- | -------- | ------ | ------------------------------------------------ |
| characteristic | Yes      | string | The characteristic type on the current room      |
| data           | Yes      | any    | This is contextual data for the room state       |

These characteristics are available for all non default rooms and are used to organize rooms.
- name
- sequence

Rooms also have an aditional "off" characteristic that is added when the room has an "on" characteristic defined. 
This allows you to call `room.set("off", true)` to turn off all light bulbs and switches in a room. This differs from 
`room.set("on", false)`, This example will only turn off light bulbs. The "off" characteristic is only available at 
the room level and is not supported for individual accessories.

> This method is attached to the room object you must access this from the `hoobs.room([id])` command.

[Top](#home)

## <a name="room.remove"></a>**room.remove()**
This will remove the current room.

> This method is attached to the room object you must access this from the `hoobs.room([id])` command.

[Top](#home)

## <a name="theme.get"></a>**theme.get([name])**
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
    accessory: {
        text: string,
        background: string,
        highlight: string,
        input: string,
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

[Top](#home)

## <a name="theme.set"></a>**theme.set([name], [theme])**
This will save a theme to the backend.

Parameters
| Name  | Required | Type   | Description           |
| ----- | -------- | ------ | --------------------- |
| name  | Yes      | string | The name of the theme |
| theme | Yes      | Theme  | The theme JSON object |

[Top](#home)

## <a name="theme.backdrop"></a>**theme.backdrop([image])**
This will upload an image to the backend for use as a backdrop.

Parameters
| Name  | Required | Type | Description                                               |
| ----- | -------- | ---- | --------------------------------------------------------- |
| image | Yes      | Blob | This can be any image stream including an HTTPFile object |

[Top](#home)

## <a name="plugin"></a>**plugin([bridge], [identifier], \<action\>, \<data\>)**
This allows plugins to interact with their backend code.

Parameters
| Name       | Required | Type   | Description                                                   |
| ---------- | -------- | ------ | ------------------------------------------------------------- |
| bridge     | Yes      | string | The bridge id you wish to call.                               |
| identifier | Yes      | string | This is the plugins repository identifier                     |
| action     | No       | string | This is an optional action as defined in the plugin           |
| data       | No       | JSON   | This is JSON data that is posted to the plugin code as needed |

When opening the UI plugin, your HTML file will have these variables defined for you.

- $hoobs: This SDK.
- $bridge: The bridge this dialog if intended.
- $identifier - The plugin identifier, should match your plugin.

[Top](#home)

## <a name="location"></a>**location([query])**
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

[Top](#home)

## <a name="weather.current"></a>**weather.current()**
Fetches the current weather from the configured location on the hub.

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

[Top](#home)

## <a name="weather.forecast"></a>**weather.forecast()**
Fetches the weather forecast from the configured location on the hub.

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

[Top](#home)

## <a name="remote.status"></a>**remote.status()**
Returns the status of a remote session.

```js
{
    active: boolean
}
```

> Only one remote session is allowed per hub.

[Top](#home)

## <a name="remote.connect"></a>**remote.connect()**
Connects to the HOOBS support server. This will allow HOOBS support to diagnose and run commands on your device.

This will return a registration code or an error object if it can't connect.

```js
{
    registration: string
}
```

[Top](#home)

## <a name="remote.disconnect"></a>**remote.disconnect()**
This will disconnect a current active session.

> When HOOBS support disconnects this will automatically be called.

[Top](#home)
