[comment]: <> (image from hoobs-image repo)

![](https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_google.svg)

[comment]: <> (Plugin Title)
# Google Smart Home plugin for HOOBS
[comment]: <> (Short Plugin Description)
Control your supported HOOBS accessories from any Google Home speaker or the Google Home mobile app. 

[comment]: <> (List of the Main Features, that can be set in config schema)
### Features
- Switch
- Outlet
- Light Bulb
    On / Off
    Brightness
    Color (Hue/Saturation)
- Fan (On / Off)
- Fan v2 (On / Off)
- Window
- Window Coverings
- Door
- Garage Door
- Thermostat
- Television (On / Off)
- Lock Mechanism (2FA required)
- Security System (2FA required)

Note: Google Smart Home does not currently support "sensor" devices such as Temperature Sensors, Motion Sensors, Occupancy Sensors etc.

[comment]: <> (configuration)
### Configuration
All Configuration can be done in the confguration section. No advanced or furhter config editing needed

**Configuration in HOOBS**
Navigate to the Plugins page in HOOBS.
Click the Configuration button for the Google Smart Home plugin.
Click the Link Account button.
Sign in with your Google or GitHub account.
Your account is now linked.
Add the Homebridge Action using the Google Home mobile app.

**Configuration in Google Home mobile app**

<img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_google_app.png" width="30%"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_google_app2.png" width="30%"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_google_app3.png" width="30%"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_google_app4.png" width="30%"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_google_app5.png" width="30%">


[comment]: <> (Credit the Pluginauthor and link to npm package)
### Credits
Plugin for Homebridge [homebridge-gsh](https://www.npmjs.com/package/homebridge-gsh)

Copyright © oznu. All rights reserved.



---


[comment]: <> (image from hoobs-image repo)

![](https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_landroid.svg)

[comment]: <> (Plugin Title)
# Worx Landroid Lawnmover plugin for HOOBS
[comment]: <> (Short Plugin Description)
This plugin exposes [Landroid Lawnmovers](https://www.worx.com/landroid-choose-landroid) to HOOBS.
Control your Worx Landroid lawn mowers through the Worx Cloud.

[comment]: <> (List of the Main Features, that can be set in config schema)
### Features
- Start mower
- Return mower to home
- Mowing status (on / off)
- Battery Status
- Error status

The mower will appear as a switch and a contact sensor in HOOBBS.

**On/Off Switch**
The switch shows the current status and allows to control the mower. If the switch is off the mower is either on the home base or on its way to the home base. If it's on the mower is currently mowing. Turn the switch on to start the mowing cycle, turn it off to send the mower back home.

**Contact Sensor**
The contact sensor is used to display issues with the mower (trapped, outside wire etc.), when the contact sensor is "open" there is some issue that prevents the mower from continuing. Fix the issue to control the mower again.

**Battery Status**
You can see the battery status of your lawn mower in the settings of either the switch or contact sensor 

[comment]: <> (List of working Hardware Types and Modelnumbers)
### Working Hardware

- Worx Landroid S WR130E 300 m²
- Worx Landroid M WR141E 500 m²
- Worx Landroid M WR142E 700 m²
- Worx Landroid M WR143E 1.000 m²
- Worx Landroid L WR153E 1.500 m²
- Worx Landroid L WR155E 2.000 m²

<img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_landroid_products.png" width="15%"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_landroid_products2.png" width="15%"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_landroid_products3.png" width="15%"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_landroid_products4.png" width="15%"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_landroid_products5.png" width="15%">

[comment]: <> (configuration)
### Configuration
All Configuration can be done in the confguration section. No advanced or furhter config editing needed

- Fill in Email and Password from your Worx App account data
- Fill in your Lawnmowers name into "devname", do not use spaces in the name..

Configured Mowers
```
[
{
"name": "My Landroid",
"dev_name": "S"
}
]
```

[comment]: <> (Credit the Pluginauthor and link to npm package)
### Credits
Plugin for Homebridge [homebridge-landroid](https://www.npmjs.com/package/homebridge-landroid)

Copyright © normen. All rights reserved.


---

[comment]: <> (image from hoobs-image repo)

![](https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_sonos.svg)

[comment]: <> (Plugin Title)
# Sonos Zoneplayer plugin for HOOBS
[comment]: <> (Short Plugin Description)
This plugin exposes [Sonos](http://www.sonos.com) ZonePlayers to HOOBS.

[comment]: <> (List of the Main Features, that can be set in config schema)
### Features
- Automatic discovery of Sonos zones, taking into account stereo pairs and home theatre setup;
- Support for Sonos groups, created through the Sonos app;
- Control of play/pause, sleep timer, next/previous track, volume, and mute per Sonos group;
- Control of input selection per group, from Sonos favourites and local sources, like LineIn, Airplay;
- Optional control of volume, mute, balance, bass, treble, loudness, night sound, and speech enhancement per Sonos zone;
- Optional control for Sonos zones leaving Sonos groups, and for Sonos zones creating/joining one Sonos group;
- Optional control to enable/disable Sonos alarms;
- Real-time monitoring of state per Sonos group and, optionally, per Sonos zone.
- Optional control for the status LED and child lock per ZonePlayer.

[comment]: <> (List of working Hardware Types and Modelnumbers)
### Working Hardware

- SONOS Play:1
- SONOS One
- SONOS One SL
- SONOS Play:5
- SONOS Sub
- SONOS Beam
- SONOS Playbar
- SONOS Playbase
- SONOS Port
- SONOS Amp

<img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_sonos_products.png" width="250"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_sonos_products2.png" width="250"> <img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_sonos_products3.png" width="250">

[comment]: <> (configuration)
### Configuration
All Configuration can be done in the confguration section. No advanced or furhter config editing needed

[comment]: <> (Credit the Pluginauthor and link to npm package)
### Credits
Plugin for Homebridge [homebridge-sonos-zp](https://www.npmjs.com/package/homebridge-zp)

Copyright © 2016-2020 Erik Baauw. All rights reserved.

---

[comment]: <> (image from hoobs-image repo)




![](https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_shelly.svg)




[comment]: <> (Plugin Title)
# Shelly plugin for HOOBS
[comment]: <> (Short Plugin Description)
This plugin exposes [Shelly](http://www.shelly.cloud) Devices to HOOBS.




[comment]: <> (List of the Main Features, that can be set in config schema)
### Features
Your Shelly devices will then be automatically discovered, as long as they are on the same network and subnet as the device running homebridge.



[comment]: <> (List of working Hardware Types and Modelnumbers)
### Working Hardware

Currently the following devices are supported:

- Shelly 1
- Shelly 1PM
- Shelly 2 *1
- Shelly 2.5 *1
- Shelly 4Pro
- Shelly Bulb *2
- Shelly Dimmer
- Shelly Door/Window
- Shelly EM
- Shelly Flood
- Shelly HD
- Shelly H&T
- Shelly Plug
- Shelly Plug S
- Shelly RGBW2
- Shelly Sense

*1 To use Shelly 2 or Shelly 2.5 in roller shutter mode the device must have been calibrated and be running firmware version 1.4.9 or later.
*2 Requires firmware version 1.5.1 or later.




<img src="https://github.com/hoobs-org/hoobs-images/blob/master/HOOBS_x_shelly_products.jpg">



[comment]: <> (configuration)
### Configuration
All Configuration can be done in the confguration section.

**Administration interface**
By default, this plugin will launch an HTTP server on port 8181 to serve an administration interface. 
You can disable this by setting "admin"."enabled" to false. 
You can also change the port number using "admin"."port"

**Device specific configurations**
Configurations for specific Shelly devices can be set using the "devices" array. Each object in the array must contain an "id" property with the ID of the Shelly device that you want to target. IDs are always made up of 6 hexadecimal characters and can be found in the Shelly Cloud app or the web interface of a device, under Settings -> Device info -> Device ID.

**General configurations**
"exclude" - set to true to exclude the device from Homebridge.
"username" and "password" - set these if you have restricted the web interface of the device with 
a username and password. This will override the global "username" and "password" options.
"name" - sets a custom name for the device.

**Shelly switch configurations**
Applies to Shelly 1, 1PM, 2 and 2.5 in relay mode, 4Pro, EM, Plug and Plug S.

"type" - sets the type of accessory the device is identified as. 
Available types are "contactSensor", "motionSensor", "occupancySensor", "outlet", 
"switch" (default) and "valve".

**Shelly 2.5 configurations**
"type" - in roller mode, the device can be identified as either "door", "garageDoorOpener", 
"window" or "windowCovering" (default).

**Shelly RGBW2 configurations**
"colorMode" - set to "rgbw" (default) to have HomeKit control all four channels of the device (R, G, B, and W), 
or to "rgb" to omit the W channel.

**Advanced config example**
Devices:
```
[
{ "id": "74B5A3", "exclude": true },
{ "id": "6A78BB", "colorMode": "rgb" },
{ "id": "1D56AF", "type": "outlet" }
]
```


[comment]: <> (Credit the Pluginauthor and link to npm package)
### Credits
Plugin for Homebridge [homebridge-shelly](https://www.npmjs.com/package/homebridge-shelly)

Copyright © Alexrd. All rights reserved.
