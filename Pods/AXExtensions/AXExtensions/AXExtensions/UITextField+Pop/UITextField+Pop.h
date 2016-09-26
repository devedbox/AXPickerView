//
//  UITextField+Pop.h
//  AXExtensions
//
//  Created by ai on 16/5/27.
//  Copyright © 2016年 AiXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField(Pop)
/// Pop text animation speed per character. Default is 0.025. Pass a negative value to ignore.
@property(assign, nonatomic) CGFloat speed UI_APPEARANCE_SELECTOR;
/// Pop text animation total duration.
@property(assign, nonatomic) CGFloat duration UI_APPEARANCE_SELECTOR;

- (void)pop_setText:(NSString *)text;
- (void)pop_setAttributedText:(NSAttributedString *)attributedText;

- (void)pop_setPlaceholder:(NSString *)placeholder;
- (void)pop_setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder;
@end
