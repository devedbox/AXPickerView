//
//  UINavigationBar+Separator_hidden.m
//  AXSwift2OC
//
//  Created by ai on 9/5/15.
//  Copyright © 2015 ai. All rights reserved.
//

#import "UINavigationBar+Separator_hidden.h"

@implementation UINavigationBar (Separator_hidden)
- (void)setSeparatorHidden:(BOOL)hidden {
    if ([UIDevice currentDevice].systemVersion.floatValue<10.0) {
        for (UIView *view in [self subviews]) {
            if ([view isKindOfClass:[UIImageView class]] && [[view subviews] count] > 0) {
                for (UIView *separator in view.subviews) {
                    if ([separator isKindOfClass:[UIImageView class]]) {
                        [separator setHidden:hidden];
                    }
                }
            }
        }
    } else {
        for (UIView *view in [self subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                for (UIView *separator in view.subviews) {
                    if ([separator isKindOfClass:[UIImageView class]]) {
                        [separator setHidden:hidden];
                    }
                }
            }
        }
    }
}
@end
