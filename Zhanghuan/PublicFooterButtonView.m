#import "PublicFooterButtonView.h"

@interface PublicFooterButtonView ()

@end

@implementation PublicFooterButtonView

- (UIButton *)button{
    if (!_button) {
        _button=[[UIButton alloc] initWithFrame:CGRectMake(25, (self.height-44)/2.0, self.width-50,44)];
        _button.layer.cornerRadius=3;
        _button.layer.masksToBounds=YES;
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button setTitleColor:RGBA(68, 68, 68, 1) forState:UIControlStateNormal];
        [self  addSubview:_button];
    }
    return _button;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton=[[UIButton alloc] initWithFrame:CGRectMake(25, (self.height-44)/2.0, (self.width-50-20)/2.0,44)];
        _leftButton.layer.cornerRadius=3;
        _leftButton.layer.masksToBounds=YES;
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_leftButton setTitleColor:RGBA(68, 68, 68, 1) forState:UIControlStateNormal];
        [self  addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton=[[UIButton alloc] initWithFrame:CGRectMake(self.width/2.0+10, (self.height-44)/2.0, (self.width-50-20)/2.0,44)];
        _rightButton.layer.cornerRadius=3;
        _rightButton.layer.masksToBounds=YES;
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitleColor:RGBA(68, 68, 68, 1) forState:UIControlStateNormal];
        [self  addSubview:_rightButton];
    }
    return _rightButton;
}


- (instancetype)publicFooterOneButtonViewWithFrame:(CGRect)frame withTitle:(NSString *)title withTarget:(id)target withSelector:(SEL)action{
    self.frame=frame;
    [self.button setTitle:title forState:UIControlStateNormal];
    if (target&&action) {
        [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)publicFooterTwoButtonViewWithFrame:(CGRect)frame withLeftTitle:(NSString *)leftTitle withRightTitle:(NSString *)rightTitle withTarget:(id)target withLeftSelector:(SEL)leftSelectorAction withRightSelector:(SEL)rightSelectorAction{
    self.frame=frame;
    [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
    if (target&&leftSelectorAction) {
        [self.leftButton addTarget:target action:leftSelectorAction forControlEvents:UIControlEventTouchUpInside];
    }
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
    if (target&&rightSelectorAction) {
        [self.rightButton addTarget:target action:rightSelectorAction forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
