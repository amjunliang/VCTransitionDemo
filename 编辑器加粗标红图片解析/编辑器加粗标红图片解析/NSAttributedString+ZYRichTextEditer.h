//
//  NSAttributedString+ZYRichTextEditer.h
//  编辑器加粗标红图片解析
//
//  Created by 马俊良 on 2017/12/23.
//  Copyright © 2017年 马俊良. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (ZYRichTextEditer)
- (BOOL)markRed;
- (BOOL)blod;

- (NSRange)fullRange;
@end
