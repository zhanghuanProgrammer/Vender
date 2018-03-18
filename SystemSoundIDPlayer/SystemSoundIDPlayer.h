
#import <Foundation/Foundation.h>

@interface SystemSoundIDPlayer : NSObject

singleton_interface(SystemSoundIDPlayer)

- (void)vibrate;

- (void)playName:(NSString *)name;

@end
