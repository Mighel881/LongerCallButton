#include <sys/sysctl.h>

@interface PHBottomBarButton : UIView
@property (nonatomic, copy) UIView *overlayView;
@end

@interface PHHandsetDialerDeleteButton : UIView
@end

@interface UIButtonLabel : UIView
@end

@interface BSPlatform : NSObject
+(id)sharedInstance;
-(long long)homeButtonType;
@end

bool isX;

// Get Device Model Number
static NSString * machineModel() {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        void *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:(const char *)machine];
        free(machine);
    });
    return model;
}



// Get Device Screen Width And Store As 'width'
CGFloat width = [UIScreen mainScreen].bounds.size.width;



// Get Device Screen Width And Store As 'height'
CGFloat height = [UIScreen mainScreen].bounds.size.height;



// Move 'Add Number' Button On iPhone SE:
// Hook The Button
%hook UIButtonLabel
- (void) layoutSubviews {
    // Run original Code
	%orig;
    CGRect newFrame = self.frame;
    // Check If The Device Is An iPhone SE
    if ([machineModel() isEqualToString:@"iPhone8,4"]) {
        // Modify The CGRect
        // Set Y Axis
        newFrame.origin.y = (height*0.041175);
        self.frame = newFrame;
    } else {
    	// Run The Original Code With No Changes If The Device Is Not An iPhone SE
    	%orig;
    }
}
%end



// Move And Resize Call Button:
// Hook The Call Button
%hook PHBottomBarButton
- (void) layoutSubviews {
    // Run original Code
    %orig;
    CGRect newFrame = self.frame;
    // iPhone SE Code
    if ([machineModel() isEqualToString:@"iPhone8,4"]) {
        // Modify The CGRect
        // Set X Axis
        newFrame.origin.x = (width*0.085);
        // Set Width
        newFrame.size.width = (width*0.825);
        self.frame = newFrame;
    // Other Device Code
    } else {
        // Modify The CGRect
        // Set X Axis
        newFrame.origin.x = (width*0.125);
        // Set Width
        newFrame.size.width = (width*0.75);
    }
    self.frame = newFrame;
    // Set Button Press Overlay Corner Radius
    self.overlayView.layer.cornerRadius = self.layer.cornerRadius;
}
%end



// Move And Resize Delete Button:
// Hook The Delete Button
%hook PHHandsetDialerDeleteButton
- (void) layoutSubviews {
    // Run original code
    %orig;
    CGRect newFrame = self.frame;
    // iPhone SE Code
    if ([machineModel() isEqualToString:@"iPhone8,4"]) {
        // Modify The CGRect
        // Set X Axis
        newFrame.origin.x = (width*0.375);
        // Set Y Axis
        newFrame.origin.y = (height*0.0575);
    // iPhone X(S/R) Code
    } else if(isX) {
        newFrame.origin.x = (width*0.3925);
        // Set Y Axis
        newFrame.origin.y = (height*0.23);
        // Other Device Code
    } else {
        // Modify The CGRect
        // Set X Axis
        newFrame.origin.x = (width*0.3925);
        // Set Y Axis
        newFrame.origin.y = (height*0.14);
    }
    self.frame = newFrame;
}
%end

%ctor{
	// Check For iPhone X
	if([machineModel() isEqualToString:@"iPhone10,3"])
		isX = true;
	// Check For iPhone X
	else if([machineModel() isEqualToString:@"iPhone10,6"])
		isX = true;
	// Check For iPhone XR
	else if([machineModel() isEqualToString:@"iPhone11,8"])
		isX = true;
	// Check For iPhone XS
	else if([machineModel() isEqualToString:@"iPhone11,2"])
		isX = true;
	// Check For iPhone XS Max
	else if([machineModel() isEqualToString:@"iPhone11,6"])
		isX = true;
	// Check For iPhone XS Max
	else if([machineModel() isEqualToString:@"iPhone11,4"])
		isX = true;
	// All Other Devices
	else
		isX = false;
}