%hook SpringBoard

- (void)simulateHomeButtonPress {
    // Simulate a home button press by sending the home button event to the SpringBoard.
    [[objc_getClass("SBUIController") sharedInstance] clickedHomeButton];
}

%end
