# <a name="home"></a>API Reference
The HOOBS API exposes methods that allows you to monitor, configure and control your device.

> Notes about this documentation. URLs are prefixed with either a GET, POST, PUT or DELETE these document what HTTP verb the request accepts. If the request requires a body it will be prefixed with a Body:.

## **Table of Contents**
- [Authentication](#auth)
    - [Status](#auth.status)
    - [Disable](#auth.disable)
    - [Login](#auth.login)
    - [Logout](#auth.logout)
    - [Validate](#auth.validate)
- [Users](#users)
    - [Create](#users.create)
- [User](#user)
    - [Update](#user.update)
    - [Delete](#user.delete)
- [Version](#version)
- [Service](#status)
- [Hostname](#host)
    - [Update](#host.update)
- [System](#system)
    - [CPU](#system.cpu)
    - [Memory](#system.memory)
    - [Network](#system.network)
    - [File System](#system.filesystem)
    - [Activity](#system.activity)
    - [Temprature](#system.temp)
    - [Backup](#system.backup)
    - [Backups](#system.catalog)
    - [Restore](#system.restore)
    - [Upgrade](#system.upgrade)
    - [Reboot](#system.reboot)
    - [Factory Reset](#system.reset)
- [Log](#log)
- [Hub](#hub)
    - [Reconfigure](#hub.reconfig)
    - [Cache](#hub.cache)
    - [Purge](#hub.purge)
- [Extentions](#extentions)
- [Bridges](#bridges)
    - [Create](#bridges.create)
    - [Count](#bridges.count)
    - [Import](#bridges.import)
- [Bridge](#bridge)
    - [Update](#bridge.update)
    - [Delete](#bridge.delete)
    - [Ports](#bridge.ports)
    - [Configuration](#bridge.config)
    - [Reconfigure](#bridge.reconfig)
    - [Plugins](#bridge.plugins)
    - [Cache](#bridge.cache)
    - [Purge](#bridge.purge)
    - [Export](#bridge.export)
    - [Start](#bridge.start)
    - [Stop](#bridge.stop)
    - [Restart](#bridge.restart)
- [Plugins](#plugins)
    - [Install](#plugins.install)
    - [Uninstall](#plugins.uninstall)
    - [Update](#plugins.update)
- [Plugin](#plugin)
    - [Static](#plugin.ui)
    - [Action](#plugin.action)
- [Accessories](#accessories)
    - [Update](#accessories.update)
    - [Hidden](#accessories.hidden)
- [Rooms](#rooms)
    - [Create](#rooms.create)
- [Room](#room)
    - [Update](#room.update)
    - [Remove](#room.remove)
- [Cache](#cache)
- [Themes](#themes)
- [Location](#location)
- [Weather](#weather)
    - [Forecast](#weather.forecast)

## <a name="auth"></a>Authentication
This is the main entry point to the API. You can use this to authenticate and recieve an authorization token.

[Top](#home)

#### <a name="auth.status"></a>Status
Sume users choose to enable authentication. To determine this you can access the status command.

Request
```http
POST /api/auth
```

Response
```json
{
    "state": "enabled"
}
```

Available states.
* uninitilized
* enabled
* disabled

[Top](#home)

#### <a name="auth.disable"></a>Disable
You can disable the auth system using this call.

> Note. You can only disable uninitilized instances.

Request
```http
POST /api/auth/disable
```

Response
```json
{
    "state": "disabled"
}
```

[Top](#home)

#### <a name="auth.login"></a>Login
Creates a session for the given user.

Request
```http
POST /api/auth/logon
Body: application/json
```

Body
```json
{
    "username": "luke_skywalker",
    "password": "MayTheForceBeWithYou",
    "remember": false
}
```

Response
```json
{
    "token": "THVrZSBTa3l3YWxrZXI="
}
```

The token will be null if authentication has failed. The token can now be used in the authroization header for all other requests to the API.

[Top](#home)

#### <a name="auth.logout"></a>Logout
Removes the current user's session from the server.

Request
```http
GET /api/auth/logout
```

Response
```json
{
    "success": true
}
```

[Top](#home)

#### <a name="auth.validate"></a>Validate
Validates the current session

Request
```http
GET /api/auth/validate
```

Response
```json
{
    "valid": true
}
```

[Top](#home)

## <a name="users"></a>Users
List all users.

Request
```http
GET /api/users
```

Response
```json
[{
    "id": 1,
    "username": "admin",
    "name": "Administrator",
    "permissions": {
        "accessories": true,
        "controller": true,
        "bridges": true,
        "terminal": true,
        "plugins": true,
        "users": false,
        "reboot": true,
        "config": true
    }
}]
```

[Top](#home)

#### <a name="users.create"></a>Create
Create a user

Request
```http
PUT /api/users
Body: application/json
```

Body
```json
{
    "name": "Full Name",
    "username": "username",
    "password": "password",
    "permissions": {
        "accessories": true,
        "controller": true,
        "bridges": true,
        "terminal": true,
        "plugins": true,
        "users": false,
        "reboot": true,
        "config": true
    }
}
```

[Top](#home)

## <a name="user"></a>User
Fetch a single user.

Request
```http
GET /api/users/:id
```

Response
```json
{
    "id": 1,
    "username": "admin",
    "name": "Administrator",
    "permissions": {
        "accessories": true,
        "controller": true,
        "bridges": true,
        "terminal": true,
        "plugins": true,
        "users": false,
        "reboot": true,
        "config": true
    }
}
```

[Top](#home)

#### <a name="user.update"></a>Update
Updates a user record.

Request
```http
POST /api/users/:id
Body: application/json
```

Body
```json
{
    "name": "Full Name",
    "username": "username",
    "password": "password",
    "permissions": {
        "accessories": true,
        "controller": true,
        "bridges": true,
        "terminal": true,
        "plugins": true,
        "users": false,
        "reboot": true,
        "config": true
    }
}
```

[Top](#home)

#### <a name="user.delete"></a>Delete
Deletes a user.

Request
```http
DELETE /api/users/:id
```

[Top](#home)

## <a name="version"></a>Version
Fetches information about the hoobsd service

Request
```http
GET /api
```

Response
```json
{
    "application": "hoobsd",
    "version": "4.0.37",
    "authentication": {
        "state": "/api/auth",
        "login": "/api/auth/logon",
        "validate": "/api/auth/validate"
    },
    "network": [{
        "interface": "eth0",
        "ip_address": "127.0.0.1",
        "mac_addr": "CC:22:3D:E3:CE:30"
    }]
}
```

[Top](#home)

## <a name="status"></a>Service
Fetches the current status of the hub and bridges

Request
```http
GET /api/status
```

Response
```json
{
    "product": "box",
    "mdns": true,
    "broadcast": "hoobs",
    "version": "4.0.37",
    "current": "4.0.37",
    "upgraded": true,
    "cli_version": "4.0.17",
    "cli_current": "4.0.17",
    "cli_upgraded": true,
    "gui_version": "4.0.36",
    "gui_current": "4.0.37",
    "gui_upgraded": false,
    "node_version": "14.16.0",
    "node_current": "14.16.0",
    "node_upgraded": true,
    "bridges": [{
        "version": "4.0.37",
        "running": true,
        "status": "running",
        "uptime": 123456,
        "product": "hoobsd",
        "bridge_name": "testbridge",
        "bridge_username": "CC:22:3D:E3:CE:30",
        "bridge_port": 51826,
        "setup_pin": "123-45-67",
        "setup_id": "//:123456",
        "bridge_path": "/var/lib/hoobs/testbridge"
    }],
    "cpu": {
        "avgLoad": 22,
        "currentLoad": 22,
        "currentLoadUser": 22,
        "currentLoadSystem": 22,
        "currentLoadNice": 22,
        "currentLoadIdle": 22,
        "currentLoadIrq": 22
    },
    "memory": {
        "total": 4028,
        "free": 1024,
        "used": 1024,
        "active": 1024,
        "buffcache": 1024,
        "buffers": 1024,
        "cached": 1024,
        "slab": 1024,
        "available": 1024,
        "swaptotal": 1024,
        "swapused": 1024,
        "swapfree": 1024
    },
    "temp": {
        "main": 42,
        "cores": 42,
        "max": 42,
        "socket": 42,
        "chipset": 42
    }
}
```

[Top](#home)

## <a name="host"></a>Hostname
Fetch or set the current mDNS broadcast hostname.

Request
```http
GET /api/system/hostname
```

Response
```json
{
    "hostname": "hoobs"
}
```

[Top](#home)

#### <a name="host.update"></a>Update
Change the broadcasted hostname

Request
```http
POST /api/system/hostname
Body: application/json
```

Body
```json
{
    "hostname": "hoobs-second"
}
```

Response
```json
{
    "success": true
}
```

[Top](#home)

## <a name="system"></a>System
Fetch basic system information

Request
```http
GET /api/system
```

Response
```json
{
    "mac": "CC:22:3D:E3:CE:30",
    "ffmpeg_enabled": false,
    "system": {
        "manufacturer": "HOOBS.org",
        "model": "P3X-995",
        "version": "4.0.15",
        "sku": "0-9999-9999-0"
    }
}
```

[Top](#home)

#### <a name="system.cpu"></a>CPU
Fetch CPU information.

Request
```http
GET /api/system/cpu
```

Response
```json
{
    "information": {
        "manufacturer": "Cortex",
        "brand":	"Cortex A5",
        "speed": "3.40",
        "speedMin": "0.80",
        "speedMax": "3.90",
        "governor": "powersave",
        "cores": 8,
        "physicalCores": 4,
        "processors": 1,
        "socket": "LGA1356",
        "vendor": "123456",
        "family": "ARM",
        "model": "A5",
        "voltage": 1.3
    },
    "speed": {
        "avg": "3.40",
        "min": "3.40",
        "max": "3.40",
        "cores": 4
    },
    "load": {
        "avgLoad": 22,
        "currentLoad": 22,
        "currentLoadUser": 22,
        "currentLoadSystem": 22,
        "currentLoadNice": 22,
        "currentLoadIdle": 22,
        "currentLoadIrq": 22
    },
    "cache": {
        "l1d": 123,
        "l1i": 123,
        "l2": 123,
        "l3": 123
    }
}
```

[Top](#home)

#### <a name="system.memory"></a>Memory
Fetch memory information.

Request
```http
GET /api/system/memory
```

Response
```json
{
    "information": [{
        "size": 1234,
        "bank": "A2",
        "type": "DDR4",
        "clockSpeed": 1.3,
        "formFactor": "DIMM",
        "manufacturer": "Samsung",
        "partNum": "123456",
        "serialNum": "123456",
        "voltageConfigured": 1.3,
        "voltageMin": 1.0,
        "voltageMax": 1.6
    }],
    "load": {
        "total": 4028,
        "free": 1024,
        "used": 1024,
        "active": 1024,
        "buffcache": 1024,
        "buffers": 1024,
        "cached": 1024,
        "slab": 1024,
        "available": 1024,
        "swaptotal": 1024,
        "swapused": 1024,
        "swapfree": 1024
    }
}
```

[Top](#home)

#### <a name="system.network"></a>Network
Fetch network information.

Request
```http
GET /api/system/network
```

Response
```json
[
    "127.0.0.1"
]
```

[Top](#home)

#### <a name="system.filesystem"></a>File System
Fetch disk information.

Request
```http
GET /api/system/filesystem
```

Response
```json
[{
    "fs": "root",
    "type": "ext4",
    "size": 123456,
    "used": 123456,
    "available": 123456,
    "use": 123456,
    "mount": "/"
}]
```

[Top](#home)

#### <a name="system.activity"></a>Activity
Fetch process information.

Request
```http
GET /api/system/activity
```

Response
```json
{
    "total": 4028,
    "free": 1024,
    "used": 1024,
    "active": 1024,
    "buffcache": 1024,
    "buffers": 1024,
    "cached": 1024,
    "slab": 1024,
    "available": 1024,
    "swaptotal": 1024,
    "swapused": 1024,
    "swapfree": 1024
}
```

[Top](#home)

#### <a name="system.temp"></a>Temprature
Fetch CPU temprature.

Request
```http
GET /api/system/temp
```

Response
```json
{
    "main": 42,
    "cores": 42,
    "max": 42,
    "socket": 42,
    "chipset": 42
}
```

[Top](#home)

#### <a name="system.backup"></a>Backup
Generates a backup file.

Request
```http
GET /api/system/backup
```

Response
```json
{
    "success": true,
    "filename": "hoobs.backup",
}
```

[Top](#home)

#### <a name="system.catalog"></a>Backups
Fetch a list of stored backups.

Request
```http
GET /api/system/backup/catalog
```

Response
```json
[{
    "date": "",
    "filename": "hoobs.backup"
}]
```

> Files are located in the http://[ip address]/backups/

[Top](#home)

#### <a name="system.restore"></a>Restore
Restore from a stored backup.

Request
```http
GET /api/system/restore
```

Upload a backup file and restore.

Request
```http
POST /api/system/restore
Body: multipart/binary
```

[Top](#home)

#### <a name="system.upgrade"></a>Upgrade
Upgrade to latest software.

Request
```http
POST /api/system/upgrade
```

[Top](#home)

#### <a name="system.reboot"></a>Reboot
Reboot the device.

Request
```http
PUT /api/system/reboot
```

[Top](#home)

#### <a name="system.reset"></a>Factory Reset
Factorey reset.

Request
```http
PUT /api/system/reset
```

> This will remove all plugins and configs. It will not delete stored backups.

[Top](#home)

## <a name="log"></a>Log
Fetch the log.

Request
```http
GET /api/log/:tail
```

> Tail is not required. It will default to 500

Response
```json
{
    "level": "info",
    "bridge": "testbridge",
    "display": "Test Bridge",
    "timestamp": 123456,
    "plugin": "homebridge-dummy",
    "prefix": "Dummy",
    "message": "Dummy plugin loaded"
}
```

[Top](#home)

## <a name="hub"></a>Hub
Fetches the hub configuration.

Request
```http
GET /api/config
```

Response
```json
{
    "api": {
        "origin": "*",
        "gui_path": "/usr/lib/hoobs"
    }
}
```

[Top](#home)

#### <a name="hub.reconfig"></a>Reconfigure
Update the hub configuration.

Request
```http
POST /api/config
Body: application/json
```

Body
```json
{
    "api": {
        "origin": "*",
        "gui_path": "usri/lib/hoobs"
    }
}
```

[Top](#home)

#### <a name="hub.cache"></a>Cache
Fetches the cache from all bridges.

Request
```http
GET /api/cache
```

Response
```json
[{
    "bridge": "testbridge",
    "parings": [{
        "id" "",
        "version": "xx.xx",
        "username": "AB:CD:EF:GH:IJ",
        "display": "",
        "category": "",
        "setup_pin": "xxx-xxx-xx",
        "setup_id": "://",
        "clients": "",
        "permissions": "rw",
    }],
    "accessories": [],
}]
```

[Top](#home)

#### <a name="hub.purge"></a>Purge
This clears the hub cache.

Request
```http
DELETE /api/cache/purge
```

> Note. This clears the hub cache, not the bridge cache. The hub caches information like sessions, plugin definitions, etc...

[Top](#home)

## <a name="extentions"></a>Extentions
List extentions and their status.

Request
```http
GET /api/extentions
```

Response
```json
{
    "feature": "gui",
    "description": "enables the gui",
    "enabled": true
}
```

> Note. Extentions are different from plugins. Extentions act on the hub not the bridge.

[Top](#home)

#### <a name="extentions.enable"></a>Enable
Enable an extention.

Request
```http
PUT /api/extentions/:name
```

Response
```json
{
    "success": true
}
```

[Top](#home)

#### <a name="extentions.disable"></a>Disable
Disable and extention.

Request
```http
DELETE /api/extentions/:name
```

Response
```json
{
    "success": true
}
```

[Top](#home)

## <a name="bridges"></a>Bridges
List all bridges.

Request
```http
GET /api/bridges
```

Response
```json
[{
    "id": "testbridge",
    "type": "bridge",
    "display": "Test Bridge",
    "port": 50826,
    "pin": "123-45-67",
    "username": "AB:CD:EF:GH:IJ:KL",
    "ports": {
        "start": 2345,
        "end": 3345
    },
    "autostart": 0,
    "advertiser": "bonjour"
}]
```

[Top](#home)

#### <a name="bridges.create"></a>Create
Creates a bridge.

Request
```http
PUT /api/bridges
Body: application/json
```

Body
```json
{
    "name": "Test Bridge",
    "port": 51826,
    "pin": "031-45-154",
    "username": "AB:CD:EF:GH:IJ:KL",
    "autostart": 0,
    "advertiser": "bonjour"
}
```

[Top](#home)

#### <a name="bridges.count"></a>Count
Return a bridge count.

Request
```http
GET /api/bridges/count
```

Response
```json
{
    "bridges": 2
}
```

[Top](#home)

#### <a name="bridges.import"></a>Import
Upload and create a bridge from an export file.

Request
```http
POST /api/bridges/import
Body: multipart/binary
```

[Top](#home)

## <a name="bridge"></a>Bridge
Update a single bridge.

Request
```http
GET /api/bridge/:bridge
```

Response
```json
{
    "id": "testbridge",
    "type": "bridge",
    "display": "Test Bridge",
    "port": 50826,
    "pin": "123-45-67",
    "username": "AB:CD:EF:GH:IJ:KL",
    "ports": {
        "start": 2345,
        "end": 3345
    },
    "autostart": 0,
    "advertiser": "bonjour"
}
```

[Top](#home)

#### <a name="bridge.update"></a>Update
Edit a bridge record.

Request
```http
POST /api/bridge/:id
Body: application/json
```

Body
```json
{
    "display": "Test Bridge",
    "pin": "031-45-154",
    "username": "AB:CD:EF:GH:IJ:KL",
    "autostart": 0,
    "advertiser": "bonjour"
}
```

[Top](#home)

#### <a name="bridge.delete"></a>Delete
Remove a bridge.

Request
```http
DELETE /api/bridge/:id
```

> Note. Deleting a bridge also removes plugins and stops it from running.

[Top](#home)

#### <a name="bridge.ports"></a>Ports
Update the accessory ports.

Request
```http
POST /api/bridge/:id/ports
Body: application/json
```

Body
```json
{
    "start": 2345,
    "end": 3345
}
```

[Top](#home)

#### <a name="bridge.config"></a>Configuration
Fetches a bridge configuration.

Request
```http
GET /api/config/:bridge
```

Response
```json
{
    "accessories": [],
    "platforms": [],
}
```

[Top](#home)

#### <a name="bridge.reconfig"></a>Reconfigure
Update a bridge configuration.

Request
```http
POST /api/config/:bridge
Body: application/json
```

Body
```json
{
    "accessories": [],
    "platforms": [],
}
```

[Top](#home)

#### <a name="bridge.plugins"></a>Plugins
Fetches a list of plugins on a bridge.

Request
```http
GET /api/plugins/:bridge
```

Response
```json
[{
    "identifier": "plugin-name",
    "scope": "scope",
    "name": "name",
    "icon": "http://icon.url",
    "alias": "Plugin Alias",
    "version": "1.0.1",
    "latest": "1.0.1",
    "certified": false,
    "rating": 4.0,
    "keywords": ["plugin-keywords"],
    "details": [{
        "alias": "Plugin Alias",
        "type": "platform"
    }],
    "schema": {},
    "description": "plugin description",
}]
```

[Top](#home)

#### <a name="bridge.config"></a>Cache
Fetches a bridge configuration.

Request
```http
GET /api/cache/:bridge
```

Response
```json
{
    "parings": [{
        "id" "",
        "version": "xx.xx",
        "username": "AB:CD:EF:GH:IJ",
        "display": "",
        "category": "",
        "setup_pin": "xxx-xxx-xx",
        "setup_id": "://",
        "clients": "",
        "permissions": "rw",
    }],
    "accessories": [],
}
```
[Top](#home)

#### <a name="bridge.reconfig"></a>Purge
Update a bridge configuration.

Request
```http
DELETE /api/cache/:bridge/purge/:uuid
```

The UUID field is not required. If it is not defined this will purge all accessories and parings.

[Top](#home)

#### <a name="bridge.export"></a>Export
Export a bridge.

Request
```http
GET /api/bridge/:id/export
```

Response
```json
{
    "success": true,
    "filename": "testbridge.backup"
}
```

[Top](#home)

#### <a name="bridge.start"></a>Start
Starts a stopped bridge.

Request
```http
POST /api/bridge/:bridge/start
```

[Top](#home)

#### <a name="bridge.stop"></a>Stop
Stops a running bridge.

Request
```http
POST /api/bridge/:bridge/stop
```

[Top](#home)

#### <a name="bridge.restart"></a>Restart
Restarts a running or stopped bridge.

Request
```http
POST /api/bridge/:bridge/restart
```

[Top](#home)

## <a name="plugins"></a>Plugins
List all installed plugins.

Request
```http
GET /api/plugins
```

Response
```json
[{
    "bridge": "testbridge",
    "identifier": "plugin-name",
    "scope": "scope",
    "name": "name",
    "icon": "http://icon.url",
    "alias": "Plugin Alias",
    "version": "1.0.1",
    "latest": "1.0.1",
    "certified": false,
    "rating": 4.0,
    "keywords": ["plugin-keywords"],
    "details": [{
        "alias": "Plugin Alias",
        "type": "platform"
    }],
    "schema": {},
    "description": "plugin description",
}]
```

[Top](#home)

#### <a name="plugins.install"></a>Install
Install a plugin on a bridge.

Request
```http
PUT /api/plugins/:bridge/:name
```

Response
```json
{
    "success": true
}
```

> Note. The name field supports scopes, so if you have a scoped plugin just enter it complete with the slash like `@hoobs/plugin`. The name field also supports versions `@hoobs/plugin@1.0.1`. If a version is not set it defaults to latest.

[Top](#home)

#### <a name="plugins.uninstall"></a>Uninstall
Uninstall a plugin from a bridge.

Request
```http
DELETE /api/plugins/:bridge/:name
```

Response
```json
{
    "success": true
}
```

> Note. The name field supports scopes, so if you have a scoped plugin just enter it complete with the slash like `@hoobs/plugin`.

[Top](#home)

#### <a name="plugins.update"></a>Update
Update a plugin on a bridge.

Request
```http
POST /api/plugins/:bridge/:name
```

Response
```json
{
    "success": true
}
```

> Note. The name field supports scopes, so if you have a scoped plugin just enter it complete with the slash like `@hoobs/plugin`. The name field also supports versions `@hoobs/plugin@1.0.1`. If a version is not set it defaults to latest.

[Top](#home)

## <a name="plugin"></a>Plugin
This section is for UI plugins included with a plugin or via a sidecar. A plugin consists of a `routes.js` file and a `ui` folder that contains static files like `index.html` and `app.js`. Refer to the UI Plugin Documentation for further details.

[Top](#home)

#### <a name="plugin.ui"></a>Static
Fetch a static file.

Request
```http
GET /ui/plugin/:identifier/*
```

This returns any staticfile included with the plugin. It will default to index.html is no file is defined.

> Note. If you try to access index.html without a file the trailing slash is important, and must be included.

[Top](#home)

#### <a name="plugin.action"></a>Action
This section is for UI plugins included with a plugin or via a sidecar.

Request
```http
POST /api/plugin/:identifier/:action
Body: application/json
```

The response and body is determined by the registered route from the plugin's `routes.js` file.

> Note. Access to the bridge is restricted. If you need to modify values in the bridge use either the API, SDK, or your main plugin.

[Top](#home)

## <a name="accessories"></a>Accessories
Fetches a list of rooms and accessories.

Request
```http
GET /api/accessories
```

Response
```json
[{
    "id": "livingroom",
    "name": "Living Room",
    "sequence": 1,
    "devices": 5,
    "accessories": [{
        "accessory_identifier": "123456",
        "bridge_identifier": "123456",
        "bridge": "testbridge",
        "plugin": "plugin-name",
        "room": "livingroom",
        "sequence": 1,
        "hidden": false,
        "type": "light",
        "characteristics": [{
            "type": "on",
            "service_type": "on",
            "value": true,
            "format": "boolean",
            "unit": 1,
            "max_value": 1,
            "min_value": 0,
            "min_step": 1,
            "read": true,
            "write": true
        }],
        "manufacturer": "Lutron",
        "model": "Caseta",
        "name": "Main Light",
        "serial_number": "123456",
        "firmware_revision": "123456",
        "hardware_revision": "123456",
        "icon": "floor-lamp"
    }]
}]
```

[Top](#home)

#### <a name="accessories.update"></a>Update
Updates an accessory including device control.

Request
```http
PUT /api/accessory/:bridge/:id/:service
Body: application/json
```

Body
```json
{
    "value": true
}
```

You can also change the name, room, sequence, or hidden field using this method.

[Top](#home)

#### <a name="accessories.hidden"></a>Hidden
Shows a list of hidden accessories.

Request
```http
GET /api/accessories/hidden
```

Response
```json
[{
    "id": "livingroom",
    "name": "Living Room",
    "accessories": [{
        "accessory_identifier": "123456",
        "bridge_identifier": "123456",
        "bridge": "testbridge",
        "plugin": "plugin-name",
        "room": "livingroom",
        "sequence": 1,
        "hidden": true,
        "type": "light",
        "manufacturer": "Lutron",
        "model": "Caseta",
        "name": "Main Light",
        "serial_number": "123456",
        "firmware_revision": "123456",
        "hardware_revision": "123456",
        "icon": "floor-lamp"
    }]
}]
```

[Top](#home)

## <a name="rooms"></a>Rooms
Fetches a list of rooms.

Request
```http
GET /api/rooms
```

Response
```json
[{
    "id": "livingroom",
    "name": "Living Room",
    "sequence": 1,
    "devices": 5,
    "types": ["light"],
    "characteristics": ["on"]
}]
```

[Top](#home)

#### <a name="rooms.create"></a>Create
Creates a room.

Request
```http
PUT /api/room
Body: application/json
```

Body
```json
{
    "name": "Living Room",
    "sequence": 1
}
```

[Top](#home)

## <a name="room"></a>Room
Fetch a single room.

Request
```http
GET /api/room/:id
```

Response
```json
{
    "id": "livingroom",
    "name": "Living Room",
    "sequence": 1,
    "devices": 5,
    "accessories": [{
        "accessory_identifier": "123456",
        "bridge_identifier": "123456",
        "bridge": "testbridge",
        "plugin": "plugin-name",
        "room": "livingroom",
        "sequence": 1,
        "hidden": false,
        "type": "light",
        "characteristics": [{
            "type": "on",
            "service_type": "on",
            "value": true,
            "format": "boolean",
            "unit": 1,
            "max_value": 1,
            "min_value": 0,
            "min_step": 1,
            "read": true,
            "write": true
        }],
        "manufacturer": "Lutron",
        "model": "Caseta",
        "name": "Main Light",
        "serial_number": "123456",
        "firmware_revision": "123456",
        "hardware_revision": "123456",
        "icon": "floor-lamp"
    }],
    "types": ["light"],
    "characteristics": ["on"]
}
```

[Top](#home)

#### <a name="room.update"></a>Update
Updates a room, including device control like all off.

Request
```http
PUT /api/room/:id/:service
Body: application/json
```

Body
```json
{
    "value": true
}
```

You can also change the name, or sequence using this method.

[Top](#home)

#### <a name="room.remove"></a>Remove
Removes a room.

Request
```http
DELETE /api/room/:id
```

[Top](#home)

## <a name="themes"></a>Themes
Fetch a theme.

Request
```http
GET /api/theme/:name
```

Response
```json
{
    "name": "custom",
    "display": "Custom",
    "auto": false,
    "mode": "dark",
    "transparency": "blur(6px)",
    "application": {
        "text": {
            "default": "#999",
            "highlight": "#fff",
            "input": "#fff",
            "error": "#e30505",
        },
        "background": "#141414",
        "highlight": "#feb400",
        "accent": "#f5ff66",
        "dark": "#252525",
        "drawer": "#111111d2",
        "input": {
            "background": "#262626",
            "accent": "#444",
        },
        "border": "#252525",
    },
    "button": {
        "background": "#252525",
        "text": "#fff",
        "border": "#1a1a1a",
        "primary": {
            "background": "#feb400",
            "text": "#fff",
            "border": "#feb400",
        },
        "light": {
            "background": "#fff",
            "text": "#777",
            "border": "#e5e5e5",
        },
    },
    "modal": {
        "text": {
            "default": "#999",
            "input": "#fff",
            "error": "#e30505",
        },
        "background": "#111111d2",
        "dark": "#000",
        "form": "#11111100",
        "mask": "#14141400",
        "highlight": "#feb400",
        "input": "#262626",
        "accent": "#303030",
        "border": "#252525",
    },
    "widget": {
        "text": {
            "default": "#999",
        },
        "background": "#181818d2",
        "highlight": "#feb400",
        "border": "#252525",
    },
    "menu": {
        "text": {
            "default": "#b4b4b4",
            "highlight": "#fff",
        },
        "background": "#1111119d",
        "highlight": "#1d1d1d9d",
        "border": "#1d1d1d",
    },
    "navigation": {
        "text": {
            "default": "#999",
            "highlight": "#fff",
            "active": "#feb400",
        },
        "background": "#141414",
        "highlight": "#feb400",
        "border": "#4b4b4b",
    },
    accessory: {
        "text": "#ffffff3d",
        "background": "#302f2f",
        "highlight": "#fff",
        "input": "#414141",
        "border": "#444",
    },
    "backdrop": "url('/defaults/backdrops/default.jpg')",
    "elevation": {
        "default": "0 1px 1px 1px rgba(0, 0, 0, 0.44), 0 -3px 1px -1px ...",
        "button": "0 1px 1px 0 rgba(0, 0, 0, 0.44), 0 2px 1px -1px rgba...",
    },
}
```

[Top](#home)

#### <a name="themes.update"></a>Update
Update a custom theme.

Request
```http
POST /api/theme/:name
Body: application/json
```

This accepts a theme as defined above.

> The light and dark themes are built in and can not be changed.

[Top](#home)

#### <a name="themes.backdrop"></a>Backdrop
Upload a custom backdrop image.

Request
```http
POST /api/theme/:name
Body: multipart/binary
```

Response
```json
{
    "filename": "custom.jpeg"
}
```

[Top](#home)

## <a name="location"></a>Location
Searches for a location by text.

Request
```http
GET /api/weather/location?query=denver&count=10
```

Response
```json
[{
    "id": "123456",
    "name": "Denver",
    "country": "United States"
}]
```

[Top](#home)

## <a name="weather"></a>Weather
Fetches the current weather.

Request
```http
GET /api/weather/current
```

Response
```json
{
    "units": "celsius",
    "weather": 32,
    "description": "sunny",
    "icon": "sunny",
    "temp": 32,
    "min": 32,
    "max": 32,
    "windchill": 31,
    "pressure": 15,
    "humidity": 20,
    "visibility": 10,
    "wind": {
        "speed": 2,
        "direction": 270
    }
}
```

> Note. To get the current weather, you must first set the city id in the hub config.

[Top](#home)

#### <a name="weather.forecast"></a>Forecast
Fetches a weather forecast.

Request
```http
GET /api/weather/forecast
```

Response
```json
[{
    "units": "celsius",
    "weather": 32,
    "description": "sunny",
    "icon": "sunny",
    "temp": 32,
    "min": 32,
    "max": 32,
    "windchill": 31,
    "pressure": 15,
    "humidity": 20,
    "visibility": 10,
    "wind": {
        "speed": 2,
        "direction": 270
    }
}]
```

> Note. To get the weather forecast, you must first set the city id in the hub config.

[Top](#home)
