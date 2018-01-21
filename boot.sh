#!/bin/sh

# see if ngrok is active and pointing to :8081
ngrok_is_on=`curl -s http://127.0.0.1:4040/api/tunnels | jq '.tunnels | .[] | select(.proto == "http") | .config.addr == "localhost:8081"'`

if [ "$ngrok_is_on" == "true" ]
then
    # get ngrok address, set port to 80 (ngrok.io will not accept requests at :8081)
    rnhost=`curl -s http://127.0.0.1:4040/api/tunnels | jq -r '.tunnels | .[] | select(.proto == "http") | .public_url' | sed -e 's/^http:\/\///g'`
    rnport=80
else
    # todo: improve this, some boxes has en5, en1, etc
    # use ifconfig, remove loopback and virtualbox IPs, set port to 8081
    rnhost=`ifconfig | sed -En 's/127.0.0.1//;s/192.168.99.*//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | head -n1`
    rnport=8081
fi

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

echo Setting React Native RNPort variable to $rnport
/usr/libexec/PlistBuddy -c "Add :RNPort string" $plist
/usr/libexec/PlistBuddy -c "Set :RNPort ${rnport}" $plist
echo Done.

