@interface PHBottomBarButton : UIView
@property (nonatomic, assign, readwrite) CGRect frame;
@end

@interface PHHandsetDialerDeleteButton : UIView
@property (nonatomic, assign, readwrite) CGRect frame;
@end



//Get Device Screen Width And Store As 'Width':

CGFloat width = [UIScreen mainScreen].bounds.size.width;

/*

Yes, I am aware that using layoutSubviews is bad.
I will soon switch to setFrame, however, I just wanted to release this update as soon as possible.

*/

//Move And Resize Call Button:

//Hook The Call Button.
%hook PHBottomBarButton
- (void) layoutSubviews {
    //Run Original Code.
    %orig;    
    //Modify The CGRect.
	CGRect newFrame = self.frame;
    newFrame.origin.x = (width*0.125);
    //Call Buttonn Takes Up 75% Of Screen Width.
	newFrame.size.width = (width*0.75);
	self.frame = newFrame;
}
%end



//Move Delete Button:

//Hook The Delete Button.
%hook PHHandsetDialerDeleteButton
- (void) layoutSubviews {
    //Runs Original Code.
	%orig;
    //Modify The CGRect.
	CGRect newFrame = self.frame; 
	newFrame.origin.x = (width*0.3925);
	newFrame.origin.y = (width*0.25);
	self.frame = newFrame;
}
%end
