## Rename API to Hub & Server to Bridge

1. Rename hoobsd/src/api -> hoobsd/src/hub
2. Rename hoobsd/src/bridge/index.ts -> hoobsd/src/bridge/server.ts
3. Move files from hoobsd/src/bridge -> hoobsd/src/server
4. Rename hoobsd/src/server -> hoobsd/src/bridge
5. Rename State.bridge -> State.homebridge
6. Rename State.server -> State.bridge
7. Rename State.api -> State.hub

## Rename Variables

1. Rename methods and variables in cli to make more sense
2. Rename methods and variables in hoobsd to make more sense
3. Rename methods and variables in gui to make more sense

## GUI Plugins

1. Remove $identifier not needed
2. Combine $value and $update to a get and set on $value

## Plugind Site

1. Add ability to define plugin type as plugin or extention
2. Define extentions listed inline with bridge plugins
3. Develop developer interfaces

## Toolchain

1. Research jest for testing
2. Research vue end to end testing
3. Obtain 97% code coverage
4. Research grunt for building images
5. Move mixer os to it's own orginization on github
6. Update mixer os to the latest raspberry pi os builds
7. Update balina wifi connect software
8. Fork mixer os to hoobs project
9. Write stage scripts for hoobs install

## Extensions
1. Collaborate or re-develop GSH to work with multiple bridges and convert to a hub extension
1. Collaborate or re-develop Alexa to work with multiple bridges and convert to a hub extension
