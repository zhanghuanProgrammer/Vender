
/*
 POPNumberAnimationDelegate
 @property (nonatomic, strong)POPNumberAnimation *numberAnimation;

 
 - (void)initAnimation{
     self.numberAnimation          = [[POPNumberAnimation alloc] init];

     self.numberAnimation.delegate = self;

 }
 
 - (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(double)currentValue {
     NSString *numberString = [NSString stringWithFormat:@"%.0f", currentValue];

     self.countLabel.text = [ZHNSString countNumAndChangeformat:numberString];

 }
 
 - (void)startNumberAnimationFromValue:(double)fromValue toValue:(double)toValue{
 
     self.numberAnimation.fromValue      = fromValue;

     self.numberAnimation.toValue        = toValue;

     self.numberAnimation.duration       = 1.5f;

     self.numberAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];

     [self.numberAnimation saveValues];

     [self.numberAnimation startAnimation];

 }
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class POPNumberAnimation;

@protocol POPNumberAnimationDelegate <NSObject>

@required

/**
 *  When you run 'startAnimation' method, this delegate method will get current value for you in real time.
 *
 *  @param numberAnimation POPNumberAnimation object.
 *  @param currentValue    Current value in real time.
 */
- (void)POPNumberAnimation:(POPNumberAnimation *)numberAnimation currentValue:(double)currentValue;

@end

@interface POPNumberAnimation : NSObject

@property (nonatomic, weak) id <POPNumberAnimationDelegate>  delegate;

/**
 *  Animation's start value.
 */
@property (nonatomic)       double                          fromValue;

/**
 *  Animation's destination value.
 */
@property (nonatomic)       double                          toValue;

/**
 *  Current value.
 */
@property (nonatomic)       double                          currentValue;

/**
 *  Animation's duration, default value is 0.4s.
 */
@property (nonatomic)       NSTimeInterval                   duration;

/**
 *  Animation's timingFunction.
 */
@property (nonatomic, strong) CAMediaTimingFunction         *timingFunction;

/**
 *  When you have set all propeties, you must save values to make the config effect.
 */
- (void)saveValues;

/*
 *  Before you run this method, you should make sure save values to make the config effect.
 */
- (void)startAnimation;

/*
 *  Stop animation.
 */
- (void)stopAnimation;

@end
