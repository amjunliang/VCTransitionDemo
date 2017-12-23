//
//  ZYRichTextAttachment.m
//  编辑器加粗标红图片解析
//
//  Created by 马俊良 on 2017/12/24.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import "ZYRichTextAttachment.h"

@implementation ZYRichTextAttachment

- (NSAttributedString *)attributedString
{
    NSMutableAttributedString *spaceAtt = [[NSMutableAttributedString alloc]initWithString:@" "];
    NSAttributedString *attachement = [NSAttributedString attributedStringWithAttachment:self];
    NSMutableAttributedString *mulAtt = [NSMutableAttributedString new];
    //[mulAtt appendAttributedString:spaceAtt];
    [mulAtt appendAttributedString:attachement];
   // [mulAtt appendAttributedString:spaceAtt];
    return  mulAtt;
}

- (void)setAttachedView:(UIView *)attachedView
{
    _attachedView = attachedView;
    self.bounds = attachedView.bounds;
    //self.image = [UIImage imageNamed:@"a.jpeg"];
}

- (void)dealloc
{
    [self.attachedView removeFromSuperview];
}

@end
