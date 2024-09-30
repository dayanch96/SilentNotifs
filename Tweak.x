#import <Foundation/Foundation.h>

@interface NCNotificationRequest : NSObject
@property (nonatomic, copy, readonly) NSString *sectionIdentifier;
@end

@interface SBMediaController : NSObject
+ (instancetype)sharedInstance;

- (BOOL)isPlaying;
@end

%hook SBNCSoundController
- (BOOL)canPlaySoundForNotificationRequest:(NCNotificationRequest *)request {
	if ([request.sectionIdentifier isEqualToString:@"com.apple.mobiletimer"]) {
		return %orig; //Ignore silencing for alarms
	}

	BOOL shouldSilent = [[%c(SBMediaController) sharedInstance] isPlaying];

	return shouldSilent ? NO : %orig;
}
%end
