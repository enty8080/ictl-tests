# `ictl` tests

Test code samples for ictl.

## `location.xm`

In this test, we are hooking into the CLLocationManager class and overriding the startUpdatingLocation method. We then call the original method using %orig to ensure that the location services start properly. After that, we customize the location services options by setting the desired accuracy and distance filter.

Finally, we enable location services for the app by calling setAllowsBackgroundLocationUpdates:YES, setPausesLocationUpdatesAutomatically:NO, and requestAlwaysAuthorization. This will allow the app to continue tracking the device's location even when it is in the background.

## `home.xm`

In this test, we are hooking into the SpringBoard class and creating a new method called simulateHomeButtonPress. When this method is called, we use the SBUIController class to send a "home button clicked" event to the SpringBoard, effectively simulating a press of the physical home button on the device. You can then call this method from your tweak to trigger the emulation of the home button press.

## `lock.xm`

In this test, we use the %hook and %end directives to hook into the SBLockScreenManager class, which is responsible for managing the lock screen behavior. Then, we override the lockUIFromSource:withOptions: method using %orig and execute the default locking action.

After that, we perform a custom locking action by obtaining the SBTelephonyManager class using objc_getClass and checking if it responds to the sharedTelephonyManager and endAllCalls methods. If so, we call the endAllCalls method to end all active calls before locking the iPhone.

## `photo.m`

Just capture a photo from front camera of iPhone.
