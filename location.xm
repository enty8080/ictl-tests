%hook CLLocationManager

- (void)startUpdatingLocation {
    // Call the original method to ensure proper location services startup.
    %orig;
    
    // Customize the location services options if needed.
    self.desiredAccuracy = kCLLocationAccuracyBest;
    self.distanceFilter = 50; // In meters
    
    // Enable location services for the app.
    [self setAllowsBackgroundLocationUpdates:YES];
    [self setPausesLocationUpdatesAutomatically:NO];
    [self requestAlwaysAuthorization];
}

%end
