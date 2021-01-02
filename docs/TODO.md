# Todo
A list of items identified as neededing to be compleated.

## Rename API to Hub & Server to Bridge

1. rename hoobsd/src/api -> hoobsd/src/hub
2. rename hoobsd/src/bridge/index.ts -> hoobsd/src/bridge/server.ts
3. move files from hoobsd/src/bridge -> hoobsd/src/server
4. rename hoobsd/src/server -> hoobsd/src/bridge
5. rename State.bridge -> State.homebridge
6. rename State.server -> State.bridge
7. rename State.api -> State.hub

## Rename Variables

1. rename methods and variables in cli to make more sense
2. rename methods and variables in hoobsd to make more sense
3. rename methods and variables in gui to make more sense

## GUI Plugins

1. remove $identifier not needed
2. combine $value and $update to a get and set on $value

## Plugind Site

1. add ability to define plugin type as plugin or extention
2. define extentions listed inline with bridge plugins
3. develop developer interfaces

## Toolchain

1. research jest for testing
2. research vue end to end testing
3. obtain 97% code coverage
4. research grunt for building images
5. move mixer os to it's own orginization on github
6. update mixer os to the latest raspberry pi os builds
7. update balina wifi connect software
8. fork mixer os to hoobs project
9. write stage scripts for hoobs install
