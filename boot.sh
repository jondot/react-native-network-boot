#!/bin/sh
rnhost=`ipconfig getifaddr en0`
plist=${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/../${INFOPLIST_PATH}

/usr/libexec/PlistBuddy -c "Add :RNHost string" $plist
echo Setting React Native RNHost variable to $rnhost
/usr/libexec/PlistBuddy -c "Set :RNHost ${rnhost}" $plist
echo Done.
