#import <Foundation/Foundation.h>

@interface SBMediaController : NSObject
+ (instancetype)sharedInstance;

- (BOOL)isPlaying;
@end

%hook SBNCSoundController
- (BOOL)canPlaySoundForNotificationRequest:(id)request {
	BOOL shouldSilent = [[%c(SBMediaController) sharedInstance] isPlaying];

	return shouldSilent ? NO : %orig;
}
%end
