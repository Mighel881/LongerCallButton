#include <sys/sysctl.h>

@interface PHBottomBarButton : UIView
@property (nonatomic, copy) UIView *overlayView;
@end

@interface PHHandsetDialerDeleteButton : UIView
@end

@interface BSPlatform : NSObject
+(id)sharedInstance;
-(long long)homeButtonType;
@end

bool isX;

//Get Device Model Number
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



//Get Device Screen Width And Store As 'width'
CGFloat width = [UIScreen mainScreen].bounds.size.width;



//Get Device Screen Width And Store As 'height'
CGFloat height = [UIScreen mainScreen].bounds.size.height;

/*

Yes, I know that using layoutSubviews is bad.
I will soon switch to setFrame, however, I just wanted to release this update as soon as possible.

*/



//Move And Resize Call Button:
//Hook The Call Button
%hook PHBottomBarButton
- (void) layoutSubviews {
    //Run original Code
    %orig;
    CGRect newFrame = self.frame;
    //iPhone SE Code
    if ([machineModel() isEqualToString:@"iPhone8,4"]) {
        //Modify The CGRect
        //Set X Axis
        newFrame.origin.x = (width*0.085);
        //Set Width
        newFrame.size.width = (width*0.825);
        self.frame = newFrame;
      //Other Device Code
    } else {
        //Modify The CGRect
        //Set X Axis
        newFrame.origin.x = (width*0.125);
        //Set Width
        newFrame.size.width = (width*0.75);
    }
    self.frame = newFrame;
    //Set button press overlay corner radius
    self.overlayView.layer.cornerRadius = self.layer.cornerRadius;
}
%end



//Move And Resize Delete Button:
//Hook The Delete Button
%hook PHHandsetDialerDeleteButton
- (void) layoutSubviews {
    //Run original code
    %orig;
    CGRect newFrame = self.frame;
    //iPhone SE Code
    if ([machineModel() isEqualToString:@"iPhone8,4"]) {
        //Modify The CGRect
        //Set X Axis
        newFrame.origin.x = (width*0.375);
        //Set Y Axis
        newFrame.origin.y = (height*0.09);
        //Set Width
        newFrame.size.width = 50;
        //Set Height
        newFrame.size.height = 50;
        //iPhone X(S/R) Code
    } else if(isX) {
        newFrame.origin.x = (width*0.3925);
        //Set Y Axis
        newFrame.origin.y = (height*0.23);
        //Other Device Code
    } else {
        //Modify The CGRect
        //Set X Axis
        newFrame.origin.x = (width*0.3925);
        //Set Y Axis
        newFrame.origin.y = (height*0.14);
    }
    self.frame = newFrame;
}
%end

%ctor{
	if([[%c(BSPlatform) sharedInstance] homeButtonType] == 2)
		isX = true;
	else
		isX = false;
}
