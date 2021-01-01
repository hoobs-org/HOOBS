## SDK
This SDK is designed to be used with JavaScript and includes a Vue plugin.

```js
import hoobs from "@hoobs/sdk";

const version = await hoobs.sdk.version();
```

To include the SDK in a Vue application, you will also need to include the sdk export and configure the Vuex store.

```js
import hoobs from "@hoobs/sdk";
import store from "./store";

hoobs.sdk.config.token.get(() => store.state.session);
hoobs.sdk.config.token.set((token) => { store.commit("SESSION:SET", token); });

Vue.use(hoobs);
```

The Vue plugin creates the $hoobs variable.

Below, defines the properties and methods available in this SDK.

> Note: If you are using this within an Vue component, you can access the SDK from `this.$hoobs`.

## **version()**
This returns the current HOOBSD version installed.

## **latest()**
This returns the latest releasesd HOOBSD version.

## **auth.status()**
This fetches the status of the authentication system. It will return one of these values.

| Status        | Description                                                                |
| ------------- | -------------------------------------------------------------------------- |
| uninitialized | This is the initial status, and the default admin user needs to be created |
| enabled       | This is the auth OK status                                                 |
| disabled      | Auth system is disabled and will not require a login                       |

> The disabled status can only be achieved when the auth system is uninitilized.

## **auth.validate()**
This validates the token stored in the Vuex store. If the auth system is disabled, this will always return true.

> Tokens are stored on in the API and have a TTL based in teh `inactive_logoff` setting on the API.

## **auth.disable()**
This will disable the auth system.

The auth system can only be disabled if there are no users. If you would like to disable the auth system after users have been created, you must first remove the `access` file from the storage path.

This will return the auth system status.

## **auth.login([username], [password])**
This will attempt to login to the API. If the login is successful the token will be added to the Vuex store and stored locally.

If the login fails this function will return `false`.

Parameters
| Name     | Required | Type   | Description                             |
| -------- | -------- | ------ | --------------------------------------- |
| username | Yes      | string | The username defined on the user record |
| password | Yes      | string | The password defined on the user record |

## **auth.logout()**
This takes the session token from the store and logs out the current user.

## **io()**
This returnes an instance of the web socket used to communicate with the backend.

Events
| Name             | Description                                                               |
| ---------------- | ------------------------------------------------------------------------- |
| connect          | Fires when the socket connects                                            |
| disconnect       | Fires when the socket disconnects                                         |
| reconnect        | Fires when the socket reconnects                                          |
| log              | This event is fired when the backend writes to the console                |
| monitor          | This fires on an interval set in the API, sends monitor data to the UI    |
| notification     | Fires when a notification is generated in the API                         |
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

## **io.on([event], [callback])**
This adds a listner on the socket for specific events.

Parameters
| Name     | Required | Type     | Description                                |
| -------- | -------- | -------- | ------------------------------------------ |
| event    | Yes      | string   | Predefined event name                      |
| callback | Yes      | function | The function to call when event is emitted |

> All events return a JSON payload or undefined

## **io.off([event])**
Disables all listners for a given event.

## **io.emit([event], [...arguments])**
Allows you to emit events from the UI to the backend.

> Arguments are specific to each event

## **dates.display([date])**
Formats a string date or a timestamp into a friendly display.

Parameters
| Name | Required | Type     | Description                |
| ---- | -------- | -------- | -------------------------- |
| date | Yes      | string   | A date string or timestamp |

## **dates.age([date])**
Formats a string date or a timestamp into an age string line "5 days ago"

Parameters
| Name | Required | Type     | Description                |
| ---- | -------- | -------- | -------------------------- |
| date | Yes      | string   | A date string or timestamp |

## **dates.ordinal([value])**
Converts a number into an ordinal like "7th"

Parameters
| Name  | Required | Type     | Description      |
| ----- | -------- | -------- | ---------------- |
| value | Yes      | number   | Any number value |

## **dates.month([value])**
Converts a month from Date.getMonth() to a test string.

Parameters
| Name  | Required | Type     | Description      |
| ----- | -------- | -------- | ---------------- |
| value | Yes      | number   | Any number value |

## **users.list()**
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
        instances: boolean,
        plugins: boolean,
        users: boolean,
        reboot: boolean,
        config: boolean
    }
}]
```

## **users.add([username], [password], \<name\>, \<permissions\>)**
This will add a new user to the system.

Parameters
| Name        | Required | Type   | Description                                           |
| ----------- | -------- | ------ | ----------------------------------------------------- |
| username    | Yes      | string | The desired username                                  |
| password    | Yes      | string | The new user's password                               |
| name        | No       | string | The new user's full name, if not set username is used |
| permissions | No       | string | The new user's permissions settings                   |

## **user([id])**
Fetches a user object by id.

```js
{
    id: number,
    username: string,
    name: string,
    permissions: {
        accessories: boolean,
        controller: boolean,
        instances: boolean,
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

## **config.get()**
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

## **config.update([data])**
This saves the config.

Parameters
| Name | Required | Type | Description                     |
| ---- | -------- | ---- | ------------------------------- |
| data | Yes      | JSON | The complete configuration JSON |

> Config files are encrypted on the hard drive. The API and CLI are the only ways to edit these files.

## **log(\<tail\>)**
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

## **status()**
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

## **backup.execute()**
This will generate a backup file and will return a URL to that file. If the backup fails an error object is returned.

## **backup.catalog()**
Returns an list of backups available.

```js
[{
    date: number,
    filename: string,
}]
```

## **restore.file([filename])**
This will accept a file name from the backup catalog and will restore it.

> This will reboot the device

Parameters
| Name     | Required | Type   | Description                                            |
| -------- | -------- | ------ | ------------------------------------------------------ |
| filename | Yes      | string | The file name without the path from the backup catalog |

## **restore.upload([file])**
This will accept an uploaded file and restore it to the system.

> This will reboot the device

Parameters
| Name | Required | Type | Description                                                     |
| ---- | -------- | ---- | --------------------------------------------------------------- |
| file | Yes      | Blob | This can be any backup file stream including an HTTPFile object |

## **system()**
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

## **hostname.get()**
This allows you to view the broadcasted hostname.

> Note this is only available on HOOBS devices like the HOOBS Box and the HOOBS SD Card.

## **hostname.update([name])**
This allows you to set the broadcasted hostname.

> Note this doesn't change the system's hostname, it only changes the mDNS broadcasted hostname.

> Note this is only available on HOOBS devices like the HOOBS Box and the HOOBS SD Card.

## **extentions.list()**
This will fetch a list of available extentions and if the extention is enabled.

```js
[{
    feature: string,
    description: string,
    enabled: boolean
}]
```

## **extentions.add([name])**
This will enable an extention on the system.

Parameters
| Name | Required | Type   | Description                         |
| ---- | -------- | ------ | ----------------------------------- |
| name | Yes      | string | The name of the extention to enable |

## **extentions.remove([name])**
This will disable an extention on the system.

Parameters
| Name | Required | Type   | Description                          |
| ---- | -------- | ------ | ------------------------------------ |
| name | Yes      | string | The name of the extention to disable |

## **plugins()**
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

## **repository.featured()**
Fetches a list of featured plugins from HOOBS Cloud.

## **repository.popular()**
Fetches a list of popular plugins from HOOBS Cloud.

## **repository.search([query], [skip], [limit])**
Search for plugins on HOOBS Cloud in order of hit rank.

Parameters
| Name  | Required | Type   | Description                          |
| ----- | -------- | ------ | ------------------------------------ |
| query | Yes      | string | The search query                     |
| skip  | Yes      | number | Skip the first number of plugins     |
| limit | Yes      | number | Limit the number of plugins returned |

## **repository.details([identifier])**
Fetches a plugin details including readme and config schemas.

Parameters
| Name       | Required | Type   | Description                                     |
| ---------- | -------- | ------ | ----------------------------------------------- |
| identifier | Yes      | string | The plugin identifier as it appears in the repo |

> Note plugin identifiers include the scope, like @scope/plugin-name.

## **repository.reviews([identifier], [skip], [limit])**
Fetch a list of reviews for a given plugin ordered by newest review.

Parameters
| Name       | Required | Type   | Description                                     |
| ---------- | -------- | ------ | ----------------------------------------------- |
| identifier | Yes      | string | The plugin identifier as it appears in the repo |
| skip       | Yes      | number | Skip the first number of plugins                |
| limit      | Yes      | number | Limit the number of plugins returned            |

## **repository.title([value])**
Converts a plugin name or identifier into a friendly display name.

Parameters
| Name  | Required | Type   | Description                   |
| ----- | -------- | ------ | ----------------------------- |
| value | Yes      | string | The plugin name or identifier |

## **instances.count()**
Returns the count of instances.

## **instances.list()**
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

## **instances.add([name], [port], \<pin\>, \<username\>)**
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

## **instances.import([file], [name], [port], \<pin\>, \<username\>)**
This will add an instance from an export of another instance. This will automatically create a system service and start it.

Parameters
| Name     | Required | Type   | Description                                                     |
| -------- | -------- | ------ | --------------------------------------------------------------- |
| file     | Yes      | Blob   | This can be any backup file stream including an HTTPFile object |
| name     | Yes      | string | The display name for the instance                               |
| port     | Yes      | number | The port for the instance, between 1 and 65535                  |
| pin      | No       | string | The pin used to pair with HomeKit, defaults to 031-45-154       |
| username | No       | string | The bridge username, will auto generate is not set              |

The name is automatically sanitized and used as an id for the instance.

> If your operating system doesn't have systemd or launchd the service creation is skipped.

## **instance([name])**
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
    plugins: [string],
    accessories: [any],
    platforms: [any]
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

## **instance.export()**
This will generate an instance file and will return a URL to that file. If the export fails an error object is returned.

## **instance.remove()**
This will remove this instance including all plugins and configurations.

> This method is attached to the instance object you must access this from the `hoobs.instance([name])` command.

## **accessories()**
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

## **accessory([instance], [id])**
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

## **theme.get([name])**
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

## **theme.set([name], [theme])**
This will save a theme to the backend.

Parameters
| Name  | Required | Type   | Description           |
| ----- | -------- | ------ | --------------------- |
| name  | Yes      | string | The name of the theme |
| theme | Yes      | Theme  | The theme JSON object |

## **theme.backdrop([image])**
This will upload an image to the backend for use as a backdrop.

Parameters
| Name  | Required | Type | Description                                               |
| ----- | -------- | ---- | --------------------------------------------------------- |
| image | Yes      | Blob | This can be any image stream including an HTTPFile object |

## **plugin([instance], [identifier], \<action\>, \<data\>)**
This allows plugins to interact with their backend code.

Parameters
| Name       | Required | Type   | Description                                                   |
| ---------- | -------- | ------ | ------------------------------------------------------------- |
| instance   | Yes      | string | The instance id you wish to call.                             |
| identifier | Yes      | string | This is the plugins repository identifier                     |
| action     | No       | string | This is an optional action as defined in the plugin           |
| data       | No       | JSON   | This is JSON data that is posted to the plugin code as needed |

When opening the UI plugin, your HTML file will have these variables defined for you.

* $hoobs: This SDK.
* $instance: The instance this dialog if intended.
* $identifier - The plugin identifier, should match your plugin.

## **location([query])**
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

## **weather.current()**
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

## **weather.forecast()**
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

## **remote.status()**
Returns the status of a remote session.

```js
{
    active: boolean
}
```

> Only one remote session is allowed per API.

## **remote.connect()**
Connects to the HOOBS support server. This will allow HOOBS support to diagnose and run commands on your device.

This will return a registration code or an error object if it can't connect.

```js
{
    registration: string
}
```

## **remote.disconnect()**
This will disconnect a current active session.

> When HOOBS support disconnects this will automatically be called.
