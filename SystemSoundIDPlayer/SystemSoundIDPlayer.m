
#import "SystemSoundIDPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface SystemSoundIDPlayer ()
@property (nonatomic, assign) SystemSoundID soundID;
@property (nonatomic, copy) NSString* playName;
@end

@implementation SystemSoundIDPlayer

singleton_implementation(SystemSoundIDPlayer)

- (void)vibrate{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)playName:(NSString*)name{
    if (self.soundID != 0 && [name isEqualToString:self.playName])
        AudioServicesPlaySystemSound(self.soundID);
    else {
        SystemSoundID soundID;
        CFURLRef url = (__bridge CFURLRef)[[NSBundle mainBundle] URLForResource:name withExtension:nil];
        AudioServicesCreateSystemSoundID(url, &soundID);
        self.soundID = soundID;
        self.playName = name;
        AudioServicesPlaySystemSound(soundID);
    }
}

@end

