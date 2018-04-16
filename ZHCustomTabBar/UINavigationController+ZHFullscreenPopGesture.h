// The MIT License (MIT)
//
// Copyright (c) 2015-2016 
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is

#import <UIKit/UIKit.h>

@interface UINavigationController (FDFullscreenPopGesture)


@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fd_fullscreenPopGestureRecognizer;

@property (nonatomic, assign) BOOL fd_viewControllerBasedNavigationBarAppearanceEnabled;

@end

@interface UIViewController (FDFullscreenPopGesture)

@property (nonatomic, assign) BOOL fd_interactivePopDisabled;

@property (nonatomic, assign) BOOL fd_prefersNavigationBarHidden;

@property (nonatomic, assign) CGFloat fd_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end
