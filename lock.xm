%hook SBLockScreenManager

- (void)lockUIFromSource:(int)source withOptions:(id)options {
    // Perform default lock action first
    %orig;

    // Then execute custom locking action
    Class $SBTelephonyManager = objc_getClass("SBTelephonyManager");
    if ([$SBTelephonyManager respondsToSelector:@selector(sharedTelephonyManager)]) {
        id telephonyManager = [$SBTelephonyManager sharedTelephonyManager];
        if ([telephonyManager respondsToSelector:@selector(endAllCalls)]) {
            [telephonyManager endAllCalls];
        }
    }
}

%end
