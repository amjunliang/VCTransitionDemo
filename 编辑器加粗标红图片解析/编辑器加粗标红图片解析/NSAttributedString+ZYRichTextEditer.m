//
//  NSAttributedString+ZYRichTextEditer.m
//  编辑器加粗标红图片解析
//
//  Created by 马俊良 on 2017/12/23.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "NSAttributedString+ZYRichTextEditer.h"

@implementation NSAttributedString (ZYRichTextEditer)

- (NSRange)fullRange
{
    return NSMakeRange(0, self.length);
    
}

- (BOOL)markRed
{
    __block BOOL res = NO;
    id compareValue = [UIColor redColor];
    [self enumerateAttribute:NSForegroundColorAttributeName inRange:[self fullRange] options:0 usingBlock:^(UIColor *value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isEqual:compareValue] && NSEqualRanges([self fullRange], range)) {
            res = YES;
        }
    }];
    
    return res;
}

- (BOOL)blod
{
    __block BOOL res = NO;
    [self enumerateAttribute:NSFontAttributeName inRange:[self fullRange] options:0 usingBlock:^(UIFont *value, NSRange range, BOOL * _Nonnull stop) {
        if (value&& NSEqualRanges([self fullRange], range)) {
            
            UIFontDescriptor *fontDescriptor = value.fontDescriptor;
            UIFontDescriptorSymbolicTraits fontDescriptorSymbolicTraits = fontDescriptor.symbolicTraits;
            BOOL isBold = (fontDescriptorSymbolicTraits & UIFontDescriptorTraitBold) != 0;
            if (isBold) {
                res = YES;
            }
        }
    }];
    
    return res;
}


@end
