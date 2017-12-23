//
//  ZYRichTextAttachment.h
//  编辑器加粗标红图片解析
//
//  Created by 马俊良 on 2017/12/24.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYRichTextAttachment : NSTextAttachment

@property (nonatomic, strong)  UIView *attachedView;
@property (nonatomic, strong) id userInfo;
- (NSAttributedString *)attributedString;

@end
