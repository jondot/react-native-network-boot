#!/bin/sh
# todo: improve this, some boxes has en5, en1, etc

# use ifconfig, remove loopack and virtualbox IPs
rnhost=`ifconfig | sed -En 's/127.0.0.1//;s/192.168.99.*//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | head -n1`
plist=${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/../${INFOPLIST_PATH}

case "$CONFIGURATION" in
  Debug)
    ;;
  "")
    echo "$0 must be invoked by Xcode"
    exit 1
    ;;
  *)
    echo "$0 will not work in release configurations - configure by hand"
    exit 0
    ;;
esac

echo Setting ATS exception for arbitrary loads
/usr/libexec/PlistBuddy -c "Delete :NSAppTransportSecurity" $plist &>/dev/null
/usr/libexec/PlistBuddy -c "Add :NSAppTransportSecurity:NSAllowsArbitraryLoads bool true" $plist

echo Setting React Native RNHost variable to $rnhost
/usr/libexec/PlistBuddy -c "Add :RNHost string" $plist
/usr/libexec/PlistBuddy -c "Set :RNHost ${rnhost}" $plist
echo Done.
