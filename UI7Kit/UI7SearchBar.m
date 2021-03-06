//
//  UI7SearchBar.m
//  UI7Kit
//
//  Created by Jeong YunWon on 13. 6. 30..
//  Copyright (c) 2013 youknowone.org. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UI7Color.h"
#import "UI7SearchBar.h"


@interface UISearchBar (Private)

@property(retain) UIImage * scopeBarBackgroundImage;

@end


@interface UISearchBar (Accessor)

@property(readonly) UISegmentedControl *scopeBar;

@end


@implementation UISearchBar (Accessor)

NSAPropertyGetter(scopeBar, @"_scopeBar");

@end


@implementation UISearchBar (Patch)

- (instancetype)__initWithCoder:(NSCoder *)aDecoder { assert(NO); return nil; }
- (instancetype)__initWithFrame:(CGRect)frame { assert(NO); return nil; }

- (void)_searchBarInit {
    CGFloat height = self.frame.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(1.0, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [(UIColor *)[UIColor colorWith8bitWhite:178 alpha:255] set];
    CGContextFillRect(context, CGRectMake(.0, height - 1.0f, 1.0f, 1.0f));
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor = [UIColor colorWith8bitRed:201 green:201 blue:205 alpha:255];
    self.backgroundImage = backgroundImage;
    if (self.placeholder == nil || [self.placeholder stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]].length == 0) {
        self.placeholder = @" ";
    }

    
    UIBarButtonItem *searchBarButton = [UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil];
    [searchBarButton setBackgroundImage:[UIColor clearColor].image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [searchBarButton setTitleTextAttributes:@{UITextAttributeFont:[UIFont systemFontOfSize:16], UITextAttributeTextColor : [UIColor colorWithRed:0.286f green:0.494f blue:0.961f alpha:1.000f], UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],} forState:UIControlStateNormal];
    [searchBarButton setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor lightGrayColor], UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],} forState:UIControlStateHighlighted];

    for (UIView *searchBarSubview in [self subviews]) {
        if ([searchBarSubview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)searchBarSubview;
            textField.backgroundColor = [UIColor whiteColor];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.layer.borderColor = UIColor.clearColor.CGColor;
            textField.layer.borderWidth = 0.f;
            textField.layer.cornerRadius = 5.0f;
            textField.background = nil;
        }
    }

    self.scopeBarBackgroundImage = [self.backgroundColor image];

    {
        UIColor *tintColor = [[UI7Kit kit] tintColor];

        UISegmentedControl *segmented = self.scopeBar;
        segmented.clipsToBounds = NO;
        segmented.layer.borderWidth = .0f;
        segmented.tintColor = tintColor;
    }
}

@end


@implementation UI7SearchBar

+ (void)initialize {
    if (self == [UI7SearchBar class]) {
        Class target = [UISearchBar class];

        [target copyToSelector:@selector(__initWithCoder:) fromSelector:@selector(initWithCoder:)];
        [target copyToSelector:@selector(__initWithFrame:) fromSelector:@selector(initWithFrame:)];
    }
}

+ (void)patch {
    Class target = [UISearchBar class];

    [self exportSelector:@selector(initWithCoder:) toClass:target];
    [self exportSelector:@selector(initWithFrame:) toClass:target];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [self __initWithFrame:frame];
    if (self) {
        [self _searchBarInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self __initWithCoder:aDecoder];
    if (self != nil) {
        [self _searchBarInit];
    }
    return self;
}

@end
