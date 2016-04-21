# Network Boot




### Integration

In `AppDelegate.m`, replace the old host loading code with this:

```objective-c
  NSString *host = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RNHost"];
  jsCodeLocation = [NSURL URLWithString: [NSString stringWithFormat:@"http://%@:8081/index.ios.bundle?platform=ios&dev=true", host]];
```

Add a 'Run Script' build phase:

```
../node_modules/react-native-network-boot/boot.sh
```


