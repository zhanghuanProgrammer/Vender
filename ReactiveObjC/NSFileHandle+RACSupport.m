
#import "NSFileHandle+RACSupport.h"
#import "NSNotificationCenter+RACSupport.h"
#import "NSObject+RACDescription.h"
#import "RACReplaySubject.h"
#import "RACDisposable.h"

@implementation NSFileHandle (RACSupport)

- (RACSignal *)rac_readInBackground {
	RACReplaySubject *subject = [RACReplaySubject subject];
	[subject setNameWithFormat:@"%@ -rac_readInBackground", RACDescription(self)];

	RACSignal *dataNotification = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NSFileHandleReadCompletionNotification object:self] map:^(NSNotification *note) {
		return note.userInfo[NSFileHandleNotificationDataItem];
	}];
	
	__block RACDisposable *subscription = [dataNotification subscribeNext:^(NSData *data) {
		if (data.length > 0) {
			[subject sendNext:data];
			[self readInBackgroundAndNotify];
		} else {
			[subject sendCompleted];
			[subscription dispose];
		}
	}];
	
	[self readInBackgroundAndNotify];
	
	return subject;
}

@end
