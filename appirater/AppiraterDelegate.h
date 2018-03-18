
#import <Foundation/Foundation.h>

@class Appirater;

@protocol AppiraterDelegate <NSObject>

@optional
-(BOOL)appiraterShouldDisplayAlert:(Appirater *)appirater;

-(void)appiraterDidDisplayAlert:(Appirater *)appirater;

-(void)appiraterDidDeclineToRate:(Appirater *)appirater;

-(void)appiraterDidOptToRate:(Appirater *)appirater;

-(void)appiraterDidOptToRemindLater:(Appirater *)appirater;

-(void)appiraterWillPresentModalView:(Appirater *)appirater animated:(BOOL)animated;

-(void)appiraterDidDismissModalView:(Appirater *)appirater animated:(BOOL)animated;

@end
