# `ictl` tests

Test code samples for ictl.

## `lock.xm`

In this test, we use the %hook and %end directives to hook into the SBLockScreenManager class, which is responsible for managing the lock screen behavior. Then, we override the lockUIFromSource:withOptions: method using %orig and execute the default locking action.

After that, we perform a custom locking action by obtaining the SBTelephonyManager class using objc_getClass and checking if it responds to the sharedTelephonyManager and endAllCalls methods. If so, we call the endAllCalls method to end all active calls before locking the iPhone.

## `photo.m`

Just capture a photo from front camera of iPhone.
