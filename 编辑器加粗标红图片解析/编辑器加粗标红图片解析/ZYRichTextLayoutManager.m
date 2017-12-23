//
//  ZYRichTextLayoutManager.m
//  编辑器加粗标红图片解析
//
//  Created by 马俊良 on 2017/12/24.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "ZYRichTextLayoutManager.h"
#import "ZYRichTextAttachment.h"

@implementation ZYRichTextLayoutManager
- (void)drawGlyphsForGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)origin
{
    [super drawGlyphsForGlyphRange:glyphsToShow
                           atPoint:origin];
    
    [self.textStorage enumerateAttribute:NSAttachmentAttributeName
                                 inRange:glyphsToShow
                                 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                              usingBlock:^(ZYRichTextAttachment *value, NSRange range, BOOL * _Nonnull stop) {
                                  if ([value isKindOfClass:[ZYRichTextAttachment class]]) {
                                      CGRect rect = [self boundingRectForGlyphRange:range
                                                                    inTextContainer:[self textContainerForGlyphAtIndex:range.location
                                                                                                        effectiveRange:NULL]];
                                      rect.origin.x += origin.x;
                                      rect.origin.y += origin.y;
                                      
                                      value.attachedView.frame = rect;
                                      [UIView animateWithDuration:0.2 animations:^{
                                          value.attachedView.alpha = 1;
                                      }];
                                  }
                              }];

}

@end
