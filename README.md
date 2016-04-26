# Network Boot

If you are tired of manually setting your host IP, moving between networks, or sharing the network bootstrapping code in a team (that's in `AppDelegate.m`), this library takes a different and more flexible approach:

* Store current host in `Info.plist` at app packaging time (out of your source tree)
* Provide a Run Script that keeps this value up to date on each build
* Provide an example network bootstrapping code (see below) to use the value from your `Info.plist` instead of the hard coded one.

To start, run:

```
$ npm i react-native-network-boot -D
```


### Integration

In `AppDelegate.m`, replace the old host loading code with this:

```objective-c
  NSString *host = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RNHost"];
  jsCodeLocation = [NSURL URLWithString: [NSString stringWithFormat:@"http://%@:8081/index.ios.bundle?platform=ios&dev=true", host]];
```

Run the initializer that automatically adds a Run Script phase, in your React Native project folder:

```
$ rnnb ios
```

Or add a Run Script phase manually, with this script as its content:

```
../node_modules/react-native-network-boot/boot.sh
```


