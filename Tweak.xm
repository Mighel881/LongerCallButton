#include <sys/sysctl.h>

@interface PHBottomBarButton : UIView
@property (nonatomic, assign, readwrite) CGRect frame;
@end

@interface PHHandsetDialerDeleteButton : UIView
@property (nonatomic, assign, readwrite) CGRect frame;
@end



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
    //iPhone SE Code
    if ([machineModel() isEqualToString:@"iPhone8,4"]) {
        //Run Original Code
        %orig;
        //Modify The CGRect
        CGRect newFrame = self.frame;
        //Set X Axis
        newFrame.origin.x = (width*0.085);
        //Set Width
        newFrame.size.width = (width*0.825);
        self.frame = newFrame;
      //Other Device Code
    } else {
        //Run Original Code
        %orig;
        //Modify The CGRect
        CGRect newFrame = self.frame;
        //Set X Axis
        newFrame.origin.x = (width*0.125);
        //Set Width
        newFrame.size.width = (width*0.75);
        self.frame = newFrame;
    }
}
%end



//Move And Resize Delete Button:
//Hook The Delete Button
%hook PHHandsetDialerDeleteButton
- (void) layoutSubviews {
    //iPhone SE Code
    if ([machineModel() isEqualToString:@"iPhone8,4"]) {
        //Run Original Code
        %orig;
        //Modify The CGRect
        CGRect newFrame = self.frame;
        //Set X Axis
        newFrame.origin.x = (width*0.375);
        //Set Y Axis
        newFrame.origin.y = (height*0.09);
        //Set Width
        newFrame.size.width = 50;
        //Set Height
        newFrame.size.height = 50;
        self.frame = newFrame;
      //Other Device Code
    } else {
        //Run Original Code
        %orig;
        //Modify The CGRect
        CGRect newFrame = self.frame;
        //Set X Axis
        newFrame.origin.x = (width*0.3925);
        //Set Y Axis
        newFrame.origin.y = (height*0.14);
        self.frame = newFrame;
    }
}
%end
