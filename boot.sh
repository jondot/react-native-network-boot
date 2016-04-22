#!/bin/sh
# todo: improve this, some boxes has en5, en1, etc

# use ifconfig, remove loopack and virtualbox IPs
rnhost=`ifconfig | sed -En 's/127.0.0.1//;s/192.168.99.*//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'`
plist=${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/../${INFOPLIST_PATH}

/usr/libexec/PlistBuddy -c "Add :RNHost string" $plist
echo Setting React Native RNHost variable to $rnhost
/usr/libexec/PlistBuddy -c "Set :RNHost ${rnhost}" $plist
echo Done.
