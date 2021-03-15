# HOOBS 4
Changes for the HOOBS 4 line.

> HOOBS 4 is currently in private beta. If you want access to the beta please create an issue.

## 4.0.9 (Beta)
* Bug fixes
* Introducing HelM, access the terminal even when the HOOBSD service is not starting.
* Added development bridge type

## 4.0.4 (Beta)
* Bug fixes
* Moved to APT package manager

## 4.0.1 (Beta)
* Redesigned the log transmission
* Redesigned the bridge interface
* Redesigned bridges
* New CLI, with plugin install, config editor and bridge control
* Dynamic configuration, no more restarting
* Dynamic plugin install, no more restarting
* Unlimited bridges controlled from one API
* New storage and configuration structure
* Stable IPC and Web sockets
* GUI decoupled from API with support for 3rd party GUIs
* New system wide feature control, FFMPEG, GUI, Touchscreen...
* Able to disable authentication
* Combined logs from multiple bridges

# HOOBS 3
Changes for the HOOBS 3 line.

## 3.3.5
* Fixed an issue that was causing accessory cache corruption. If you upgraded to 3.3.4, you will need to clear the accessory cache.

## 3.3.4
* Bug fixes
* Upgraded Homebridge to 1.3.3

## 3.3.3
* Bug fixes
* Upgraded Homebridge to 1.3.1

## 3.3.2
* Bug fixes
* Upgraded Homebridge to 1.1.7

## 3.3.1
* Node LTS (14.15.1)
* Alpine 3.12.1 (Docker Version)

## 3.2.10
* Bug Fixes
* Fixed issue with CPU temp and Homemanager app

## 3.2.9
* Bug Fixes
* Removed Inaccurate CPU Temp sensors
* Fixed many issues with plugins loading

## 3.2.8
* Bug Fixes
* Updated HAP
* Updated Bridge Core
* Better Plugin Support
* Bridge Plugin Load from Package File
* Updated Node to 12.19.0

## 3.2.7
* Bug Fixes
* Updated HAP
* Updated Bridge Core
* Better Plugin Support
* Updated Node to 12.19.0

## 3.2.6
* Bug Fixes
* Updated HAP
* Updated Node to 12.16.3

## 3.2.4
* Bug Fixes
* Removed NGINX
* Faster Load Times
* Updated HAP Core
* Cleaned Bridge Code
* Support For Short Form UUIDS
* Support Plugins for Latest HB Version
* Support Identifier less Plugin Registration
* Allow Non HOOBS Scoped Certified Plugins

## 3.1.27
* Bug fixes
* Updated HAP core
* New Raspbian source
* Updated to Node 12.16.2
* Lightened the User Mode
* Added Shutdown Function
* Socket Based Plugin Install
* Socket Based Backup and Restore
* Accessory Performance Optimizations
* Support for Plugins that Access HAP Directly
* 
## 3.1.20
* Auto close notifications
* Added support for Docker containers
* Single image for Docker on multiple architectures

## 3.1.19
* Bug Fixes
* Added push notifications
* API supports installing specific plugin versions

## 3.1.17
* Bug Fixes
* New cluster instance commands
* Multi device clustering
* Smarter reboot and update actions
* Install script can handle different Node versions
* Accessory updates are now pushed to the client

## 3.1.15
* Bug Fixes
* Made the migration process more fault tolerant
* Change the plugin log logic, it's more fault tolerant
* Added HOOBS to Homebridge switch script
* Added a Homebridge removal script
* Combined Binaries into One File
* Added Service Control Commands
* Fix NPM Issues Automatically
* Faster Installed Plugin List
* Faster Plugin Type Detection
* Initialize Without Rebooting
* Upgrade Without Rebooting

## 3.1.14
* Bug Fixes

## 3.1.12
* Bug Fixes
* Added Node version to System screen
* Fixed plugin type detection

## 3.1.10
* Bug Fixes
* Fixed an Issue With Ports Saving
* Fixed an Issue Where the Config Didn't Reload After Saving
* We Can Now Fix NGINX Config Errors on Upgrade

## 3.1.9
* Bug Fixes
* Fixed an Issue With Ports Saving
* Fixed an Issue Where the Config Didn't Reload After Saving
* We Can Now Fix NGINX Config Errors on Upgrade

## 3.1.8
* Bug Fixes

## 3.1.7
* Bug Fixes
* Fixed an Issue Where Some Fields Were not Showing for Plugin Configs
* Passing the Enviornment into the Terminal
* Fixed NGINX Caching Issue

## 3.1.6
* Bug Fixes
* Show Upgrade Available on Dashboard
* Added "What's New" for updates

## 3.1.5
* Bug Fixes

## 3.1.4
* Bug Fixes
* Select Field Type Casting
* Remove Empty Config Values

## 3.1.3
* Bug Fixes

## 3.1.2
* Bug Fixes
* Defaulting Node to 10.17.0
* Plugin Type Detection Logic

## 3.1.1
* New User Interface
* New API for Homebridge
* User Mode
* Scoped Plugins
* Accessory Controls
* System Backup Including Plugins
* System Restore with Plugins
* Factory Reset
* Homebridge Autostart Delay
