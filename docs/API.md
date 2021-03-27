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
- [Version](#version)
- [Service Information](#status)
- [System](#system)
    - [Hostname](#system.host)
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

## <a name="status"></a>Service Information
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

#### <a name="system.host"></a>Hostname
Fetch or set the current mDNS broadcast hostname.

Fetch Request
```http
GET /api/system/hostname
```

Fetch Response
```json
{
    "hostname": "hoobs"
}
```

Set Request
```http
POST /api/system/hostname
Body: application/json
```

Set Body
```json
{
    "hostname": "hoobs-second"
}
```

Set Response
```json
{
    "success": true
}
```

[Top](#home)

#### <a name="system.cpu"></a>CPU
Fetch CPU information.

Request
```http
GET /api/system/cpu
```

Set Response
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

Set Response
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

Set Response
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

Set Response
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

Set Response
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

Set Response
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
    success: true,
    filename: "hoobs.backup",
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