
#import "UIFont+FontAdapter.h"
#import <objc/runtime.h>

@implementation UIView (ConstraintAdapter)

@end

@implementation UIFont (FontAdapter)

+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method mOriginal = class_getClassMethod(UIFont.class, @selector(systemFontOfSize:));
        Method mMine = class_getClassMethod(UIFont.class, @selector(m_systemFontOfSize:));
        method_exchangeImplementations(mOriginal, mMine);

        mOriginal = class_getClassMethod(UIFont.class, @selector(boldSystemFontOfSize:));
        mMine = class_getClassMethod(UIFont.class, @selector(m_boldSystemFontOfSize:));
        method_exchangeImplementations(mOriginal, mMine);
        
        mOriginal = class_getClassMethod(UIFont.class, @selector(italicSystemFontOfSize:));
        mMine = class_getClassMethod(UIFont.class, @selector(m_italicSystemFontOfSize:));
        method_exchangeImplementations(mOriginal, mMine);
        
        mOriginal = class_getClassMethod(UIFont.class, @selector(fontWithName:size:));
        mMine = class_getClassMethod(UIFont.class, @selector(m_fontWithName:size:));
        method_exchangeImplementations(mOriginal, mMine);
        
    });
}

+ (UIFont *)m_systemFontOfSize:(CGFloat)fontSize{
    return [self m_systemFontOfSize:fontSize * (CurrentScreen_Width/375.0)];
}

+ (UIFont *)m_boldSystemFontOfSize:(CGFloat)fontSize{
    return [self m_boldSystemFontOfSize:fontSize * (CurrentScreen_Width/375.0)];
}

+ (UIFont *)m_italicSystemFontOfSize:(CGFloat)fontSize{
    return [self m_italicSystemFontOfSize:fontSize * (CurrentScreen_Width/375.0)];
}

+ (UIFont *)m_fontWithName:(NSString *)name size:(CGFloat)size{
    return [self m_fontWithName:name size:size * (CurrentScreen_Width/375.0)];
}

@end

@implementation UILabel (Fit)

+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
        Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
        method_exchangeImplementations(imp, myImp);
    });
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        if(self.tag != 999){
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont fontWithName:self.font.fontName size:fontSize];
        }
    }
    return self;
}

@end

@implementation UIButton (Fit)

+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
        Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
        method_exchangeImplementations(imp, myImp);
    });
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        if(self.tag != 999){
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:fontSize];
        }
    }
    return self;
}

@end

@implementation UITextField (Fit)

+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
        Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
        method_exchangeImplementations(imp, myImp);
    });
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        if(self.tag != 999){
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont fontWithName:self.font.fontName size:fontSize];
        }
    }
    return self;
}

@end

@implementation UITextView (Fit)

+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
        Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
        method_exchangeImplementations(imp, myImp);
    });
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        if(self.tag != 999){
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont fontWithName:self.font.fontName size:fontSize];
        }
    }
    return self;
}

@end
