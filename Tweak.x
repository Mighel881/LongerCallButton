@interface PHBottomBarButton : UIView
@property (nonatomic, assign, readwrite) CGRect frame;
@end

@interface PHHandsetDialerDeleteButton : UIView
@property (nonatomic, assign, readwrite) CGRect frame;
@end



//Resize And Move Call Button

%hook PHBottomBarButton
- (void) layoutSubviews {
	%orig;
	CGRect newFrame = self.frame; 
	newFrame.origin.x = 48.5;
	newFrame.origin.y = 517.5;
	newFrame.size.width = 280; 
	newFrame.size.height = 72;
	self.frame = newFrame;
}
%end



//Move Delete Button

%hook PHHandsetDialerDeleteButton
- (void) layoutSubviews {
	%orig;
	CGRect newFrame = self.frame; 
	newFrame.origin.x = 148;
	newFrame.origin.y = 95;
	newFrame.size.width = 75; 
	newFrame.size.height = 75;
	self.frame = newFrame;
}
%end
